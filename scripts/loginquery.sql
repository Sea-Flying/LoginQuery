/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 50557
 Source Host           : localhost:3306
 Source Schema         : loginquery

 Target Server Type    : MySQL
 Target Server Version : 50557
 File Encoding         : 65001

 Date: 23/01/2018 17:56:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for computer
-- ----------------------------
DROP TABLE IF EXISTS `computer`;
CREATE TABLE `computer`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ip_1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ip_2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for map_user_pc
-- ----------------------------
DROP TABLE IF EXISTS `map_user_pc`;
CREATE TABLE `map_user_pc`  (
  `user_id` int(11) NOT NULL,
  `pc_id` int(11) NOT NULL,
  INDEX `FK_MAP_USER`(`user_id`) USING BTREE,
  INDEX `FK_MAP_PC`(`pc_id`) USING BTREE,
  CONSTRAINT `FK_MAP_USER` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_MAP_PC` FOREIGN KEY (`pc_id`) REFERENCES `computer` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for plain_list
-- ----------------------------
DROP TABLE IF EXISTS `plain_list`;
CREATE TABLE `plain_list`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `pc_id` int(11) NULL DEFAULT NULL,
  `time_con` datetime NULL DEFAULT NULL,
  `time_discon` datetime NULL DEFAULT NULL,
  `duration` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_LIST_USER`(`user_id`) USING BTREE,
  INDEX `FK_LIST_PC`(`pc_id`) USING BTREE,
  CONSTRAINT `FK_LIST_USER` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_LIST_PC` FOREIGN KEY (`pc_id`) REFERENCES `computer` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for status_1
-- ----------------------------
DROP TABLE IF EXISTS `status_1`;
CREATE TABLE `status_1`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `pc_id` int(11) NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for status_2
-- ----------------------------
DROP TABLE IF EXISTS `status_2`;
CREATE TABLE `status_2`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `pc_id` int(11) NOT NULL,
  `time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for status_3
-- ----------------------------
DROP TABLE IF EXISTS `status_3`;
CREATE TABLE `status_3`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `pc_id` int(11) NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` int(11) NOT NULL COMMENT 'User Account type(0 admin, 1 user)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Triggers structure for table status_2
-- ----------------------------
DROP TRIGGER IF EXISTS `TR1`;
delimiter ;;
CREATE TRIGGER `TR1` AFTER INSERT ON `status_2` FOR EACH ROW BEGIN
	DECLARE time_on DATETIME;
	SET time_on = (SELECT time FROM status_1 WHERE user_id=NEW.user_id AND pc_id=NEW.pc_id AND time < NEW.time LIMIT 1 );
	INSERT INTO plain_list (user_id,pc_id,time_con,time_discon,duration) VALUES (NEW.user_id,NEW.pc_id,time_on,NEW.time,TIMESTAMPDIFF(MINUTE,time_on,NEW.time));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table status_3
-- ----------------------------
DROP TRIGGER IF EXISTS `TR2`;
delimiter ;;
CREATE TRIGGER `TR2` AFTER INSERT ON `status_3` FOR EACH ROW BEGIN
	DECLARE time_on DATETIME;
	SET time_on = (SELECT time FROM status_1 WHERE user_id=NEW.user_id AND pc_id=NEW.pc_id AND time < NEW.time LIMIT 1 );
	INSERT INTO plain_list (user_id,pc_id,time_con,time_discon,duration) VALUES (NEW.user_id,NEW.pc_id,time_on,NEW.time,TIMESTAMPDIFF(MINUTE,time_on,NEW.time));
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
