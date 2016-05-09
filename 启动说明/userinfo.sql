/*
Navicat MySQL Data Transfer

Source Server         : pwy
Source Server Version : 50165
Source Host           : localhost:3306
Source Database       : jfinal

Target Server Type    : MYSQL
Target Server Version : 50165
File Encoding         : 65001

Date: 2016-03-16 17:48:53
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `account` varchar(200) NOT NULL,
  `pwd` varchar(200) NOT NULL,
  `position` int(11) NOT NULL,
  `lock` bit(1) DEFAULT NULL,
  `createTime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
INSERT INTO `userinfo` VALUES ('23', '彭伟源', '42465360', '4297F44B13955235245B2497399D7A93', '1', '', '2016-03-16 16:39:39');
