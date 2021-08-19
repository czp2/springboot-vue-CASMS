/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50729
Source Host           : 127.0.0.1:3306
Source Database       : casms

Target Server Type    : MYSQL
Target Server Version : 50729
File Encoding         : 65001

Date: 2021-08-19 15:06:16
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for answer
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer` (
  `answer_id` int(11) NOT NULL,
  `question_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `select_option` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`answer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of answer
-- ----------------------------

-- ----------------------------
-- Table structure for company
-- ----------------------------
DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `company_id` int(11) NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of company
-- ----------------------------

-- ----------------------------
-- Table structure for computer
-- ----------------------------
DROP TABLE IF EXISTS `computer`;
CREATE TABLE `computer` (
  `computer_id` int(11) NOT NULL,
  `company` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `cpu` varchar(255) DEFAULT NULL,
  `graphics_card` varchar(255) DEFAULT NULL,
  `memory` int(11) DEFAULT NULL,
  `storage` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT '0',
  PRIMARY KEY (`computer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of computer
-- ----------------------------
INSERT INTO `computer` VALUES ('10000', '小米', '小米 Air 13.3', 'lntel(R) Core(TM) i5-7200U\n', 'NVIDIA GeForce MX150\r\n', '8', '256G固态', '2021-05-08 09:39:01', '2021-05-08 09:39:04', '0');

-- ----------------------------
-- Table structure for computers
-- ----------------------------
DROP TABLE IF EXISTS `computers`;
CREATE TABLE `computers` (
  `bind_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `computer_id` int(11) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `warranty` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`bind_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of computers
-- ----------------------------
INSERT INTO `computers` VALUES ('1', '3', '10000', '2021-04-18 02:43:31', '2025-01-08 13:40:05', '2021-04-19 19:43:45', '0');
INSERT INTO `computers` VALUES ('2', '2', '10000', '2021-04-20 00:37:36', null, '2021-04-20 01:44:14', '0');
INSERT INTO `computers` VALUES ('3', '4', '10000', '2021-04-21 04:11:37', null, '2021-04-21 04:11:37', '0');
INSERT INTO `computers` VALUES ('4', '3', '10000', '2021-04-18 02:43:31', '2022-03-01 12:31:07', '2021-04-19 19:43:45', '0');

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `admin_reply` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`feedback_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback` VALUES ('1', '3', '系统方面', '系统功能不够完善', '1', '抱歉，我们会尽快优化的', '2021-04-24 18:36:40', '2021-04-25 02:56:04', '0');
INSERT INTO `feedback` VALUES ('2', '10', '服务方面', '维修人员待遇太差！', '1', '抱歉，我们会尽快优化', '2021-04-24 18:41:31', '2021-04-24 18:41:31', '0');
INSERT INTO `feedback` VALUES ('3', '3', '给个鼓励', '加油', null, null, '2021-04-25 02:23:23', '2021-04-25 02:23:23', '0');
INSERT INTO `feedback` VALUES ('4', '3', '给个鼓励', '加油啊', null, null, '2021-04-25 17:25:45', '2021-04-25 17:25:45', '0');
INSERT INTO `feedback` VALUES ('5', '3', '系统方面', 'test', null, null, '2021-04-25 18:44:02', '2021-04-25 18:44:02', '0');

-- ----------------------------
-- Table structure for option
-- ----------------------------
DROP TABLE IF EXISTS `option`;
CREATE TABLE `option` (
  `option_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of option
-- ----------------------------

-- ----------------------------
-- Table structure for problem
-- ----------------------------
DROP TABLE IF EXISTS `problem`;
CREATE TABLE `problem` (
  `problem_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `state` varchar(11) DEFAULT NULL,
  `solution_id` int(11) DEFAULT NULL,
  `solution_time` datetime DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`problem_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of problem
-- ----------------------------
INSERT INTO `problem` VALUES ('19', '3', '电脑出问题了怎么办啊？', '刚刚用电脑管家修复电脑，然后突然就蓝屏了打开之后就一直报错，现在身边没有电脑重装不了系统，电脑上面软件都打不开，一打开就弹这个，网络也连接不上 ，网上各种方法都试了不行，有没有懂得大佬救救我啊，大佬救命！', '已解决', '29', '2021-04-25 17:24:36', '2021-04-25 13:23:29', '2021-04-25 17:24:37', '0');
INSERT INTO `problem` VALUES ('20', '3', '电脑出现问题了 这怎么解决？', '用着用着就崩溃了了？什么情况啊 如何解决呢？', '处理中', null, null, '2021-04-25 13:25:19', '2021-04-25 13:30:06', '0');
INSERT INTO `problem` VALUES ('21', '3', '电脑显示出问题', '只能在屏幕最上方看到鼠标箭头，一移动箭头下来就看不到了，这是什么情况，谢谢', '处理中', '28', '2021-04-25 18:08:04', '2021-04-25 13:27:27', '2021-04-25 18:48:47', '0');
INSERT INTO `problem` VALUES ('27', '3', '电脑出问题了怎么办啊？', '刚刚用电脑管家修复电脑，然后突然就蓝屏了打开之后就一直报错，现在身边没有电脑重装不了系统，电脑上面软件都打不开，一打开就弹这个，网络也连接不上 ，网上各种方法都试了不行，有没有懂得大佬救救我啊，大佬救命！', '处理中', null, null, '2021-04-25 18:26:41', '2021-05-08 11:23:05', '0');
INSERT INTO `problem` VALUES ('32', '3', 'test', 'test', '处理中', null, null, '2021-04-25 18:35:15', '2021-04-25 18:47:23', '0');
INSERT INTO `problem` VALUES ('33', '10', 'test', 'test', '处理中', null, null, '2021-04-25 18:38:22', '2021-04-25 18:47:25', '0');
INSERT INTO `problem` VALUES ('34', '10', 'test', 'test', '处理中', null, null, '2021-04-25 18:38:22', '2021-04-25 18:47:25', '0');
INSERT INTO `problem` VALUES ('35', '10', 'test', 'test', '处理中', null, null, '2021-04-25 18:38:22', '2021-04-25 18:47:25', '0');
INSERT INTO `problem` VALUES ('36', '10', 'test', 'test', '处理中', null, null, '2021-04-25 18:38:22', '2021-04-25 18:47:25', '0');
INSERT INTO `problem` VALUES ('37', '10', 'test', 'test', '处理中', null, null, '2021-04-25 18:38:22', '2021-04-25 18:47:25', '0');
INSERT INTO `problem` VALUES ('38', '10', 'test', 'test', '处理中', null, null, '2021-04-25 18:38:22', '2021-04-25 18:47:25', '1');
INSERT INTO `problem` VALUES ('39', '10', 'test', 'test', '处理中', null, null, '2021-04-25 18:38:22', '2021-04-25 18:47:25', '1');
INSERT INTO `problem` VALUES ('40', '3', 'test', 'test', '处理中', null, null, '2021-05-08 11:21:41', '2021-05-08 11:23:01', '0');
INSERT INTO `problem` VALUES ('41', '3', '测试', '测试', '待审核', null, null, '2021-05-14 23:08:10', '2021-05-14 23:08:10', '0');

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `question_id` int(11) NOT NULL AUTO_INCREMENT,
  `questionnaire_id` int(11) NOT NULL,
  `question_title` varchar(255) NOT NULL,
  `question_description` varchar(255) DEFAULT NULL,
  `question_type` varchar(255) DEFAULT NULL,
  `question_nullable` bit(1) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of question
-- ----------------------------

-- ----------------------------
-- Table structure for questionnaire
-- ----------------------------
DROP TABLE IF EXISTS `questionnaire`;
CREATE TABLE `questionnaire` (
  `questionnaire_id` int(11) NOT NULL AUTO_INCREMENT,
  `questionnaire_name` varchar(255) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `target_population` varchar(255) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `publisher` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`questionnaire_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of questionnaire
-- ----------------------------
INSERT INTO `questionnaire` VALUES ('1', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'ordinary_user', '0', 'czp', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '0');
INSERT INTO `questionnaire` VALUES ('2', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'ordinary_user', '0', 'czp', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '0');
INSERT INTO `questionnaire` VALUES ('3', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'ordinary_user', '0', 'czp', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '0');
INSERT INTO `questionnaire` VALUES ('4', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'ordinary_user', '0', 'czp', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '0');
INSERT INTO `questionnaire` VALUES ('5', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'ordinary_user', '0', 'czp', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '0');
INSERT INTO `questionnaire` VALUES ('6', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'ordinary_user', '0', 'czp', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '0');
INSERT INTO `questionnaire` VALUES ('7', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'ordinary_user', '0', 'czp', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '0');
INSERT INTO `questionnaire` VALUES ('8', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'ordinary_user', '0', 'czp', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '0');
INSERT INTO `questionnaire` VALUES ('9', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'ordinary_user', '0', 'czp', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '0');
INSERT INTO `questionnaire` VALUES ('10', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'ordinary_user', '0', 'czp', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '0');
INSERT INTO `questionnaire` VALUES ('11', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'ordinary_user', '0', 'czp', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '0');
INSERT INTO `questionnaire` VALUES ('12', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'ordinary_user', '0', 'czp', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '0');
INSERT INTO `questionnaire` VALUES ('13', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'ordinary_user', '0', 'czp', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '0');
INSERT INTO `questionnaire` VALUES ('14', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'ordinary_user', '0', 'czp', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '0');
INSERT INTO `questionnaire` VALUES ('15', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'ordinary_user', '0', 'czp', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '0');
INSERT INTO `questionnaire` VALUES ('16', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'ordinary_user', '0', 'czp', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '0');
INSERT INTO `questionnaire` VALUES ('17', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'ordinary_user', '0', 'czp', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '0');
INSERT INTO `questionnaire` VALUES ('18', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'repairman', '0', 'czp', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '0');
INSERT INTO `questionnaire` VALUES ('19', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'repairman', '0', 'czp', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '0');
INSERT INTO `questionnaire` VALUES ('20', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'repairman', '0', 'czp', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '1');
INSERT INTO `questionnaire` VALUES ('21', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'ordinary_users', null, '', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '1');
INSERT INTO `questionnaire` VALUES ('22', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'ordinary_users', null, '', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '1');
INSERT INTO `questionnaire` VALUES ('23', '电脑售后反馈', '2019-10-29 00:00:00', '2021-04-15 12:26:11', 'ordinary_users', null, '', '2021-04-15 12:25:29', '2021-04-15 12:25:29', '1');

-- ----------------------------
-- Table structure for repair
-- ----------------------------
DROP TABLE IF EXISTS `repair`;
CREATE TABLE `repair` (
  `repair_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `repairman` int(11) DEFAULT NULL,
  `repair_content` varchar(255) NOT NULL,
  `model` varchar(255) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `appointment_time` datetime NOT NULL,
  `state` varchar(255) DEFAULT NULL,
  `completion_time` datetime DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `deleted` int(1) DEFAULT '0',
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`repair_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of repair
-- ----------------------------
INSERT INTO `repair` VALUES ('20', '3', '10', '电脑键盘进水', '小米 Air 13.3', '人为损坏', '2021-06-01 12:30:00', '已完成', '2021-05-15 09:17:57', '2021-05-13 02:09:51', '2021-05-15 09:17:58', '0', '20.00');
INSERT INTO `repair` VALUES ('21', '3', null, '键盘进水', '小米 Air 13.3', '人为损坏', '2021-06-01 10:00:00', '已审核', null, '2021-05-13 02:11:28', '2021-05-13 02:12:17', '0', '20.00');
INSERT INTO `repair` VALUES ('22', '3', null, 'sdsdsdfsdf', '小米 Air 13.3', '设备故障', '2021-05-13 02:16:10', '已审核', null, '2021-05-13 02:16:14', '2021-05-13 02:16:14', '1', '0.00');
INSERT INTO `repair` VALUES ('23', '3', null, 'sdsdsdfsdf', '小米 Air 13.3', '设备故障', '2021-05-13 02:16:10', '已审核', null, '2021-05-13 02:16:14', '2021-05-13 02:16:14', '1', '0.00');
INSERT INTO `repair` VALUES ('24', '3', null, 'sdsdsdfsdf', '联想小新Pro14', '设备故障', '2021-05-13 02:16:10', '已审核', null, '2021-05-13 02:16:14', '2021-05-13 02:16:14', '1', '0.00');
INSERT INTO `repair` VALUES ('25', '3', null, 'sdsdsdfsdf', '联想小新Pro14', '设备故障', '2021-05-13 02:16:10', '已审核', null, '2021-05-13 02:16:14', '2021-05-13 02:16:14', '1', '0.00');
INSERT INTO `repair` VALUES ('26', '3', null, 'sdsdsdfsdf', '联想ThinkPad E14', '设备故障', '2021-05-13 02:16:10', '已审核', null, '2021-05-13 02:16:14', '2021-05-13 02:16:14', '1', '0.00');
INSERT INTO `repair` VALUES ('27', '3', null, 'sdsdsdfsdf', '联想ThinkPad E14', '设备故障', '2021-05-13 02:16:10', '已审核', null, '2021-05-13 02:16:14', '2021-05-13 02:16:14', '1', '0.00');
INSERT INTO `repair` VALUES ('28', '3', null, 'sdsdsdfsdf', '戴尔笔记本电脑dell灵越15-3501', '设备故障', '2021-05-13 02:16:10', '已审核', null, '2021-05-13 02:16:14', '2021-05-13 02:16:14', '1', '0.00');
INSERT INTO `repair` VALUES ('29', '3', null, 'sdsdsdfsdf', '戴尔笔记本电脑dell灵越15-3501', '设备故障', '2021-05-13 02:16:10', '已审核', null, '2021-05-13 02:16:14', '2021-05-13 02:16:14', '1', '0.00');
INSERT INTO `repair` VALUES ('30', '3', null, 'sdsdsdfsdf', '华硕（ASUS）VivoBook15 X', '设备故障', '2021-05-13 02:16:10', '已审核', null, '2021-05-13 02:16:14', '2021-05-13 02:16:14', '1', '0.00');
INSERT INTO `repair` VALUES ('31', '3', null, 'sdsdsdfsdf', '华硕（ASUS）VivoBook15 X', '设备故障', '2021-05-13 02:16:10', '已审核', null, '2021-05-13 02:16:14', '2021-05-13 02:16:14', '1', '0.00');
INSERT INTO `repair` VALUES ('32', '3', null, 'sdsdsdfsdf', '惠普(HP)战66四代', '设备故障', '2021-05-13 02:16:10', '已审核', null, '2021-05-13 02:16:14', '2021-05-13 02:16:14', '1', '0.00');
INSERT INTO `repair` VALUES ('33', '3', null, '测试', '小米 Air 13.3', '设备故障', '2021-05-14 23:08:34', '待审核', null, '2021-05-14 23:08:46', '2021-05-14 23:08:46', '0', '0.00');
INSERT INTO `repair` VALUES ('34', '3', null, 'test', '小米 Air 13.3', '设备故障', '2021-05-15 09:16:24', '已审核', null, '2021-05-15 09:16:31', '2021-05-15 09:16:47', '0', '0.00');

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply` (
  `reply_id` int(11) NOT NULL AUTO_INCREMENT,
  `problem_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `reply_content` varchar(255) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`reply_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of reply
-- ----------------------------
INSERT INTO `reply` VALUES ('1', '3', '3', 'srgfsrdgreg', '2021-04-18 00:46:00', '2021-04-18 00:46:00', '0');
INSERT INTO `reply` VALUES ('2', '4', '3', 'sdfefsefse', '2021-04-18 01:07:16', '2021-04-18 01:07:16', '0');
INSERT INTO `reply` VALUES ('3', '3', '3', 'haifhishfiseh', '2021-04-18 01:08:39', '2021-04-18 01:08:39', '0');
INSERT INTO `reply` VALUES ('4', '3', '3', 'EEE', '2021-04-18 10:41:20', '2021-04-18 10:41:20', '0');
INSERT INTO `reply` VALUES ('5', '3', '3', 'sfedsfs', '2021-04-21 00:11:40', '2021-04-21 00:11:40', '0');
INSERT INTO `reply` VALUES ('6', '3', '3', '你在说什么', '2021-04-21 00:11:50', '2021-04-21 00:11:50', '0');
INSERT INTO `reply` VALUES ('7', '3', '3', '啊这', '2021-04-21 00:11:59', '2021-04-21 00:11:59', '0');
INSERT INTO `reply` VALUES ('8', '11', '3', '写不出来不写了', '2021-04-21 01:24:30', '2021-04-21 03:35:25', '1');
INSERT INTO `reply` VALUES ('9', '11', '3', '写不出来不写了', '2021-04-21 03:46:28', '2021-04-21 03:46:53', '1');
INSERT INTO `reply` VALUES ('10', '11', '3', '写不出来不写了', '2021-04-21 03:46:32', '2021-04-21 03:46:32', '1');
INSERT INTO `reply` VALUES ('11', '11', '3', '写不出来不写了', '2021-04-21 03:46:36', '2021-04-21 03:46:36', '1');
INSERT INTO `reply` VALUES ('12', '11', '3', '写不出来不写了', '2021-04-21 03:46:40', '2021-04-21 03:46:40', '1');
INSERT INTO `reply` VALUES ('13', '12', '3', '新回复', '2021-04-21 04:07:46', '2021-04-21 04:07:46', '1');
INSERT INTO `reply` VALUES ('14', '12', '3', '新回复', '2021-04-21 04:07:52', '2021-04-21 04:07:52', '1');
INSERT INTO `reply` VALUES ('15', '10', '3', '新回复', '2021-04-21 04:08:14', '2021-04-21 04:08:14', '1');
INSERT INTO `reply` VALUES ('16', '10', '3', '新回复', '2021-04-21 04:08:19', '2021-04-21 04:08:19', '1');
INSERT INTO `reply` VALUES ('17', '10', '10', '我觉得可以', '2021-04-21 20:15:26', '2021-04-21 20:15:26', '1');
INSERT INTO `reply` VALUES ('18', '11', '10', '坚持下去', '2021-04-21 20:15:38', '2021-04-21 20:15:38', '1');
INSERT INTO `reply` VALUES ('19', '12', '3', '新问题1', '2021-04-23 23:47:25', '2021-04-23 23:47:25', '1');
INSERT INTO `reply` VALUES ('20', '12', '3', '新问题2', '2021-04-23 23:47:29', '2021-04-23 23:47:29', '1');
INSERT INTO `reply` VALUES ('21', '12', '3', '新问题3', '2021-04-23 23:47:34', '2021-04-23 23:47:34', '0');
INSERT INTO `reply` VALUES ('22', '12', '3', '新问题4', '2021-04-23 23:47:39', '2021-04-23 23:47:39', '0');
INSERT INTO `reply` VALUES ('23', '12', '3', '新问题', '2021-04-23 23:47:51', '2021-04-23 23:47:51', '0');
INSERT INTO `reply` VALUES ('24', '12', '3', '', '2021-04-25 09:51:55', '2021-04-25 09:51:55', '1');
INSERT INTO `reply` VALUES ('25', '12', '3', '', '2021-04-25 09:55:19', '2021-04-25 09:55:19', '1');
INSERT INTO `reply` VALUES ('26', '12', '3', 'cascs', '2021-04-25 09:56:24', '2021-04-25 09:56:24', '0');
INSERT INTO `reply` VALUES ('27', '12', '3', '3', '2021-04-25 10:02:27', '2021-04-25 10:02:27', '0');
INSERT INTO `reply` VALUES ('28', '21', '2', '先杀毒，如果没毒，进入控制面板-区域和语言选项，把“区域选项”和“高级”里的全部改成中文。然后重启。 如果没用，就打开C:\\WINDOWS\\Fonts 看看这个里面的字体文件有没有丢失，正常都在260种左右。如果丢失了，就去下载一下字体，然后全部拷贝到这个文件夹内，最后重启。', '2021-04-25 14:03:50', '2021-04-25 14:03:50', '1');
INSERT INTO `reply` VALUES ('29', '19', '3', '百度，不懂就百度', '2021-04-25 17:23:44', '2021-04-25 17:23:44', '0');
INSERT INTO `reply` VALUES ('30', '19', '3', 'test', '2021-04-25 18:41:17', '2021-04-25 18:41:17', '0');
INSERT INTO `reply` VALUES ('31', '19', '3', 'hello', '2021-04-29 02:22:37', '2021-04-29 02:22:37', '0');
INSERT INTO `reply` VALUES ('32', '20', '2', '你好，能不能描述的更加详细一点呢？', '2021-04-29 02:45:52', '2021-04-29 02:45:52', '0');
INSERT INTO `reply` VALUES ('33', '19', '3', 'test', '2021-05-15 09:15:58', '2021-05-15 09:15:58', '0');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `realname` varchar(255) DEFAULT NULL,
  `user_pwd` varchar(255) NOT NULL,
  `avator` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `tel` varchar(255) DEFAULT NULL,
  `role` varchar(20) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`user_id`,`email`,`user_name`) USING BTREE,
  KEY `user_name` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '1127731529@qq.com', 'czp', '艾德明', '123456', null, '滁州学院会峰校区', '17856006425', '管理员', '2021-04-03 16:48:00', '2021-04-28 11:47:41', '0');
INSERT INTO `user` VALUES ('2', 'test1@baomidou.com', 'Jone', '王小明', '111111', null, '滁州学院', '1785600xxxx', '普通用户', '2021-04-03 16:48:00', '2021-04-28 11:46:38', '0');
INSERT INTO `user` VALUES ('3', 'test2@baomidou.com', 'PWN', '潘小伟', '12345678', null, '南京市XX新城X栋X单元X0X', '178XXXX7425', '普通用户', '2021-04-03 16:48:00', '2021-05-15 09:35:51', '0');
INSERT INTO `user` VALUES ('4', 'test3@baomidou.com', 'Tom', '李飞', '111111', null, '滁州学院', '1785600xxxx', '普通用户', '2021-04-03 16:48:00', '2021-04-28 11:48:05', '0');
INSERT INTO `user` VALUES ('5', 'test4@baomidou.com', 'Sandy', null, '111111', null, '滁州学院', '1785600xxxx', '普通用户', '2021-04-03 16:48:00', '2021-04-03 16:48:00', '1');
INSERT INTO `user` VALUES ('6', 'test5@baomidou.com', 'Billie', null, '111111', null, '滁州学院', '1785600xxxx', '普通用户', '2021-04-03 16:48:00', '2021-04-03 14:19:14', '1');
INSERT INTO `user` VALUES ('9', '1@qq.com', '1', null, '1', null, null, null, '普通用户', '2021-04-03 16:48:00', '2021-04-03 16:48:00', '1');
INSERT INTO `user` VALUES ('10', '942059804@qq.com', 'czp1', '陈小刚', '111111', null, null, '17856006425', '维修人员', '2021-04-18 01:49:37', '2021-04-28 11:46:48', '0');
INSERT INTO `user` VALUES ('11', 'ATK@qq.com', 'ATK', '白蓉', '123456', 'dog.png', null, null, '维修人员', '2021-04-21 23:13:48', '2021-05-14 03:24:29', '0');
INSERT INTO `user` VALUES ('12', 'DEF@qq.com', 'DEF', '李芳', '123456', 'dog.png', null, null, '维修人员', '2021-04-21 23:14:59', '2021-05-14 03:24:33', '0');
