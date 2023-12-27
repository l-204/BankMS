/*
 Navicat MySQL Data Transfer

 Source Server         : Mysql
 Source Server Type    : MySQL
 Source Server Version : 50610 (5.6.10)
 Source Host           : localhost:3306
 Source Schema         : bankdbs

 Target Server Type    : MySQL
 Target Server Version : 50610 (5.6.10)
 File Encoding         : 65001

 Date: 02/07/2023 05:01:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bankcardinfo
-- ----------------------------
DROP TABLE IF EXISTS `bankcardinfo`;
CREATE TABLE `bankcardinfo`  (
  `Customer_ID` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户编号',
  `Bankcard_ID` varchar(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '银行卡卡号',
  `Bankcard_Password` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '888888' COMMENT '银行卡密码',
  `Bankcard_Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '开户日期',
  `Bankcard_Balance` decimal(9, 2) NULL DEFAULT NULL COMMENT '卡内余额',
  `Bankcard_Loss` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否挂失',
  PRIMARY KEY (`Bankcard_ID`) USING BTREE,
  INDEX `FK_Customer_ID`(`Customer_ID`) USING BTREE,
  CONSTRAINT `FK_Customer_ID` FOREIGN KEY (`Customer_ID`) REFERENCES `customerinfo` (`Customer_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '银行卡表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of bankcardinfo
-- ----------------------------
INSERT INTO `bankcardinfo` VALUES ('lhr', '7574285773194482459', '888888', '2023-07-02 04:16:14', 0.00, b'0');

-- ----------------------------
-- Table structure for branchinfo
-- ----------------------------
DROP TABLE IF EXISTS `branchinfo`;
CREATE TABLE `branchinfo`  (
  `Branch_Name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分行名称',
  `Branch_City` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分行城市',
  `Branch_Asset` decimal(10, 0) NOT NULL COMMENT '分行资产',
  PRIMARY KEY (`Branch_Name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '银行分行表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of branchinfo
-- ----------------------------
INSERT INTO `branchinfo` VALUES ('中国农业银行渝中分行', '重庆', 399999900);
INSERT INTO `branchinfo` VALUES ('中国工商银行黄埔分行', '上海', 800000000);
INSERT INTO `branchinfo` VALUES ('中国建设银行朝阳分行', '北京', 600000000);
INSERT INTO `branchinfo` VALUES ('中国银行香港分行', '香港', 500000000);
INSERT INTO `branchinfo` VALUES ('中国银行麻章分行', '湛江', 100000000);
INSERT INTO `branchinfo` VALUES ('广发银行深南分行', '深圳', 500000000);
INSERT INTO `branchinfo` VALUES ('广发银行西城分行', '广州', 300000000);

-- ----------------------------
-- Table structure for businessinfo
-- ----------------------------
DROP TABLE IF EXISTS `businessinfo`;
CREATE TABLE `businessinfo`  (
  `Business_Type` int(2) NOT NULL COMMENT '业务类型 ',
  `Business_Name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '业务名称',
  `Business_Rate` decimal(9, 4) NULL DEFAULT NULL,
  `Business_Remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '业务备注',
  PRIMARY KEY (`Business_Type`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '银行业务表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of businessinfo
-- ----------------------------
INSERT INTO `businessinfo` VALUES (1, '存款', 0.0000, '活期');
INSERT INTO `businessinfo` VALUES (2, '取款', 0.0000, ' ');
INSERT INTO `businessinfo` VALUES (3, '存款', 0.0300, '定期一年');
INSERT INTO `businessinfo` VALUES (4, '存款', 0.0325, '定期二年');
INSERT INTO `businessinfo` VALUES (5, '基金', 0.0325, '低风险，低收益');
INSERT INTO `businessinfo` VALUES (6, '债券', 0.0639, '低风险，中收益');
INSERT INTO `businessinfo` VALUES (7, '股票', 0.1236, '高风险，高收益');
INSERT INTO `businessinfo` VALUES (8, '开户', 0.0000, ' ');

-- ----------------------------
-- Table structure for customerinfo
-- ----------------------------
DROP TABLE IF EXISTS `customerinfo`;
CREATE TABLE `customerinfo`  (
  `Customer_ID` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户编号',
  `Customer_Password` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户密码',
  `Customer_Name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户姓名',
  `Customer_PID` char(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户身份证号',
  `Customer_Telephone` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户手机号',
  PRIMARY KEY (`Customer_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '银行客户表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of customerinfo
-- ----------------------------
INSERT INTO `customerinfo` VALUES ('lhr', '123456', '李浩锐', '44244242', '31313113');

-- ----------------------------
-- Table structure for managerinfo
-- ----------------------------
DROP TABLE IF EXISTS `managerinfo`;
CREATE TABLE `managerinfo`  (
  `Manager_ID` int(8) NOT NULL AUTO_INCREMENT COMMENT '交易员编号',
  `Manager_Password` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '123456' COMMENT '交易员密码',
  `Manager_Name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '交易员姓名',
  `Branch_Name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '交易员所在分行',
  `Manager_Telephone` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '交易员联系方式',
  PRIMARY KEY (`Manager_ID`) USING BTREE,
  INDEX `FK_Manager_Branch`(`Branch_Name`) USING BTREE,
  CONSTRAINT `FK_Manager_Branch` FOREIGN KEY (`Branch_Name`) REFERENCES `branchinfo` (`Branch_Name`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '银行交易员表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of managerinfo
-- ----------------------------

-- ----------------------------
-- Table structure for serviceinfo
-- ----------------------------
DROP TABLE IF EXISTS `serviceinfo`;
CREATE TABLE `serviceinfo`  (
  `Bankcard_ID` varchar(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '银行卡卡号',
  `Business_Type` int(2) NOT NULL COMMENT '业务类型',
  `Service_Amount` decimal(10, 0) NOT NULL COMMENT '交易金额',
  `Branch_Name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '交易分行',
  `Service_Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '交易日期',
  `Service_Remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '交易备注',
  INDEX `FK_Bankcard_ID`(`Bankcard_ID`) USING BTREE,
  INDEX `FK_Business_Type`(`Business_Type`) USING BTREE,
  INDEX `FK_Branch_Name`(`Branch_Name`) USING BTREE,
  CONSTRAINT `FK_Bankcard_ID` FOREIGN KEY (`Bankcard_ID`) REFERENCES `bankcardinfo` (`Bankcard_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Branch_Name` FOREIGN KEY (`Branch_Name`) REFERENCES `branchinfo` (`Branch_Name`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Business_Type` FOREIGN KEY (`Business_Type`) REFERENCES `businessinfo` (`Business_Type`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '银行交易信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of serviceinfo
-- ----------------------------
INSERT INTO `serviceinfo` VALUES ('7574285773194482459', 8, 0, '中国农业银行渝中分行', '2023-07-02 04:16:14', ' ');

-- ----------------------------
-- View structure for view_customerbankcard
-- ----------------------------
DROP VIEW IF EXISTS `view_customerbankcard`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_customerbankcard` AS SELECT B.Customer_ID '用户名称', C.Customer_Name '真实姓名' , Bankcard_ID '银行卡号', Bankcard_Password '银行卡密码', Bankcard_Date '开户日期', Bankcard_Balance '卡内余额', Bankcard_Loss '是否挂失' 

FROM BankcardInfo B
JOIN CustomerInfo C
ON B.Customer_ID = C.Customer_ID
WHERE CONCAT(C.Customer_Name,'@localhost') = user() ;

-- ----------------------------
-- View structure for view_customerinfo
-- ----------------------------
DROP VIEW IF EXISTS `view_customerinfo`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_customerinfo` AS SELECT Customer_ID '用户名称', Customer_Name '真实姓名',Customer_PID '身份证号',Customer_Telephone '联系电话'
FROM CustomerInfo C ;

-- ----------------------------
-- View structure for view_loss
-- ----------------------------
DROP VIEW IF EXISTS `view_loss`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_loss` AS SELECT C.Customer_Name '客户姓名',C.Customer_Telephone '联系电话',Bankcard_ID '卡号'
FROM BankcardInfo B
INNER JOIN CustomerInfo C
ON B.Customer_ID=C.Customer_ID
WHERE B.Bankcard_Loss= b'1' ;

-- ----------------------------
-- View structure for view_managerbankcard
-- ----------------------------
DROP VIEW IF EXISTS `view_managerbankcard`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_managerbankcard` AS SELECT B.Customer_ID '客户编号', C.Customer_Name '客户姓名' ,Bankcard_ID '银行卡号', Bankcard_Password '银行卡密码', Bankcard_Date '开户日期', Bankcard_Balance '卡内余额', Bankcard_Loss '是否挂失'
FROM BankcardInfo B
JOIN CustomerInfo C
ON B.Customer_ID = C.Customer_ID ;

-- ----------------------------
-- View structure for view_managerinfo
-- ----------------------------
DROP VIEW IF EXISTS `view_managerinfo`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_managerinfo` AS SELECT Manager_ID '交易员编号', Manager_Password '交易员密码',Manager_Name '交易员姓名',Branch_Name'交易员所在分行'
FROM ManagerInfo M ;

-- ----------------------------
-- View structure for view_serviceinfo
-- ----------------------------
DROP VIEW IF EXISTS `view_serviceinfo`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_serviceinfo` AS SELECT Bankcard_ID '银行卡号' , S.Business_Type '业务类型' , B.Business_Name '业务名称' , Service_Amount '交易金额', Branch_Name '交易分行', Service_Date '交易日期' , Service_Remark '交易备注' 
FROM ServiceInfo S
JOIN BusinessInfo B
ON S.Business_Type = B.Business_Type ;

-- ----------------------------
-- View structure for view_stream
-- ----------------------------
DROP VIEW IF EXISTS `view_stream`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_stream` AS SELECT S.Business_Type 业务类型, B.Business_Name 业务名称 ,SUM(Service_Amount) 总金额 
FROM ServiceInfo S
JOIN BusinessInfo B
ON S.Business_Type = B.Business_Type
WHERE S.Business_Type=1 OR S.Business_Type=2 OR S.Business_Type=3 OR S.Business_Type=4 OR S.Business_Type=5 OR S.Business_Type=6 OR S.Business_Type=7
GROUP BY S.Business_Type ;

-- ----------------------------
-- View structure for view_thisweek
-- ----------------------------
DROP VIEW IF EXISTS `view_thisweek`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_thisweek` AS SELECT B.Customer_ID '客户编号', C.Customer_Name '客户姓名' ,Bankcard_ID '银行卡号', Bankcard_Password '银行卡密码', Bankcard_Date '开户日期', Bankcard_Balance '卡内余额', Bankcard_Loss '是否挂失'
FROM BankcardInfo B
JOIN CustomerInfo C
ON B.Customer_ID = C.Customer_ID
WHERE WEEK(Bankcard_Date)=WEEK(NOW()) ;

SET FOREIGN_KEY_CHECKS = 1;
