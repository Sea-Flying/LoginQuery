/*
Navicat MySQL Data Transfer

Source Server         : 10.155.215.131_3306
Source Server Version : 50529
Source Host           : 10.155.215.131:3306
Source Database       : loginquery

Target Server Type    : MYSQL
Target Server Version : 50529
File Encoding         : 65001

Date: 2018-08-20 09:25:17
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for last_query_time
-- ----------------------------
DROP TABLE IF EXISTS `last_query_time`;
CREATE TABLE `last_query_time` (
  `time` datetime NOT NULL DEFAULT '1970-01-01 08:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
INSERT INTO last_query_time VALUES ('1970-01-01 08:00:00');
-- ----------------------------
-- Table structure for map_user_pc
-- ----------------------------
DROP TABLE IF EXISTS `map_user_pc`;
CREATE TABLE `map_user_pc` (
  `user_id` int(11) NOT NULL,
  `pc_id` int(11) NOT NULL,
  KEY `FK_MAP_USER` (`user_id`) USING BTREE,
  KEY `FK_MAP_PC` (`pc_id`) USING BTREE,
  CONSTRAINT `map_user_pc_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `map_user_pc_ibfk_2` FOREIGN KEY (`pc_id`) REFERENCES `pcs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for pcs
-- ----------------------------
DROP TABLE IF EXISTS `pcs`;
CREATE TABLE `pcs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `ip_1` varchar(255) DEFAULT NULL,
  `ip_2` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for plain_list
-- ----------------------------
DROP TABLE IF EXISTS `plain_list`;
CREATE TABLE `plain_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `pc_id` int(11) DEFAULT NULL,
  `time_con` datetime DEFAULT NULL,
  `time_discon` datetime DEFAULT NULL,
  `duration` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_LIST_USER` (`user_id`) USING BTREE,
  KEY `FK_LIST_PC` (`pc_id`) USING BTREE,
  CONSTRAINT `FK_LIST_PC` FOREIGN KEY (`pc_id`) REFERENCES `pcs` (`id`),
  CONSTRAINT `FK_LIST_USER` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for status_1
-- ----------------------------
DROP TABLE IF EXISTS `status_1`;
CREATE TABLE `status_1` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `pc_id` int(11) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for status_2
-- ----------------------------
DROP TABLE IF EXISTS `status_2`;
CREATE TABLE `status_2` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `pc_id` int(11) NOT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for status_3
-- ----------------------------
DROP TABLE IF EXISTS `status_3`;
CREATE TABLE `status_3` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `pc_id` int(11) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `display` varchar(255) DEFAULT NULL,
  `type` int(11) NOT NULL COMMENT 'User Account type(0 admin, 1 user)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- View structure for v_last_con_time
-- ----------------------------
DROP VIEW IF EXISTS `v_last_con_time`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_last_con_time` AS select `users`.`name` AS `user`,`pcs`.`name` AS `pc`,max(`status_1`.`time`) AS `last_con_time`,`users`.`type` AS `type` from ((`status_1` join `pcs` on((`status_1`.`pc_id` = `pcs`.`id`))) join `users` on((`status_1`.`user_id` = `users`.`id`))) group by `users`.`name`,`pcs`.`name` order by max(`status_1`.`time`) desc ;

-- ----------------------------
-- View structure for v_last_s1_time
-- ----------------------------
DROP VIEW IF EXISTS `v_last_s1_time`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_last_s1_time` AS SELECT
users.`name` AS `user`,
Max(status_1.time) AS time,
users.type
from (`status_1` join `users` on((`status_1`.`user_id` = `users`.`id`)))
group by `users`.`id` ;

-- ----------------------------
-- View structure for v_last_s2_time
-- ----------------------------
DROP VIEW IF EXISTS `v_last_s2_time`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_last_s2_time` AS SELECT
users.`name` AS `user`,
Max(status_2.time) AS time,
users.type
from (`status_2` join `users` on((`status_2`.`user_id` = `users`.`id`)))
group by `users`.`name` ;

-- ----------------------------
-- View structure for v_last_s3_time
-- ----------------------------
DROP VIEW IF EXISTS `v_last_s3_time`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_last_s3_time` AS SELECT
users.`name` AS `user`,
Max(status_3.time) AS time,
users.type
from (`status_3` join `users` on((`status_3`.`user_id` = `users`.`id`)))
group by `users`.`name` ;

-- ----------------------------
-- View structure for v_record
-- ----------------------------
DROP VIEW IF EXISTS `v_record`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_record` AS SELECT
users.`name` AS `user`,
pcs.`name` AS pc,
plain_list.time_con AS time_con,
plain_list.time_discon AS time_discon,
plain_list.duration AS duration,
users.type AS type
from ((`plain_list` join `users` on((`plain_list`.`user_id` = `users`.`id`))) join `pcs` on((`plain_list`.`pc_id` = `pcs`.`id`))) ;

-- ----------------------------
-- View structure for v_total_time
-- ----------------------------
DROP VIEW IF EXISTS `v_total_time`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_total_time` AS SELECT
v_record.`user` AS `user`,
Sum(v_record.duration) AS time_total,
v_record.type
from `v_record`
group by `v_record`.`user`
order by `v_record`.`duration` desc ;

-- ----------------------------
-- Create trigger for calculate duration
-- ----------------------------
DROP TRIGGER IF EXISTS `TR1`;
DELIMITER ;;
CREATE TRIGGER `TR1` AFTER INSERT ON `status_2` FOR EACH ROW BEGIN
	DECLARE time_on DATETIME;
	SET time_on = (SELECT time FROM status_1 WHERE user_id=NEW.user_id AND pc_id=NEW.pc_id AND time < NEW.time ORDER BY time DESC LIMIT 1 );
	INSERT INTO plain_list (user_id,pc_id,time_con,time_discon,duration) VALUES (NEW.user_id,NEW.pc_id,time_on,NEW.time,TIMESTAMPDIFF(MINUTE,time_on,NEW.time));
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `TR2`;
DELIMITER ;;
CREATE TRIGGER `TR2` AFTER INSERT ON `status_3` FOR EACH ROW BEGIN
	DECLARE time_on DATETIME;
	SET time_on = (SELECT time FROM status_1 WHERE user_id=NEW.user_id AND pc_id=NEW.pc_id AND time < NEW.time ORDER BY time DESC LIMIT 1 );
	INSERT INTO plain_list (user_id,pc_id,time_con,time_discon,duration) VALUES (NEW.user_id,NEW.pc_id,time_on,NEW.time,TIMESTAMPDIFF(MINUTE,time_on,NEW.time));
END
;;
DELIMITER ;
