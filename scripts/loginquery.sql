/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 50557
 Source Host           : localhost:3306
 Source Schema         : tmp

 Target Server Type    : MySQL
 Target Server Version : 50557
 File Encoding         : 65001

 Date: 25/01/2018 15:39:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for last_query_time
-- ----------------------------
DROP TABLE IF EXISTS `last_query_time`;
CREATE TABLE `last_query_time`  (
  `time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for map_user_pc
-- ----------------------------
DROP TABLE IF EXISTS `map_user_pc`;
CREATE TABLE `map_user_pc`  (
  `user_id` int(11) NOT NULL,
  `pc_id` int(11) NOT NULL,
  INDEX `FK_MAP_USER`(`user_id`) USING BTREE,
  INDEX `FK_MAP_PC`(`pc_id`) USING BTREE,
  CONSTRAINT `FK_MAP_USER` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_MAP_PC` FOREIGN KEY (`pc_id`) REFERENCES `pcs` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for pcs
-- ----------------------------
DROP TABLE IF EXISTS `pcs`;
CREATE TABLE `pcs`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ip_1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ip_2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
  `duration` bigint(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_LIST_USER`(`user_id`) USING BTREE,
  INDEX `FK_LIST_PC`(`pc_id`) USING BTREE,
  CONSTRAINT `FK_LIST_PC` FOREIGN KEY (`pc_id`) REFERENCES `pcs` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_LIST_USER` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 87 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1118 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` int(11) NOT NULL COMMENT 'User Account type(0 admin, 1 user)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- View structure for v_last_con_time
-- ----------------------------
DROP VIEW IF EXISTS `v_last_con_time`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `v_last_con_time` AS select `v_record`.`user` AS `user`,`v_record`.`pc` AS `pc`,`v_record`.`time_con` AS `last_con_time` from `v_record` group by `v_record`.`user` order by `v_record`.`time_con` limit 1;

-- ----------------------------
-- View structure for v_last_s1_time
-- ----------------------------
DROP VIEW IF EXISTS `v_last_s1_time`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `v_last_s1_time` AS select `users`.`name` AS `user`,max(`status_1`.`time`) AS `time` from (`status_1` join `users` on((`status_1`.`user_id` = `users`.`id`))) group by `users`.`id`;

-- ----------------------------
-- View structure for v_last_s2_time
-- ----------------------------
DROP VIEW IF EXISTS `v_last_s2_time`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `v_last_s2_time` AS select `users`.`name` AS `user`,max(`status_2`.`time`) AS `time` from (`status_2` join `users` on((`status_2`.`user_id` = `users`.`id`))) group by `users`.`name`;

-- ----------------------------
-- View structure for v_last_s3_time
-- ----------------------------
DROP VIEW IF EXISTS `v_last_s3_time`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `v_last_s3_time` AS select `users`.`name` AS `user`,max(`status_3`.`time`) AS `time` from (`status_3` join `users` on((`status_3`.`user_id` = `users`.`id`))) group by `users`.`name`;

-- ----------------------------
-- View structure for v_record
-- ----------------------------
DROP VIEW IF EXISTS `v_record`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `v_record` AS select `users`.`name` AS `user`,`pcs`.`name` AS `pc`,`plain_list`.`time_con` AS `time_con`,`plain_list`.`time_discon` AS `time_discon`,`plain_list`.`duration` AS `duration` from ((`plain_list` join `users` on((`plain_list`.`user_id` = `users`.`id`))) join `pcs` on((`plain_list`.`pc_id` = `pcs`.`id`)));

-- ----------------------------
-- View structure for v_total_time
-- ----------------------------
DROP VIEW IF EXISTS `v_total_time`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `v_total_time` AS select `v_record`.`user` AS `user`,sum(`v_record`.`duration`) AS `time_total` from `v_record` group by `v_record`.`user` order by `v_record`.`duration` desc;

-- ----------------------------
-- Triggers structure for table status_2
-- ----------------------------
DROP TRIGGER IF EXISTS `TR1`;
delimiter ;;
CREATE TRIGGER `TR1` AFTER INSERT ON `status_2` FOR EACH ROW BEGIN
	DECLARE time_on DATETIME;
	SET time_on = (SELECT time FROM status_1 WHERE user_id=NEW.user_id AND pc_id=NEW.pc_id AND time < NEW.time ORDER BY time DESC LIMIT 1 );
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
	SET time_on = (SELECT time FROM status_1 WHERE user_id=NEW.user_id AND pc_id=NEW.pc_id AND time < NEW.time ORDER BY time DESC LIMIT 1 );
	INSERT INTO plain_list (user_id,pc_id,time_con,time_discon,duration) VALUES (NEW.user_id,NEW.pc_id,time_on,NEW.time,TIMESTAMPDIFF(MINUTE,time_on,NEW.time));
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
