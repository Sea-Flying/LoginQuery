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

 Date: 05/09/2018 19:25:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for monitor_last_login_query_time
-- ----------------------------
DROP TABLE IF EXISTS `monitor_last_login_query_time`;
CREATE TABLE `monitor_last_login_query_time`  (
  `time` datetime NOT NULL DEFAULT '1970-01-01 08:00:00'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;
INSERT INTO monitor_last_login_query_time VALUES ('1970-01-01 08:00:00');

-- ----------------------------
-- Table structure for monitor_users
-- ----------------------------
DROP TABLE IF EXISTS `monitor_users`;
CREATE TABLE `monitor_users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `display` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` int(11) NOT NULL COMMENT 'User Account type(0 admin, 1 user)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for monitor_pcs
-- ----------------------------
DROP TABLE IF EXISTS `monitor_pcs`;
CREATE TABLE `monitor_pcs`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ip_1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ip_2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for monitor_map_user_pc
-- ----------------------------
DROP TABLE IF EXISTS `monitor_map_user_pc`;
CREATE TABLE `monitor_map_user_pc`  (
  `user_id` int(11) NOT NULL,
  `pc_id` int(11) NOT NULL,
  INDEX `FK_MAP_USER_PC_USERID`(`user_id`) USING BTREE,
  INDEX `FK_MAP_USER_PC_PCID`(`pc_id`) USING BTREE,
  CONSTRAINT `FK_MAP_USER_PC_USERID` FOREIGN KEY (`user_id`) REFERENCES `monitor_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_MAP_USER_PC_PCID` FOREIGN KEY (`pc_id`) REFERENCES `monitor_pcs` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for monitor_status_1
-- ----------------------------
DROP TABLE IF EXISTS `monitor_status_1`;
CREATE TABLE `monitor_status_1`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `pc_id` int(11) NOT NULL,
  `ip_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_STATUS_1_USERID`(`user_id`) USING BTREE,
  INDEX `FK_STATUS_1_PCID`(`pc_id`) USING BTREE,
  CONSTRAINT `FK_STATUS_1_USERID` FOREIGN KEY (`user_id`) REFERENCES `monitor_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_STATUS_1_PCID` FOREIGN KEY (`pc_id`) REFERENCES `monitor_pcs` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for monitor_status_2
-- ----------------------------
DROP TABLE IF EXISTS `monitor_status_2`;
CREATE TABLE `monitor_status_2`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `pc_id` int(11) NOT NULL,
  `ip_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_STATUS_2_PCID`(`pc_id`) USING BTREE,
  INDEX `FK_STATUS_2_USERID`(`user_id`) USING BTREE,
  CONSTRAINT `FK_STATUS_2_PCID` FOREIGN KEY (`pc_id`) REFERENCES `monitor_pcs` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_STATUS_2_USERID` FOREIGN KEY (`user_id`) REFERENCES `monitor_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for monitor_status_3
-- ----------------------------
DROP TABLE IF EXISTS `monitor_status_3`;
CREATE TABLE `monitor_status_3`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `pc_id` int(11) NOT NULL,
  `ip_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_STATUS_3_PCID`(`pc_id`) USING BTREE,
  INDEX `FK_STATUS_3_USERID`(`user_id`) USING BTREE,
  CONSTRAINT `FK_STATUS_3_PCID` FOREIGN KEY (`pc_id`) REFERENCES `monitor_pcs` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_STATUS_3_USERID` FOREIGN KEY (`user_id`) REFERENCES `monitor_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for monitor_login_record
-- ----------------------------
DROP TABLE IF EXISTS `monitor_login_record`;
CREATE TABLE `monitor_login_record`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `pc_id` int(11) NOT NULL,
  `ip_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `time_con` datetime NULL DEFAULT NULL,
  `time_discon` datetime NULL DEFAULT NULL,
  `duration` bigint(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_lOGIN_RECORD_PC`(`pc_id`) USING BTREE,
  INDEX `FK_lOGIN_RECORD_USER`(`user_id`) USING BTREE,
  CONSTRAINT `FK_lOGIN_RECORD_PC` FOREIGN KEY (`pc_id`) REFERENCES `monitor_pcs` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_lOGIN_RECORD_USER` FOREIGN KEY (`user_id`) REFERENCES `monitor_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- View structure for v_last_con_time
-- ----------------------------
DROP VIEW IF EXISTS `v_last_con_time`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `v_last_con_time` AS select `monitor_users`.`name` AS `user`,`monitor_pcs`.`name` AS `pc`,`monitor_status_1`.`ip_address` AS `ip`,max(`monitor_status_1`.`time`) AS `last_con_time`,`monitor_users`.`type` AS `type` from ((`monitor_status_1` join `monitor_pcs` on((`monitor_status_1`.`pc_id` = `monitor_pcs`.`id`))) join `monitor_users` on((`monitor_status_1`.`user_id` = `monitor_users`.`id`))) group by `monitor_users`.`name`,`monitor_pcs`.`name`;

-- ----------------------------
-- View structure for v_last_s1_time
-- ----------------------------
DROP VIEW IF EXISTS `v_last_s1_time`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `v_last_s1_time` AS select `monitor_users`.`name` AS `user`,max(`monitor_status_1`.`time`) AS `time`,`monitor_users`.`type` AS `type`,`monitor_status_1`.`ip_address` AS `ip` from (`monitor_status_1` join `monitor_users` on((`monitor_status_1`.`user_id` = `monitor_users`.`id`))) group by `monitor_users`.`id`;

-- ----------------------------
-- View structure for v_last_s2_time
-- ----------------------------
DROP VIEW IF EXISTS `v_last_s2_time`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `v_last_s2_time` AS select `monitor_users`.`name` AS `user`,max(`monitor_status_2`.`time`) AS `time`,`monitor_users`.`type` AS `type`,`monitor_status_2`.`ip_address` AS `ip` from (`monitor_status_2` join `monitor_users` on((`monitor_status_2`.`user_id` = `monitor_users`.`id`))) group by `monitor_users`.`name`;

-- ----------------------------
-- View structure for v_last_s3_time
-- ----------------------------
DROP VIEW IF EXISTS `v_last_s3_time`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `v_last_s3_time` AS select `monitor_users`.`name` AS `user`,max(`monitor_status_3`.`time`) AS `time`,`monitor_users`.`type` AS `type`,`monitor_status_3`.`ip_address` AS `ip` from (`monitor_status_3` join `monitor_users` on((`monitor_status_3`.`user_id` = `monitor_users`.`id`))) group by `monitor_users`.`name`;

-- ----------------------------
-- View structure for v_login_record
-- ----------------------------
DROP VIEW IF EXISTS `v_login_record`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `v_login_record` AS select `monitor_users`.`name` AS `user`,`monitor_pcs`.`name` AS `pc`,`monitor_login_record`.`ip_address` AS `ip`,`monitor_login_record`.`time_con` AS `time_con`,`monitor_login_record`.`time_discon` AS `time_discon`,`monitor_login_record`.`duration` AS `duration`,`monitor_users`.`type` AS `type` from ((`monitor_login_record` join `monitor_users` on((`monitor_login_record`.`user_id` = `monitor_users`.`id`))) join `monitor_pcs` on((`monitor_login_record`.`pc_id` = `monitor_pcs`.`id`)));

-- ----------------------------
-- View structure for v_total_time
-- ----------------------------
DROP VIEW IF EXISTS `v_total_time`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `v_total_time` AS select `v_login_record`.`user` AS `user`,sum(`v_login_record`.`duration`) AS `time_total`,`v_login_record`.`type` AS `type` from `v_login_record` group by `v_login_record`.`user`;

-- ----------------------------
-- Triggers structure for table monitor_status_2
-- ----------------------------
DROP TRIGGER IF EXISTS `TR_NEW_LOGIN_REC_S2`;
delimiter ;;
CREATE TRIGGER `TR_NEW_LOGIN_REC_S2` AFTER INSERT ON `monitor_status_2` FOR EACH ROW BEGIN
	DECLARE time_on DATETIME;
	SET time_on = (SELECT time FROM status_1 WHERE user_id=NEW.user_id AND pc_id=NEW.pc_id AND time < NEW.time ORDER BY time DESC LIMIT 1 );
	INSERT INTO monitor_login_record (user_id,pc_id,time_con,time_discon,duration,ip_address) VALUES (NEW.user_id,NEW.pc_id,time_on,NEW.time,TIMESTAMPDIFF(MINUTE,time_on,NEW.time),NEW.ip_address);
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table monitor_status_3
-- ----------------------------
DROP TRIGGER IF EXISTS `TR_NEW_LOGIN_REC_S3`;
delimiter ;;
CREATE TRIGGER `TR_NEW_LOGIN_REC_S3` AFTER INSERT ON `monitor_status_3` FOR EACH ROW BEGIN
	DECLARE time_on DATETIME;
	SET time_on = (SELECT time FROM status_1 WHERE user_id=NEW.user_id AND pc_id=NEW.pc_id AND time < NEW.time ORDER BY time DESC LIMIT 1 );
	INSERT INTO monitor_login_record (user_id,pc_id,time_con,time_discon,duration,ip_address) VALUES (NEW.user_id,NEW.pc_id,time_on,NEW.time,TIMESTAMPDIFF(MINUTE,time_on,NEW.time),NEW.ip_address);
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
