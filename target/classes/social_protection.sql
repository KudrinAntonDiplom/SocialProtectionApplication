/*
Navicat MySQL Data Transfer

Source Server         : test
Source Server Version : 50721
Source Host           : localhost:3306
Source Database       : social_protection_clear_backup

Target Server Type    : MYSQL
Target Server Version : 50721
File Encoding         : 65001

Date: 2018-03-15 09:13:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `uuid` binary(16) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (0x130AC313EB4E44938E63CA35A149B042, 'Члены семей военнослужащих, погибших в мирное время при исполнении обязанностей военной службы');
INSERT INTO `categories` VALUES (0x165AFB2E3F154AD6B2EA5F7156819F9F, 'Ветераны Великой Отечественной войны,в том числе инвалиды Великой Отечественной войны');
INSERT INTO `categories` VALUES (0x261BB1C4334A42738323EA3BC7F9D084, 'Участники других боевых операций по защите Отечества');
INSERT INTO `categories` VALUES (0x72F3CFE360CB4B448358405C1A703777, 'Граждане, пострадавшие от последствий войн');
INSERT INTO `categories` VALUES (0xA8A69F89D7FA4036B52C5BF581D331F8, 'Участники ликвидации последствий катастрофы на Чернобыльской АЭС, других радиационных аварий');
INSERT INTO `categories` VALUES (0xBC999322608A4EFE99AEDE590E495448, 'Граждане, получившие инвалидность в период прохождения военной службы при исполнении обязанностей военной службы');
INSERT INTO `categories` VALUES (0xD9B3C308352540569EFC7B52BD494C5F, 'Ветераны боевых действий на территории других государств, в том числе инвалиды боевых действий на территории других государств');

-- ----------------------------
-- Table structure for displacements
-- ----------------------------
DROP TABLE IF EXISTS `displacements`;
CREATE TABLE `displacements` (
  `uuid` binary(16) NOT NULL,
  `arrived_date` date DEFAULT NULL,
  `arrived_place` varchar(150) DEFAULT NULL,
  `decreased_date` date DEFAULT NULL,
  `decreased_place` varchar(150) DEFAULT NULL,
  `veteran_uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `displacement_veteran_fk` (`veteran_uuid`) USING BTREE,
  CONSTRAINT `displacements_ibfk_1` FOREIGN KEY (`veteran_uuid`) REFERENCES `veterans` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `displacements_ibfk_2` FOREIGN KEY (`veteran_uuid`) REFERENCES `veterans` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of displacements
-- ----------------------------

-- ----------------------------
-- Table structure for districts
-- ----------------------------
DROP TABLE IF EXISTS `districts`;
CREATE TABLE `districts` (
  `uuid` binary(16) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of districts
-- ----------------------------
INSERT INTO `districts` VALUES (0x14001B106CE74C59A8A9C008DC0FC633, 'Щучинский');
INSERT INTO `districts` VALUES (0x200273DC50284D5DA417C2DC1985E02C, 'Сморгонский');
INSERT INTO `districts` VALUES (0x5521F86DE25C4DB09010450F9E0B3A02, 'Кореличский');
INSERT INTO `districts` VALUES (0x6F40CE4B2B8848C2A6CFAF3CFE08D6DE, 'Лидский');
INSERT INTO `districts` VALUES (0x8C0F87F22B59461EA230FED52E14F169, 'Островецкий');
INSERT INTO `districts` VALUES (0x8F732FB761EC46E19A2CE4376319D7BE, 'Берестовицкий');
INSERT INTO `districts` VALUES (0x9D0D4E3DF41E44ED872996BA86940E98, 'Новогрудский');
INSERT INTO `districts` VALUES (0xA4F77A8AF47449149BC43C3AD33B949C, 'Ивьевский');
INSERT INTO `districts` VALUES (0xA8A69F89D7FA4036B52C5BF581D331F8, 'Октябрьский');
INSERT INTO `districts` VALUES (0xA95417EDD3944AE5A3177297D2CBF425, 'Вороновский');
INSERT INTO `districts` VALUES (0xB362483093734F42AC421F4550A90677, 'Слонимский');
INSERT INTO `districts` VALUES (0xC4A6E746D8644923A2A86C6C463234EC, 'Волковысский');
INSERT INTO `districts` VALUES (0xD044E919E4F14BADB8D8F556F12F7C74, 'Дятловский');
INSERT INTO `districts` VALUES (0xD36763B0F9634E1B96D60CDEFF545A3A, 'Ошмянский');
INSERT INTO `districts` VALUES (0xD3C3748B1B544F6DAFD275E915484F72, 'Свислочский');
INSERT INTO `districts` VALUES (0xD9B3C308352540569EFC7B52BD494C5F, 'Ленинский');
INSERT INTO `districts` VALUES (0xE39939A338AC4C0FB2FFA8AA64152F1B, 'Мостовский');
INSERT INTO `districts` VALUES (0xE600F13AFBFA4DA6BFB83855DC09920C, 'Зельвенский');
INSERT INTO `districts` VALUES (0xE91B7AE97F614B1F93CB7142AF6C8429, 'Гродненский');

-- ----------------------------
-- Table structure for documents
-- ----------------------------
DROP TABLE IF EXISTS `documents`;
CREATE TABLE `documents` (
  `uuid` binary(16) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `series` varchar(50) DEFAULT NULL,
  `issued_by` varchar(150) DEFAULT NULL,
  `veteran_uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `document_veteran_fk` (`veteran_uuid`) USING BTREE,
  CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`veteran_uuid`) REFERENCES `veterans` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `documents_ibfk_2` FOREIGN KEY (`veteran_uuid`) REFERENCES `veterans` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of documents
-- ----------------------------

-- ----------------------------
-- Table structure for family_members
-- ----------------------------
DROP TABLE IF EXISTS `family_members`;
CREATE TABLE `family_members` (
  `uuid` binary(16) NOT NULL,
  `relation_degree` varchar(50) DEFAULT NULL,
  `full_name` varchar(150) DEFAULT NULL,
  `address` varchar(150) DEFAULT NULL,
  `phone_number` varchar(30) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `veteran_uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `member_veteran_fk` (`veteran_uuid`) USING BTREE,
  CONSTRAINT `family_members_ibfk_1` FOREIGN KEY (`veteran_uuid`) REFERENCES `veterans` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `family_members_ibfk_2` FOREIGN KEY (`veteran_uuid`) REFERENCES `veterans` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of family_members
-- ----------------------------

-- ----------------------------
-- Table structure for help
-- ----------------------------
DROP TABLE IF EXISTS `help`;
CREATE TABLE `help` (
  `uuid` binary(16) NOT NULL,
  `base` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `organization_name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `veteran_uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `help_veteran_fk` (`veteran_uuid`) USING BTREE,
  CONSTRAINT `help_ibfk_1` FOREIGN KEY (`veteran_uuid`) REFERENCES `veterans` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of help
-- ----------------------------

-- ----------------------------
-- Table structure for honors
-- ----------------------------
DROP TABLE IF EXISTS `honors`;
CREATE TABLE `honors` (
  `uuid` binary(16) NOT NULL,
  `name` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of honors
-- ----------------------------
INSERT INTO `honors` VALUES (0x03467C5EE21546A58BAAF27A6B5030B7, 'Медаль \"За победу над Японией\"');
INSERT INTO `honors` VALUES (0x12D41487DCAA4B05ACCAC397395A6EFE, 'Знак \"Жителю блокадного Ленинграда\"');
INSERT INTO `honors` VALUES (0x20B850E3EB7A46BE86F2519898052F32, 'Орден \"За службу Родине\"');
INSERT INTO `honors` VALUES (0x3AB8FC69A6C1490EB873BF4C1DB4F97D, 'Медаль \"Воину-интернационалисту от благодарного афганского народа\"');
INSERT INTO `honors` VALUES (0x58AB0CD3E2164B80B9AAA78EDD2A400E, 'Орден Отечественной войны II степени');
INSERT INTO `honors` VALUES (0x604BFF0150B64A0B90147AF8B25B83CC, 'Медаль \"За взятие Берлина\"');
INSERT INTO `honors` VALUES (0x68577A590D034B0E89C4F921BF917314, 'Медаль \"За боевые заслуги\"');
INSERT INTO `honors` VALUES (0x6D500F1A91614299A9A4CA77470AD113, 'Медаль \"За доблестный труд в Великой Отечественной войне 1941-1945 гг\"');
INSERT INTO `honors` VALUES (0x993875460E624670A0F39A8F68A449F4, 'Медаль \"За оборону Кавказа\"');
INSERT INTO `honors` VALUES (0x9D08AF5BE1B845C7BC01316D0B7D3DA7, 'Медаль \"За оборону Ленинграда\"');
INSERT INTO `honors` VALUES (0xA96F969D4FE84864ABD63402FEE8984D, 'Медаль \"За отвагу\"');
INSERT INTO `honors` VALUES (0xC9DD46BA3E364B4584BC0BD3AF930924, 'Орден Отечественной войны I степени');
INSERT INTO `honors` VALUES (0xCBCCDCDDD44342BAA3C4C09CB66D4AAC, 'Медаль \"За победу над Германией в Великой Отечественной войне 1941-1945 гг\"\"');
INSERT INTO `honors` VALUES (0xDFAD9DA36A58409AB9C42A1BE1FA15C4, 'Медаль\"За взятие Кенигсберга\"');
INSERT INTO `honors` VALUES (0xF1EEE7F546304A8A945DE05502E1734C, 'Орден Славы III степени');
INSERT INTO `honors` VALUES (0xF9C7361CB08B4E84A75A1F627968994A, 'Орден Красной Звезды');

-- ----------------------------
-- Table structure for military_terms
-- ----------------------------
DROP TABLE IF EXISTS `military_terms`;
CREATE TABLE `military_terms` (
  `uuid` binary(16) NOT NULL,
  `country` varchar(50) DEFAULT NULL,
  `locality` varchar(50) DEFAULT NULL,
  `start_of_military_service` date DEFAULT NULL,
  `end_of_military_service` date DEFAULT NULL,
  `veteran_uuid` binary(16) DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `term_veteran_fk` (`veteran_uuid`) USING BTREE,
  CONSTRAINT `military_terms_ibfk_1` FOREIGN KEY (`veteran_uuid`) REFERENCES `veterans` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `military_terms_ibfk_2` FOREIGN KEY (`veteran_uuid`) REFERENCES `veterans` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of military_terms
-- ----------------------------

-- ----------------------------
-- Table structure for ranks
-- ----------------------------
DROP TABLE IF EXISTS `ranks`;
CREATE TABLE `ranks` (
  `uuid` binary(16) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `uuid_UNIQUE` (`uuid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ranks
-- ----------------------------
INSERT INTO `ranks` VALUES (0x022AF087C3024AA3AEB3AA786DFAF442, 'ефрейтор');
INSERT INTO `ranks` VALUES (0x035C9FA842344326801E6A53913A0259, 'не имеет');
INSERT INTO `ranks` VALUES (0x205A339897AF408B9F08A28D51D68FBF, 'подполковник');
INSERT INTO `ranks` VALUES (0x306A825535084CF884DB82EFE9A8E979, 'майор');
INSERT INTO `ranks` VALUES (0x3ADAA0E14CEB4FB89186B1DFCF3A7931, 'старший лейтенант');
INSERT INTO `ranks` VALUES (0x91537ED6CB664CD1B44E36C3E7078361, 'старшина');
INSERT INTO `ranks` VALUES (0x98844DF80B1F4B53A6AB33A104AFA085, 'младший сержант');
INSERT INTO `ranks` VALUES (0xAF903FAAF4124EDA948D3291BF96E438, 'прапорщик');
INSERT INTO `ranks` VALUES (0xB4B1925A61DD4B7ABD164BE3705D570F, 'полковник');
INSERT INTO `ranks` VALUES (0xD117AF1E93DC4EC8AD9C9F7F50B840AB, 'лейтенант');
INSERT INTO `ranks` VALUES (0xDB7DA14B382C4A3F8241CDABBC993731, 'старший прапорщик');
INSERT INTO `ranks` VALUES (0xE781777751A64BB88CD164DBE15D28D7, 'старший сержант');
INSERT INTO `ranks` VALUES (0xE9226DA8320D495EB663E504D05CCDCD, 'капитан');
INSERT INTO `ranks` VALUES (0xE9547D8D8B8A4F4186B84A2E9A0B23A1, 'рядовой');
INSERT INTO `ranks` VALUES (0xF63FF218F8484743BB5688F320250CCF, 'сержант');

-- ----------------------------
-- Table structure for rgvk
-- ----------------------------
DROP TABLE IF EXISTS `rgvk`;
CREATE TABLE `rgvk` (
  `uuid` binary(16) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rgvk
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `uuid` binary(16) NOT NULL,
  `role` varchar(30) DEFAULT NULL,
  `user_uuid` binary(16) DEFAULT NULL,
  `district_uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `role_user_fk` (`user_uuid`) USING BTREE,
  KEY `role_district_fk` (`district_uuid`) USING BTREE,
  CONSTRAINT `roles_ibfk_1` FOREIGN KEY (`district_uuid`) REFERENCES `districts` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `roles_ibfk_2` FOREIGN KEY (`user_uuid`) REFERENCES `users` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (0x03E4578B5F614905A0C22F8C6E4A8170, '525-sok', 0xA40A220950E9484EBDA368DF438C52B2, 0x6F40CE4B2B8848C2A6CFAF3CFE08D6DE);
INSERT INTO `roles` VALUES (0x0543FDC5E6E44EDE9687B9F986A18F13, '490', 0x5E86584A38134F24880EEB2F19B79F8A, 0x8F732FB761EC46E19A2CE4376319D7BE);
INSERT INTO `roles` VALUES (0x0BCEB2FAE00742F2BF84E14E07FFB01B, '500-ber-prok', 0xFB595A14517B4D38B601FCD048B3805D, 0x8F732FB761EC46E19A2CE4376319D7BE);
INSERT INTO `roles` VALUES (0x1369B9DBC846432592A2332FB47082B8, '500-volk-prok', 0xFB595A14517B4D38B601FCD048B3805D, 0xC4A6E746D8644923A2A86C6C463234EC);
INSERT INTO `roles` VALUES (0x14001B106CE74C59A8A9C008DC0FC633, 'админ-Сморгонский', 0x261BB1C4334A42738323EA3BC7F9D084, 0x200273DC50284D5DA417C2DC1985E02C);
INSERT INTO `roles` VALUES (0x165AFB2E3F154AD6B2EA5F7156819F9F, 'админ-Октябрьский', 0x261BB1C4334A42738323EA3BC7F9D084, 0xA8A69F89D7FA4036B52C5BF581D331F8);
INSERT INTO `roles` VALUES (0x196612FA14A64ADF8F27EB4005C6A697, '525-pish', 0xAAE0AF88DB914571ADD2A13719C6C775, 0x6F40CE4B2B8848C2A6CFAF3CFE08D6DE);
INSERT INTO `roles` VALUES (0x1A073758CAF34FC9AC7ADCBBC5DFCF1C, '500-svis-prok', 0xFB595A14517B4D38B601FCD048B3805D, 0xD3C3748B1B544F6DAFD275E915484F72);
INSERT INTO `roles` VALUES (0x20C8DEA058074ED5AD0632703AF05E37, '500-ber-stol', 0x20C8DEA058074ED5AD0632703AF05E37, 0x8F732FB761EC46E19A2CE4376319D7BE);
INSERT INTO `roles` VALUES (0x212F2A35912C4EB195D04148F2D115BF, '530', 0x2A961BE213AE4D949579D446C371AEEA, 0xE39939A338AC4C0FB2FFA8AA64152F1B);
INSERT INTO `roles` VALUES (0x261BB1C4334A42738323EA3BC7F9D084, 'админ-Ленинский', 0x261BB1C4334A42738323EA3BC7F9D084, 0xD9B3C308352540569EFC7B52BD494C5F);
INSERT INTO `roles` VALUES (0x29403178D32146A192BE287900127A62, '535-nov', 0x0BCEB2FAE00742F2BF84E14E07FFB01B, 0x9D0D4E3DF41E44ED872996BA86940E98);
INSERT INTO `roles` VALUES (0x2A961BE213AE4D949579D446C371AEEA, '500-volk-stol', 0x20C8DEA058074ED5AD0632703AF05E37, 0xC4A6E746D8644923A2A86C6C463234EC);
INSERT INTO `roles` VALUES (0x32E8A8CF312F4F508618F30E830D71F0, '500-svis-stol', 0x20C8DEA058074ED5AD0632703AF05E37, 0xD3C3748B1B544F6DAFD275E915484F72);
INSERT INTO `roles` VALUES (0x358C897A79564F609AE813B32867659D, '535-kor', 0x0BCEB2FAE00742F2BF84E14E07FFB01B, 0x5521F86DE25C4DB09010450F9E0B3A02);
INSERT INTO `roles` VALUES (0x3FC51CC381674839BB1D2870CBEF667C, '540', 0x41232D08F6894BD88E5CC0586B1CCCFA, 0x8C0F87F22B59461EA230FED52E14F169);
INSERT INTO `roles` VALUES (0x405A71DF1C964F5DA5CE3F012D0ECF80, '545', 0xF11FC3D31591416B9AED79822334A95C, 0xD36763B0F9634E1B96D60CDEFF545A3A);
INSERT INTO `roles` VALUES (0x41232D08F6894BD88E5CC0586B1CCCFA, '495', 0x1A073758CAF34FC9AC7ADCBBC5DFCF1C, 0xA95417EDD3944AE5A3177297D2CBF425);
INSERT INTO `roles` VALUES (0x414A317D27944E3394E86F3B00AB0CF4, '550', 0x1369B9DBC846432592A2332FB47082B8, 0xD3C3748B1B544F6DAFD275E915484F72);
INSERT INTO `roles` VALUES (0x41961334EE3E44E18B4D9C5D89BC863C, '555-slon-juh', 0xF1A16FA98E7445EB80514FC3B15A5363, 0xB362483093734F42AC421F4550A90677);
INSERT INTO `roles` VALUES (0x431F2C452BEA48C98EA02675B722F9F7, '555-zel-juh', 0xF1A16FA98E7445EB80514FC3B15A5363, 0xE600F13AFBFA4DA6BFB83855DC09920C);
INSERT INTO `roles` VALUES (0x4EC9361FBDE0435AA9EF8FFF41B70089, '555-slon-kor', 0xAA1C8CB307F9467C92B9ACD868119E59, 0xB362483093734F42AC421F4550A90677);
INSERT INTO `roles` VALUES (0x5521F86DE25C4DB09010450F9E0B3A02, 'админ-Кореличский', 0x261BB1C4334A42738323EA3BC7F9D084, 0x5521F86DE25C4DB09010450F9E0B3A02);
INSERT INTO `roles` VALUES (0x586C529E0BA04AFDB76666DEC1716FDD, '480-gro-gon', 0x6A1308F0A234402F9C6ABA80C534A4BA, 0xE91B7AE97F614B1F93CB7142AF6C8429);
INSERT INTO `roles` VALUES (0x5E86584A38134F24880EEB2F19B79F8A, '480-len-gon', 0x6A1308F0A234402F9C6ABA80C534A4BA, 0xD9B3C308352540569EFC7B52BD494C5F);
INSERT INTO `roles` VALUES (0x627E779B8C0348C298C539A94BAC6B4B, 'админ-Щучинский', 0x261BB1C4334A42738323EA3BC7F9D084, 0x14001B106CE74C59A8A9C008DC0FC633);
INSERT INTO `roles` VALUES (0x66FFD5E4C3C34CB79E2E4F41D7B6157D, '480-okt-gon', 0x6A1308F0A234402F9C6ABA80C534A4BA, 0xA8A69F89D7FA4036B52C5BF581D331F8);
INSERT INTO `roles` VALUES (0x6A1308F0A234402F9C6ABA80C534A4BA, '480-gro-koj', 0xBB115D1290344AD38EA50324EE162517, 0xE91B7AE97F614B1F93CB7142AF6C8429);
INSERT INTO `roles` VALUES (0x6F34E27CCD7D4A11BA2B519710C73BDE, '555-zel-kor', 0xAA1C8CB307F9467C92B9ACD868119E59, 0xE600F13AFBFA4DA6BFB83855DC09920C);
INSERT INTO `roles` VALUES (0x6F40CE4B2B8848C2A6CFAF3CFE08D6DE, 'админ-Лидский', 0x261BB1C4334A42738323EA3BC7F9D084, 0x6F40CE4B2B8848C2A6CFAF3CFE08D6DE);
INSERT INTO `roles` VALUES (0x70D353DDFB2247338073C5D2C319314D, '480-len-koj', 0xBB115D1290344AD38EA50324EE162517, 0xD9B3C308352540569EFC7B52BD494C5F);
INSERT INTO `roles` VALUES (0x81E37DE798F247AD948069424DF91576, '560', 0x586C529E0BA04AFDB76666DEC1716FDD, 0x200273DC50284D5DA417C2DC1985E02C);
INSERT INTO `roles` VALUES (0x84DD0354F6274432B548831268832FA5, '565', 0xB0D068DB4AE84ED4BD24F45836EA2385, 0x14001B106CE74C59A8A9C008DC0FC633);
INSERT INTO `roles` VALUES (0x8C0F87F22B59461EA230FED52E14F169, 'админ-Островецкий', 0x261BB1C4334A42738323EA3BC7F9D084, 0x8C0F87F22B59461EA230FED52E14F169);
INSERT INTO `roles` VALUES (0x8F732FB761EC46E19A2CE4376319D7BE, 'админ-Берестовицкий', 0x261BB1C4334A42738323EA3BC7F9D084, 0x8F732FB761EC46E19A2CE4376319D7BE);
INSERT INTO `roles` VALUES (0x9D0D4E3DF41E44ED872996BA86940E98, 'админ-Новогрудский', 0x261BB1C4334A42738323EA3BC7F9D084, 0x9D0D4E3DF41E44ED872996BA86940E98);
INSERT INTO `roles` VALUES (0xA40A220950E9484EBDA368DF438C52B2, '480-okt-koj', 0xBB115D1290344AD38EA50324EE162517, 0xA8A69F89D7FA4036B52C5BF581D331F8);
INSERT INTO `roles` VALUES (0xA4F77A8AF47449149BC43C3AD33B949C, 'админ-Ивьевский', 0x261BB1C4334A42738323EA3BC7F9D084, 0xA4F77A8AF47449149BC43C3AD33B949C);
INSERT INTO `roles` VALUES (0xA57E26B953FE435482033733C98DB4FA, '480-gro-fur', 0x0543FDC5E6E44EDE9687B9F986A18F13, 0xE91B7AE97F614B1F93CB7142AF6C8429);
INSERT INTO `roles` VALUES (0xA95417EDD3944AE5A3177297D2CBF425, 'админ-Вороновский', 0x261BB1C4334A42738323EA3BC7F9D084, 0xA95417EDD3944AE5A3177297D2CBF425);
INSERT INTO `roles` VALUES (0xAA1C8CB307F9467C92B9ACD868119E59, '480-len-fur', 0x0543FDC5E6E44EDE9687B9F986A18F13, 0xD9B3C308352540569EFC7B52BD494C5F);
INSERT INTO `roles` VALUES (0xAAE0AF88DB914571ADD2A13719C6C775, '480-okt-fur', 0x0543FDC5E6E44EDE9687B9F986A18F13, 0xA8A69F89D7FA4036B52C5BF581D331F8);
INSERT INTO `roles` VALUES (0xB0D068DB4AE84ED4BD24F45836EA2385, '480-gro-tar', 0xE8DEC0008399405691614F6FD2C9A9E1, 0xE91B7AE97F614B1F93CB7142AF6C8429);
INSERT INTO `roles` VALUES (0xB362483093734F42AC421F4550A90677, 'админ-Слонимский', 0x261BB1C4334A42738323EA3BC7F9D084, 0xB362483093734F42AC421F4550A90677);
INSERT INTO `roles` VALUES (0xBB115D1290344AD38EA50324EE162517, '480-len-tar', 0xE8DEC0008399405691614F6FD2C9A9E1, 0xD9B3C308352540569EFC7B52BD494C5F);
INSERT INTO `roles` VALUES (0xC4A6E746D8644923A2A86C6C463234EC, 'админ-Волковысский', 0x261BB1C4334A42738323EA3BC7F9D084, 0xC4A6E746D8644923A2A86C6C463234EC);
INSERT INTO `roles` VALUES (0xD044E919E4F14BADB8D8F556F12F7C74, 'админ-Дятловский', 0x261BB1C4334A42738323EA3BC7F9D084, 0xD044E919E4F14BADB8D8F556F12F7C74);
INSERT INTO `roles` VALUES (0xD36763B0F9634E1B96D60CDEFF545A3A, 'админ-Ошмянский', 0x261BB1C4334A42738323EA3BC7F9D084, 0xD36763B0F9634E1B96D60CDEFF545A3A);
INSERT INTO `roles` VALUES (0xD3C3748B1B544F6DAFD275E915484F72, 'админ-Свислочский', 0x261BB1C4334A42738323EA3BC7F9D084, 0xD3C3748B1B544F6DAFD275E915484F72);
INSERT INTO `roles` VALUES (0xD9B3C308352540569EFC7B52BD494C5F, 'админ-Мостовский', 0x261BB1C4334A42738323EA3BC7F9D084, 0xE39939A338AC4C0FB2FFA8AA64152F1B);
INSERT INTO `roles` VALUES (0xE600F13AFBFA4DA6BFB83855DC09920C, 'админ-Зельвенский', 0x261BB1C4334A42738323EA3BC7F9D084, 0xE600F13AFBFA4DA6BFB83855DC09920C);
INSERT INTO `roles` VALUES (0xE8DEC0008399405691614F6FD2C9A9E1, '480-okt-tar', 0xE8DEC0008399405691614F6FD2C9A9E1, 0xA8A69F89D7FA4036B52C5BF581D331F8);
INSERT INTO `roles` VALUES (0xE91B7AE97F614B1F93CB7142AF6C8429, 'админ-Гродненский', 0x261BB1C4334A42738323EA3BC7F9D084, 0xE91B7AE97F614B1F93CB7142AF6C8429);
INSERT INTO `roles` VALUES (0xF11FC3D31591416B9AED79822334A95C, '505', 0x66FFD5E4C3C34CB79E2E4F41D7B6157D, 0xD044E919E4F14BADB8D8F556F12F7C74);
INSERT INTO `roles` VALUES (0xF1A16FA98E7445EB80514FC3B15A5363, '510', 0xA57E26B953FE435482033733C98DB4FA, 0xE600F13AFBFA4DA6BFB83855DC09920C);
INSERT INTO `roles` VALUES (0xF37F546BF166401DA245BCE7DEA37B05, '520', 0x70D353DDFB2247338073C5D2C319314D, 0xA4F77A8AF47449149BC43C3AD33B949C);
INSERT INTO `roles` VALUES (0xFB595A14517B4D38B601FCD048B3805D, '515', 0x32E8A8CF312F4F508618F30E830D71F0, 0x5521F86DE25C4DB09010450F9E0B3A02);

-- ----------------------------
-- Table structure for subcategories
-- ----------------------------
DROP TABLE IF EXISTS `subcategories`;
CREATE TABLE `subcategories` (
  `uuid` binary(16) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `category_uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `sub_category_fk` (`category_uuid`) USING BTREE,
  CONSTRAINT `subcategories_ibfk_1` FOREIGN KEY (`category_uuid`) REFERENCES `categories` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `subcategories_ibfk_2` FOREIGN KEY (`category_uuid`) REFERENCES `categories` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of subcategories
-- ----------------------------
INSERT INTO `subcategories` VALUES (0x0A3C9824FFD44886A1EACEAA9AF20758, 'Члены семей, погибших (умерших) в годы ВОв', 0x72F3CFE360CB4B448358405C1A703777);
INSERT INTO `subcategories` VALUES (0x1707E156922842D99EC499E6654133DA, 'Ветераны боевых действий на территории других государств', 0xD9B3C308352540569EFC7B52BD494C5F);
INSERT INTO `subcategories` VALUES (0x1D3EC9D81FCC40C6864A8853D1C60CA6, 'Бывшие узники фашистских концлагерей (совершеннолетние)', 0x72F3CFE360CB4B448358405C1A703777);
INSERT INTO `subcategories` VALUES (0x23CFD3ABA4EA40A4A9FF3E1B77327A96, 'Инвалиды боевых действий на территории других государств', 0xD9B3C308352540569EFC7B52BD494C5F);
INSERT INTO `subcategories` VALUES (0x27431E912F894D37901912F9645A5866, 'Инвалиды с детства (последствия военных действий)', 0x72F3CFE360CB4B448358405C1A703777);
INSERT INTO `subcategories` VALUES (0x3A82FB07614E403D85EF47B2E892ECD9, 'Статья 20', 0xA8A69F89D7FA4036B52C5BF581D331F8);
INSERT INTO `subcategories` VALUES (0x4B586618324142FC8B52D04AB8422F29, 'Участники ликвидации последствий катастрофы на Чернобыльской АЭС', 0xA8A69F89D7FA4036B52C5BF581D331F8);
INSERT INTO `subcategories` VALUES (0x5D50D62D53F0479EBA07C190FAC1E77B, 'Статья 18', 0xA8A69F89D7FA4036B52C5BF581D331F8);
INSERT INTO `subcategories` VALUES (0x5DE607D9F672438BB8E699BF8B25BAFE, 'Участники ВОв', 0x165AFB2E3F154AD6B2EA5F7156819F9F);
INSERT INTO `subcategories` VALUES (0x69B66C51D77F40479ECA901F8CC16D7F, 'Статья 19', 0xA8A69F89D7FA4036B52C5BF581D331F8);
INSERT INTO `subcategories` VALUES (0x6A7212043D0B4F329CBEBFAFA0E01AA6, 'Бывшие узники фашистских концлагерей (несовершеннолетние)', 0x72F3CFE360CB4B448358405C1A703777);
INSERT INTO `subcategories` VALUES (0x94ACFDD7F25B49C7AF44C476D94E2939, 'Инвалиды ВОв', 0x165AFB2E3F154AD6B2EA5F7156819F9F);
INSERT INTO `subcategories` VALUES (0xB66694405B11458A9E2355414A01E13E, 'Члены семей военнослужащих, погибших в мирное время при исполнении обязанностей военной службы', 0xD9B3C308352540569EFC7B52BD494C5F);
INSERT INTO `subcategories` VALUES (0xBA690BC5B5804AF394E12A527D8F634C, 'Награжденные', 0x165AFB2E3F154AD6B2EA5F7156819F9F);
INSERT INTO `subcategories` VALUES (0xBAF87E50625143D2AAC055DE020A029A, 'Приравненные к ветеранам ВОв', 0x165AFB2E3F154AD6B2EA5F7156819F9F);
INSERT INTO `subcategories` VALUES (0xBFAEA39D678E4DA3AA406BE84945C7B3, 'Граждане, получившие инвалидность в период прохождения военной службы при исполнении обязанностей военной службы', 0xD9B3C308352540569EFC7B52BD494C5F);
INSERT INTO `subcategories` VALUES (0xD566BCD9739949FCAE441CC16ACADD55, 'Члены семей, умерших вследствие заболеваний, вызванных катастрофой на Чернобыльской АЭС, другими радиационными авариями', 0xA8A69F89D7FA4036B52C5BF581D331F8);
INSERT INTO `subcategories` VALUES (0xE800F41F27D64CA988BC86021D1FBDA7, 'Блокадники', 0x165AFB2E3F154AD6B2EA5F7156819F9F);
INSERT INTO `subcategories` VALUES (0xF236E390BFCC48918D48F6B1767765C4, 'Работники, направляющиеся в Афганистан', 0xD9B3C308352540569EFC7B52BD494C5F);
INSERT INTO `subcategories` VALUES (0xFD7ACDF9004247A5BB790857E1384748, 'Участники ликвидации других радиационных аварий', 0xA8A69F89D7FA4036B52C5BF581D331F8);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `uuid` binary(16) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (0x0543FDC5E6E44EDE9687B9F986A18F13, 'Furman480', 'M/nfl7PBLYunYwWGkxEBYw==');
INSERT INTO `users` VALUES (0x0BCEB2FAE00742F2BF84E14E07FFB01B, 'Drapalo535', 'CVmYNOEPQn/rTA0Yo30V3w==');
INSERT INTO `users` VALUES (0x1369B9DBC846432592A2332FB47082B8, 'Bebeh550', 'PnqI80XPvyTDtqS/zeaEPQ==');
INSERT INTO `users` VALUES (0x1A073758CAF34FC9AC7ADCBBC5DFCF1C, 'Urbanovich495', 'F3MDf0yIOZfn6ru+8VyDMg==');
INSERT INTO `users` VALUES (0x20C8DEA058074ED5AD0632703AF05E37, 'Stoljarevskaja500', 'vCBLOC9szHDgoyBftacwjg==');
INSERT INTO `users` VALUES (0x261BB1C4334A42738323EA3BC7F9D084, 'Admin', 'c0sA5YKBxoA++iklz9eqyA==');
INSERT INTO `users` VALUES (0x2A961BE213AE4D949579D446C371AEEA, 'Zhivushko530', 'oz2SYxrpeMqZkDSS7BxSMQ==');
INSERT INTO `users` VALUES (0x32E8A8CF312F4F508618F30E830D71F0, 'Tisevich515', 'fl24rWoruZoywTqvo9N6uA==');
INSERT INTO `users` VALUES (0x41232D08F6894BD88E5CC0586B1CCCFA, 'Trejgis540', 'Wvfrd0C8ZohkjDkmw/cYoA==');
INSERT INTO `users` VALUES (0x586C529E0BA04AFDB76666DEC1716FDD, 'Gruzhevskaja560', 'tcdT3d9COBB50pMQGP1cWw==');
INSERT INTO `users` VALUES (0x5E86584A38134F24880EEB2F19B79F8A, 'Litvinovich490', 'pZGnzLV5zfX77sn2eTm6Cg==');
INSERT INTO `users` VALUES (0x66FFD5E4C3C34CB79E2E4F41D7B6157D, 'Obuhov505', 'byginF1VgLjKiZs9A587xw==');
INSERT INTO `users` VALUES (0x6A1308F0A234402F9C6ABA80C534A4BA, 'Goncharuk480', '5Tt8+nBZg2Qg1DBz/ZT+aA==');
INSERT INTO `users` VALUES (0x70D353DDFB2247338073C5D2C319314D, 'Makucevich520', 'XJZSbgf67FOP7mP5ZfPclA==');
INSERT INTO `users` VALUES (0xA40A220950E9484EBDA368DF438C52B2, 'Sokolova525', 'hlT5iwpovzfqdy05MWKsug==');
INSERT INTO `users` VALUES (0xA57E26B953FE435482033733C98DB4FA, 'Proskurskaja510', 'BAznXerObpvS99Vga01dlg==');
INSERT INTO `users` VALUES (0xAA1C8CB307F9467C92B9ACD868119E59, 'Korejvo555', 'z91JdXM/2Ew8mWzPPz6RKA==');
INSERT INTO `users` VALUES (0xAAE0AF88DB914571ADD2A13719C6C775, 'Pishhik525', '/1mYTjr9qgwW15iObbqp3Q==');
INSERT INTO `users` VALUES (0xB0D068DB4AE84ED4BD24F45836EA2385, 'Sugaj565', 'GnRQMwO1ONu/TpH6gl3okg==');
INSERT INTO `users` VALUES (0xBB115D1290344AD38EA50324EE162517, 'Kojro480', 'suldHb3qj+4QUm/S/aREzQ==');
INSERT INTO `users` VALUES (0xE8DEC0008399405691614F6FD2C9A9E1, 'Tarasenko480', 'UICtt0Llb8gf1GoKpWyXdQ==');
INSERT INTO `users` VALUES (0xF11FC3D31591416B9AED79822334A95C, 'Borzenkova545', 'vPnYA4nJJ+89q11neHkeRA==');
INSERT INTO `users` VALUES (0xF1A16FA98E7445EB80514FC3B15A5363, 'Juhimenko555', 'fTUenQqyHL6iamCxhUMObQ==');
INSERT INTO `users` VALUES (0xFB595A14517B4D38B601FCD048B3805D, 'Prokopchik500', '6t2mCsqrE6pOtEXeszvdyw==');

-- ----------------------------
-- Table structure for veterans
-- ----------------------------
DROP TABLE IF EXISTS `veterans`;
CREATE TABLE `veterans` (
  `uuid` binary(16) NOT NULL,
  `first_name` varchar(50) DEFAULT '',
  `second_name` varchar(50) DEFAULT '',
  `middle_name` varchar(50) DEFAULT '',
  `rank_uuid` binary(16) DEFAULT NULL,
  `district_uuid` binary(16) DEFAULT NULL,
  `category_uuid` binary(16) DEFAULT NULL,
  `subcategory_uuid` binary(16) DEFAULT NULL,
  `case_number` varchar(100) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `subdivision` varchar(255) DEFAULT '',
  `regional_executive_committee` varchar(255) DEFAULT '',
  `village_executive_committee` varchar(255) DEFAULT '',
  `address` varchar(255) DEFAULT '',
  `registration_address` varchar(255) DEFAULT '',
  `phone_number` varchar(30) DEFAULT '',
  `marching_organization` varchar(255) DEFAULT '',
  `is_dead` tinyint(1) DEFAULT '0',
  `is_alone` tinyint(1) DEFAULT NULL,
  `burial_place` varchar(255) DEFAULT '',
  `date_of_death` date DEFAULT NULL,
  `position` varchar(255) DEFAULT '',
  `photo` blob,
  `rgvk_uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `veterans_uuid_uindex` (`uuid`) USING BTREE,
  KEY `veteran_category_fk` (`category_uuid`,`rank_uuid`) USING BTREE,
  KEY `veteran_rank_fk` (`rank_uuid`,`district_uuid`) USING BTREE,
  KEY `veteran_sub` (`subcategory_uuid`,`rank_uuid`) USING BTREE,
  KEY `veteran_district_fk` (`district_uuid`,`rank_uuid`) USING BTREE,
  KEY `veteran_rgvk_fk` (`rgvk_uuid`) USING BTREE,
  CONSTRAINT `veterans_ibfk_1` FOREIGN KEY (`rank_uuid`) REFERENCES `ranks` (`uuid`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `veterans_ibfk_2` FOREIGN KEY (`subcategory_uuid`) REFERENCES `subcategories` (`uuid`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `veterans_ibfk_3` FOREIGN KEY (`district_uuid`) REFERENCES `districts` (`uuid`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `veterans_ibfk_4` FOREIGN KEY (`category_uuid`) REFERENCES `categories` (`uuid`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `veterans_ibfk_5` FOREIGN KEY (`category_uuid`) REFERENCES `categories` (`uuid`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `veterans_ibfk_6` FOREIGN KEY (`district_uuid`) REFERENCES `districts` (`uuid`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `veterans_ibfk_7` FOREIGN KEY (`rank_uuid`) REFERENCES `ranks` (`uuid`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `veterans_ibfk_8` FOREIGN KEY (`rgvk_uuid`) REFERENCES `rgvk` (`uuid`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `veterans_ibfk_9` FOREIGN KEY (`subcategory_uuid`) REFERENCES `subcategories` (`uuid`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of veterans
-- ----------------------------

-- ----------------------------
-- Table structure for veteran_honors
-- ----------------------------
DROP TABLE IF EXISTS `veteran_honors`;
CREATE TABLE `veteran_honors` (
  `uuid` binary(16) NOT NULL,
  `veteran_uuid` binary(16) DEFAULT NULL,
  `honor_uuid` binary(16) DEFAULT NULL,
  `decree` varchar(255) DEFAULT NULL,
  `date_of_receiving` date DEFAULT NULL,
  `honor_series` varchar(50) DEFAULT NULL,
  `honor_number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `honors_veteran_fk` (`veteran_uuid`) USING BTREE,
  KEY `honors_honor_fk` (`honor_uuid`) USING BTREE,
  CONSTRAINT `veteran_honors_ibfk_1` FOREIGN KEY (`honor_uuid`) REFERENCES `honors` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `veteran_honors_ibfk_2` FOREIGN KEY (`veteran_uuid`) REFERENCES `veterans` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of veteran_honors
-- ----------------------------

-- ----------------------------
-- Table structure for veteran_wounds
-- ----------------------------
DROP TABLE IF EXISTS `veteran_wounds`;
CREATE TABLE `veteran_wounds` (
  `uuid` binary(16) NOT NULL,
  `date` date DEFAULT NULL,
  `veteran_uuid` binary(16) DEFAULT NULL,
  `disability_uuid` binary(16) DEFAULT NULL,
  `type_uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `wound_veteran_fk` (`veteran_uuid`) USING BTREE,
  KEY `FK7lm715cjv7o51227m2qr221kq` (`disability_uuid`) USING BTREE,
  KEY `FKar545h8a4iy6i6ru5pmuratwv` (`type_uuid`) USING BTREE,
  CONSTRAINT `veteran_wounds_ibfk_1` FOREIGN KEY (`disability_uuid`) REFERENCES `wound_disabilities` (`uuid`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `veteran_wounds_ibfk_2` FOREIGN KEY (`type_uuid`) REFERENCES `wound_types` (`uuid`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `veteran_wounds_ibfk_3` FOREIGN KEY (`veteran_uuid`) REFERENCES `veterans` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of veteran_wounds
-- ----------------------------

-- ----------------------------
-- Table structure for work_places
-- ----------------------------
DROP TABLE IF EXISTS `work_places`;
CREATE TABLE `work_places` (
  `uuid` binary(16) NOT NULL,
  `organization` varchar(255) DEFAULT NULL,
  `locality` varchar(150) DEFAULT NULL,
  `hr_number` varchar(50) DEFAULT NULL,
  `veteran_uuid` binary(16) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `workPlace_veteran_fk` (`veteran_uuid`) USING BTREE,
  CONSTRAINT `work_places_ibfk_1` FOREIGN KEY (`veteran_uuid`) REFERENCES `veterans` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of work_places
-- ----------------------------

-- ----------------------------
-- Table structure for wound_disabilities
-- ----------------------------
DROP TABLE IF EXISTS `wound_disabilities`;
CREATE TABLE `wound_disabilities` (
  `uuid` binary(16) NOT NULL,
  `disability` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wound_disabilities
-- ----------------------------
INSERT INTO `wound_disabilities` VALUES (0x39AF788FABB048D1AB8F9F8B5C9E9EE7, 'I группа');
INSERT INTO `wound_disabilities` VALUES (0xC5B3E67B81E749EDB8E75127966705FF, 'II группа');
INSERT INTO `wound_disabilities` VALUES (0xD91F17376D364B178C19CA7965F9E69E, 'III группа');

-- ----------------------------
-- Table structure for wound_types
-- ----------------------------
DROP TABLE IF EXISTS `wound_types`;
CREATE TABLE `wound_types` (
  `uuid` binary(16) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wound_types
-- ----------------------------
INSERT INTO `wound_types` VALUES (0x08500905BBAC427CAD87ECA76C895AF2, 'контузия');
INSERT INTO `wound_types` VALUES (0x4D38C7F8DC8F43C486E295983A92BD42, 'тяжелое ранение');
INSERT INTO `wound_types` VALUES (0xB482E76A8812400CB678D3D5DFA92CB5, 'легкое ранение');
SET FOREIGN_KEY_CHECKS=1;
