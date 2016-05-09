/*
Navicat MySQL Data Transfer

Source Server         : pwy
Source Server Version : 50165
Source Host           : localhost:3306
Source Database       : jfinal

Target Server Type    : MYSQL
Target Server Version : 50165
File Encoding         : 65001

Date: 2016-03-24 10:10:47
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `project`
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `acceptDate` varchar(200) NOT NULL,
  `client` varchar(200) NOT NULL,
  `contacts` varchar(200) NOT NULL,
  `projectName` varchar(200) NOT NULL,
  `hmoney` int(11) NOT NULL,
  `nmoney` int(11) NOT NULL,
  `estimateDate` varchar(200) NOT NULL,
  `business` varchar(200) NOT NULL,
  `design` varchar(200) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `createTime` datetime NOT NULL,
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `up_for` (`userId`),
  CONSTRAINT `up_for` FOREIGN KEY (`userId`) REFERENCES `userinfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of project
-- ----------------------------
INSERT INTO `project` VALUES ('25', '2016-03-24', '机械', '晨晨：12322222222', '高级', '23', '323', '2016-03-24', '小伟', '小弟', '我事', '0', '23', '2016-03-24 06:29:52', null);
INSERT INTO `project` VALUES ('26', '2016-03-24', '广州高大上网络科技游戏公司77', '地方：123123123123', '招牌换花', '200', '0', '2016-03-26', '小明', '小明', '顶顶顶顶', '1', '23', '2016-03-24 07:05:49', '2016-03-24 07:42:35');
