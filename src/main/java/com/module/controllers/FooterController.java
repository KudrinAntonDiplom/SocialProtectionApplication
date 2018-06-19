package com.module.controllers;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfWriter;
import com.module.controllers.veterandialog.VeteranDialogManager;
import com.module.database.QueryBuilder;
import com.module.helpers.CustomAlertCreator;
import com.module.model.entity.VeteranEntity;
import javafx.collections.FXCollections;
import javafx.concurrent.Task;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Scene;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Pagination;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Modality;
import javafx.stage.Stage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.stereotype.Component;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Optional;

@Component
public class FooterController {

    @Autowired
    private ConfigurableApplicationContext springContext;

    @FXML
    private TextField recordsCountField;
    @FXML
    private Pagination tableViewPagination;

    private Stage dialogStage;

    private RootManager rootManager;

    private int recordCount;

    public void setPaginationProperties() {
        recordCount = rootManager.getDatabaseWorker().getVeteransCount((new QueryBuilder().prepareSelectQuery(rootManager.getFiltersController().getFiltersMap(), -2)));
        tableViewPagination.setPageCount(recordCount / 500000 + 1);
        recordsCountField.setText(String.valueOf(recordCount));
        tableViewPagination.setPageFactory(this::createPage);
    }

    @Autowired
    public void setRootManager(RootManager rootManager) {
        this.rootManager = rootManager;
    }

    @FXML
    private void clearFiltersHandle() {
        rootManager.getFiltersController().clearAllFilters();
        setPaginationProperties();
    }

    private Node createPage(int pageIndex) {
        final Task task = new Task() {
            @Override
            protected Object call() throws Exception {
                rootManager.getMainTableController().getMainTable().setItems(
                        FXCollections.observableList(
                                rootManager.getDatabaseWorker().filterVeterans(
                                        new QueryBuilder().prepareSelectQuery(rootManager.getFiltersController().getFiltersMap(), pageIndex))));
                return null;
            }
        };
        ProgressController progressController = new ProgressController();
        try {
            progressController.showProgressIndicator(rootManager.getPrimaryStage(), task);
        } catch (IOException e) {
            e.printStackTrace();
        }

        AnchorPane anchorPane = new AnchorPane();

        return anchorPane;
    }

    @FXML
    private void handleAddVeteran() {
        VeteranEntity tempPerson = new VeteranEntity();
        boolean addButtonClicked = showVeteranDialog(tempPerson);
        if (addButtonClicked) {
            rootManager.getDatabaseWorker().saveVeteran(tempPerson);
            rootManager.getMainTableController().addToTable(tempPerson);
        }
        setPaginationProperties();
    }

    @FXML
    private void handleDeleteVeteran() {
        VeteranEntity veteranEntity = rootManager.getMainTableController().getSelectedVeteran();
        if (veteranEntity != null) {
            CustomAlertCreator customAlertCreator = new CustomAlertCreator();
            Optional<ButtonType> result = customAlertCreator.createDeleteConfirmationAlert().showAndWait();

            if (result.get() == customAlertCreator.getButtonTypeOk()) {
                rootManager.getMainTableController().getVeteransData().remove(veteranEntity);
                rootManager.getDatabaseWorker().deleteVeteran(veteranEntity);
                setPaginationProperties();
            }
        }
    }

    @FXML
    private void handleEditVeteran() {
        VeteranEntity veteranEntity = rootManager.getMainTableController().getSelectedVeteran();
        if (veteranEntity != null) {
            boolean addButtonClicked = showVeteranDialog(veteranEntity);
            if (addButtonClicked) {
                rootManager.getDatabaseWorker().saveVeteran(veteranEntity);
                rootManager.getMainTableController().refreshTable();
            }
            setPaginationProperties();
        }
    }

    @FXML
    private void handleOutVeteran(){
        VeteranEntity veteranEntity = rootManager.getMainTableController().getSelectedVeteran();
        if(veteranEntity !=null){
            Document document = new Document(PageSize.A4, 50, 50, 50, 50);
            try {
                PdfWriter writer = PdfWriter.getInstance(document,  new FileOutputStream("D:\\Itextpdf.pdf"));
                document.open();
                List l = new List(false, false, 10);
                l.add("1. Фамилия Имя Отчество " + veteranEntity.getSecondName() + veteranEntity.getFirstName()  + veteranEntity.getMiddleName());
                l.add("2. Имя " + veteranEntity.getFirstName());
                l.add("3. Отчество " + veteranEntity.getMiddleName());
                l.add("2. Дата и место рождения " + veteranEntity.getDateOfBirth() + veteranEntity.getBirthRegion()+ veteranEntity.getBirthTown());
                l.add("3. Воинское звание " + veteranEntity.getMilitaryRank());
                l.add("4. Военный билет" + veteranEntity.getMilitaryTerms());
                l.add("5. Перериод и место прохождения службы в ДРА, в/зв, должность");
                l.add(veteranEntity.getMilitaryTerms().toString()+ veteranEntity.getMilitaryRank() + veteranEntity.getSubdivision());
                if(veteranEntity.getWounds().isEmpty()){
                    l.add("6.Ранений нет");
                }else{
                    l.add("6. Раненния" + veteranEntity.getWounds().toString());
                }
                l.add("7. Награды" + veteranEntity.getVeteranHonors().toString());
                l.add("8. Домошний адресс" + veteranEntity.getAddress());
                l.add("9. Телефон" + veteranEntity.getPhoneNumber());
                l.add("10. Места работы" + veteranEntity.getWorkPlaces().toString());
                document.add(l);
                document.close();
            } catch (DocumentException e) {
                e.printStackTrace();
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            }
        }
    }

    @FXML
    private void initialize() {
        setPaginationProperties();
    }

    private boolean showVeteranDialog(VeteranEntity veteranEntity) {
        try {
            FXMLLoader fxmlLoader = new FXMLLoader(getClass().getClassLoader().getResource("view/veterandialog/VeteranDialog.fxml"));
            fxmlLoader.setControllerFactory(springContext::getBean);
            dialogStage = new Stage();
            dialogStage.getIcons().add(new Image("file:///" + System.getProperty("user.dir") + "/icon.jpg"));
            dialogStage.initModality(Modality.WINDOW_MODAL);
            dialogStage.initOwner(rootManager.getPrimaryStage());
            Scene scene = new Scene(fxmlLoader.load());
            dialogStage.setScene(scene);

            VeteranDialogManager dialogManager = fxmlLoader.getController();
            dialogManager.getFooterPaneController().setDialogStage(dialogStage);
            dialogManager.getFooterPaneController().setVeteranData(veteranEntity);
            dialogManager.getFooterPaneController().setMainDataPaneController(dialogManager.getMainDataPaneController());
            dialogManager.getTabsPaneManager().getHonorsTabController().setDialogStage(dialogStage);
            dialogManager.getTabsPaneManager().getMilitaryTermsTabController().setDialogStage(dialogStage);
            dialogManager.getTabsPaneManager().getWoundsTabController().setDialogStage(dialogStage);
            dialogManager.getTabsPaneManager().getDocumentsTabController().setDialogStage(dialogStage);
            dialogManager.getTabsPaneManager().getDisplacementsTabController().setDialogStage(dialogStage);
            dialogManager.getTabsPaneManager().getFamilyMembersTabController().setDialogStage(dialogStage);
            dialogManager.getTabsPaneManager().getWorkPlacesTabController().setDialogStage(dialogStage);
            dialogStage.showAndWait();

            return dialogManager.getFooterPaneController().isSaveClicked();
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    @FXML
    private void useFiltersHandle() {
        setPaginationProperties();
    }
}
