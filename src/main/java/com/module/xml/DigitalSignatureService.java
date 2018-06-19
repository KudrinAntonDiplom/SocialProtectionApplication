package com.module.xml;

import org.w3c.dom.Document;
import java.security.*;
import java.security.cert.X509Certificate;
import java.util.Collections;
import javax.xml.bind.*;
import javax.xml.crypto.*;
import javax.xml.crypto.MarshalException;
import javax.xml.crypto.dsig.*;
import javax.xml.crypto.dsig.dom.DOMSignContext;
import javax.xml.crypto.dsig.dom.DOMValidateContext;
import javax.xml.crypto.dsig.keyinfo.*;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.crypto.XMLStructure;
import javax.xml.crypto.dsig.*;
import javax.xml.crypto.dsig.dom.DOMSignContext;
import javax.xml.crypto.dsig.keyinfo.KeyInfo;
import javax.xml.crypto.dsig.keyinfo.KeyInfoFactory;
import javax.xml.crypto.dsig.keyinfo.KeyValue;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.*;
import java.security.*;
import java.security.cert.Certificate;
import java.security.cert.CertificateException;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

/**
 * Created by vergi on 13.04.2018.
 */



public class DigitalSignatureService implements Serializable {
    private KeyPairGenerator keyPairGenerator;
    private KeyPair keyPair;
    private PrivateKey privateKey;
    private PublicKey publicKey;
    private Signature signature;
    private byte[] realSign;






    public DigitalSignatureService(String keyAlg, int keyLenght, String signAlg, String provName) throws
             NoSuchAlgorithmException, NoSuchProviderException
    {

        if ((keyAlg == null) || (signAlg == null)) {
            throw new NullPointerException();
        } else {
            if (keyLenght <= 0) {
                //throw new Exception("wrong keyLenght");
            }
            keyPairGenerator = KeyPairGenerator.getInstance("RSA");
            keyPairGenerator.initialize(1024, new SecureRandom());
            keyPair = keyPairGenerator.generateKeyPair();
            publicKey = keyPair.getPublic();
            privateKey = keyPair.getPrivate();
            if (provName == null) {
                signature = Signature.getInstance("RSA");
            } else {
                signature = Signature.getInstance(signAlg, provName);
            }
        }
    }

    public DigitalSignatureService() throws
            NoSuchAlgorithmException, NoSuchProviderException
    {
            keyPairGenerator = KeyPairGenerator.getInstance("DSA");
            keyPairGenerator.initialize(512);
            keyPair = keyPairGenerator.generateKeyPair();
            publicKey = keyPair.getPublic();
            privateKey = keyPair.getPrivate();
            signature = Signature.getInstance("NONEwithRSA");
    }

    public void signingMessage(FileInputStream msgPath, FileOutputStream sgnPath) throws IOException,
            NoSuchAlgorithmException, NoSuchProviderException, InvalidKeyException, SignatureException
    {
        if ((msgPath == null) || (sgnPath == null)) {
            throw new NullPointerException();
        }


        if (privateKey == null) {
            throw new IllegalArgumentException();
        }
        signature.initSign(privateKey);


        BufferedInputStream bufRead = new BufferedInputStream(msgPath);
        byte[] byteMsg = new byte[bufRead.available()];
        bufRead.read(byteMsg);
        signature.update(byteMsg);

        bufRead.close();

        realSign = signature.sign();
        sgnPath.write(realSign);

    }

    public void signingFile(DOMResult file, File result) throws IOException, NoSuchAlgorithmException,
            NoSuchProviderException, NullPointerException, KeyException, SignatureException, TransformerException, ClassNotFoundException, IllegalAccessException, InstantiationException, MarshalException, XMLSignatureException, InvalidAlgorithmParameterException {
        if (file == null) {
            throw new NullPointerException();
        }

        String providerName = System.getProperty("jsr105Provider",
                "org.jcp.xml.dsig.internal.dom.XMLDSigRI");
        XMLSignatureFactory fac = XMLSignatureFactory.getInstance("DOM",
                (Provider) Class.forName(providerName).newInstance());

        Reference ref = fac.newReference("", fac.newDigestMethod(
                DigestMethod.SHA1, null), Collections.singletonList(fac
                        .newTransform(Transform.ENVELOPED, (XMLStructure) null)), null,
                null);


        SignedInfo si = fac.newSignedInfo(fac.newCanonicalizationMethod(
                CanonicalizationMethod.INCLUSIVE_WITH_COMMENTS, (XMLStructure) null), fac
                        .newSignatureMethod(SignatureMethod.DSA_SHA1, null),
                Collections.singletonList(ref));



        KeyInfoFactory kif = fac.getKeyInfoFactory();
        KeyValue kv = kif.newKeyValue(keyPair.getPublic());

        KeyInfo ki = kif.newKeyInfo(Collections.singletonList(kv));

        Document doc = (Document) file.getNode();

        DOMSignContext dsc = new DOMSignContext(privateKey,
                doc.getDocumentElement());

        XMLSignature signature = fac.newXMLSignature(si, ki);
        signature.sign(dsc);

        TransformerFactory tf = TransformerFactory.newInstance();
        Transformer t = tf.newTransformer();
        DOMSource source = new DOMSource(file.getNode());
        StreamResult result1 = new StreamResult(new File(result.getPath()));
        t.transform(source, result1);
    }

    public boolean verifyMessage(FileInputStream msg, FileInputStream sgn) throws InvalidKeyException,
            FileNotFoundException, IOException, SignatureException {

        if ((msg == null) || (sgn == null)) {
            throw new NullPointerException();
        }

        //Reading open text
        BufferedInputStream bufReadMsg = new BufferedInputStream(msg);
        byte[] byteMsg = new byte[bufReadMsg.available()];
        bufReadMsg.read(byteMsg);


        //Reading signature file
        BufferedInputStream bufReadSgn = new BufferedInputStream(sgn);
        byte[] byteSgn = new byte[bufReadSgn.available()];
        bufReadSgn.read(byteSgn);

        //Verifying message
        signature.initVerify(publicKey);
        signature.update(byteMsg);

        //Closing all open files
        bufReadMsg.close();
        bufReadSgn.close();

        boolean result = signature.verify(byteSgn);
        return result;
    }

    public byte[] getSign() {
        return realSign;
    }

    public void savePrivateKey(FileOutputStream file) throws IOException {

        if (file == null && privateKey == null) {
            return;
        } else {
            ObjectOutputStream objStrm = new ObjectOutputStream(file);
            objStrm.writeObject(privateKey);
            objStrm.close();
        }
    }

    public void savePublicKey(FileOutputStream file) throws IOException {

        if (file == null && publicKey == null) {
            return;
        } else {
            ObjectOutputStream objStrm = new ObjectOutputStream(file);
            objStrm.writeObject(publicKey);
            objStrm.close();
        }
    }

    public PrivateKey readPrivateKey(FileInputStream fRead) throws NullPointerException, IOException,
            ClassNotFoundException, ClassCastException
    {
        if (fRead == null) {
            throw new NullPointerException();
        } else {
            ObjectInputStream obRead = new ObjectInputStream(fRead);
            Object ob = obRead.readObject();
            if (ob instanceof PrivateKey) {
                PrivateKey privKey = (PrivateKey) ob;
                return privKey;
            }
            else {
                throw new ClassCastException();
            }
        }
    }

    public PublicKey readPublicKey(FileInputStream fRead) throws IOException,
            ClassNotFoundException, ClassCastException
    {

        if (fRead == null) {
            throw new NullPointerException();
        } else {
            ObjectInputStream obRead = new ObjectInputStream(fRead);
            Object ob = obRead.readObject();
            if (ob instanceof PublicKey) {
                PublicKey privKey = (PublicKey) ob;
                return privKey;
            }
            else {
                throw new ClassCastException();
            }
        }
    }

    public KeyPair getPair(FileInputStream in, String alias, char[] passKeyStore, char[] passAlias)
            throws KeyStoreException, IOException, CertificateException, NoSuchAlgorithmException,
            UnrecoverableEntryException{
        KeyStore ks = KeyStore.getInstance("JKS");
        ks.load(in, passKeyStore);
        Key key = ks.getKey(alias, passAlias);
        if (key instanceof PrivateKey) {
            Certificate cert = ks.getCertificate(alias);
            PublicKey publicKey = cert.getPublicKey();
            return new KeyPair(publicKey, (PrivateKey) key);
        }
        return null;
    }

    public void setPrivateKey(PrivateKey prk) {

        privateKey = prk;
    }


    public PrivateKey getPrivateKey() {

        return privateKey;
    }

    public void setPublicKey(PublicKey pbk) {

        publicKey = pbk;
    }

    public PublicKey getPublicKey() {

        return publicKey;
    }

    public boolean verifyFile(File msgPath, File sgnPath) throws Exception {

        String fileName = msgPath.getName();

        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        dbf.setNamespaceAware(true);
        Document doc = dbf.newDocumentBuilder().parse(
                new FileInputStream(msgPath));

        NodeList nl = doc.getElementsByTagNameNS(XMLSignature.XMLNS,
                "Signature");
        if (nl.getLength() == 0) {
            throw new Exception("Cannot find Signature element");
        }
        XMLSignatureFactory fac = XMLSignatureFactory.getInstance("DOM");


        DOMValidateContext valContext = new DOMValidateContext(
                new KeyValueKeySelector(), nl.item(0));

        XMLSignature signature = fac.unmarshalXMLSignature(valContext);

        boolean coreValidity = signature.validate(valContext);

        if (coreValidity == false) {
            System.err.println("Signature failed core validation");
            return  false;

        } else {
            return true;
        }
    }


    private static class KeyValueKeySelector extends KeySelector {
        public KeySelectorResult select(KeyInfo keyInfo,
                                        KeySelector.Purpose purpose, AlgorithmMethod method,
                                        XMLCryptoContext context) throws KeySelectorException {

            if (keyInfo == null) {
                throw new KeySelectorException("Null KeyInfo object!");
            }
            SignatureMethod sm = (SignatureMethod) method;
            List<?> list = keyInfo.getContent();

            for (int i = 0; i < list.size(); i++) {
                XMLStructure xmlStructure = (XMLStructure) list.get(i);
                if (xmlStructure instanceof X509Data) {
                    PublicKey pk = null;
                    List<?> l = ((X509Data) xmlStructure).getContent();
                    if (l.size() > 0) {
                        X509Certificate cert = (X509Certificate) l.get(0);
                        pk = cert.getPublicKey();
                        if (algEquals(sm.getAlgorithm(), pk.getAlgorithm())) {
                            return new SimpleKeySelectorResult(pk);
                        }
                    }
                }
                if (xmlStructure instanceof KeyValue) {
                    PublicKey pk = null;
                    try {
                        pk = ((KeyValue) xmlStructure).getPublicKey();
                    } catch (KeyException ke) {
                        throw new KeySelectorException(ke);
                    }
                    if (algEquals(sm.getAlgorithm(), pk.getAlgorithm())) {
                        return new SimpleKeySelectorResult(pk);
                    }
                }
            }
            throw new KeySelectorException("No KeyValue element found!");
        }

        static boolean algEquals(String algURI, String algName) {
            if (algName.equalsIgnoreCase("DSA")
                    && algURI.equalsIgnoreCase(SignatureMethod.DSA_SHA1)) {
                return true;
            } else if (algName.equalsIgnoreCase("RSA")
                    && algURI.equalsIgnoreCase(SignatureMethod.RSA_SHA1)) {
                return true;
            } else {
                return false;
            }
        }
    }

    private static class SimpleKeySelectorResult implements KeySelectorResult {
        private PublicKey pk;

        SimpleKeySelectorResult(PublicKey pk) {
            this.pk = pk;
        }

        public Key getKey() {
            return pk;
        }
    }

    public void savePrivateKey(File file) throws IOException {

        if (file == null) {
            return;
        } else {


            FileOutputStream fos = new FileOutputStream(file);
            ObjectOutputStream objStrm = new ObjectOutputStream(fos);
            objStrm.writeObject(privateKey);
            objStrm.close();
            fos.close();
        }
    }

    public void savePublicKey(File file) throws IOException {

        if (file == null) {
            return;
        } else {
            FileOutputStream fos = new FileOutputStream(file);
            ObjectOutputStream objStrm = new ObjectOutputStream(fos);
            objStrm.writeObject(publicKey);
            objStrm.close();
            fos.close();
        }
    }
}