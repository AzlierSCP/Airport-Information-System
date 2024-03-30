SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `sno` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `salary` decimal(10, 2) NOT NULL,
  `type` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `trade_union` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`sno`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for plane
-- ----------------------------
DROP TABLE IF EXISTS `plane`;
CREATE TABLE `plane`  (
  `reg_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `model` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `capacity` int NOT NULL,
  `weight` decimal(8, 2) NOT NULL,
  PRIMARY KEY (`reg_no`) USING BTREE,
  INDEX `model`(`model`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for plane_test
-- ----------------------------
DROP TABLE IF EXISTS `plane_test`;
CREATE TABLE `plane_test`  (
  `test_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `reg_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sno` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `test_time` timestamp(0) NULL DEFAULT NULL,
  `cost_time` decimal(3, 1) NULL DEFAULT NULL,
  PRIMARY KEY (`test_no`, `reg_no`, `sno`) USING BTREE,
  INDEX `pt_test_fk`(`test_no`) USING BTREE,
  INDEX `pt_reg_fk`(`reg_no`) USING BTREE,
  INDEX `pt_sno_fk`(`sno`) USING BTREE,
  CONSTRAINT `pt_reg_fk` FOREIGN KEY (`reg_no`) REFERENCES `plane` (`reg_no`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `pt_sno_fk` FOREIGN KEY (`sno`) REFERENCES `employee` (`sno`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `pt_test_fk` FOREIGN KEY (`test_no`) REFERENCES `test` (`test_no`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for technology
-- ----------------------------
DROP TABLE IF EXISTS `technology`;
CREATE TABLE `technology`  (
  `sno` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `model` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `note` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`sno`, `model`) USING BTREE,
  INDEX `tech_ssn_fk`(`sno`) USING BTREE,
  INDEX `tech_model_fk`(`model`) USING BTREE,
  CONSTRAINT `tech_model_fk` FOREIGN KEY (`model`) REFERENCES `plane` (`model`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tech_sno_fk` FOREIGN KEY (`sno`) REFERENCES `employee` (`sno`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test`  (
  `test_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `max_score` decimal(3, 1) NOT NULL,
  PRIMARY KEY (`test_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for traffic_controller
-- ----------------------------
DROP TABLE IF EXISTS `traffic_controller`;
CREATE TABLE `traffic_controller`  (
  `sno` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `checkup_date` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`sno`) USING BTREE,
  CONSTRAINT `tc_sno_fk` FOREIGN KEY (`sno`) REFERENCES `employee` (`sno`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
