SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `admin_account` int NOT NULL COMMENT '管理员账号',
  `admin_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理员密码',
  PRIMARY KEY (`admin_account`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1001, '123456');
INSERT INTO `admin` VALUES (1002, '123456');
INSERT INTO `admin` VALUES (1003, '123456');

-- ----------------------------
-- Table structure for classtable
-- ----------------------------
DROP TABLE IF EXISTS `class_table`;
CREATE TABLE `class_table`  (
  `class_id` int NOT NULL DEFAULT 0 COMMENT '课程id',
  `class_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '课程名称',
  `class_begin` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开课时间',
  `class_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '课程时长',
  `coach` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '教练',
  PRIMARY KEY (`class_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of classtable
-- ----------------------------
INSERT INTO `class_table` VALUES (0001, '增肌', '2025年10月1日 15:00', '60分钟', '增肌教练');
INSERT INTO `class_table` VALUES (0002, '瑜伽', '2025年10月2日 10:20', '90分钟', '瑜伽教练');
INSERT INTO `class_table` VALUES (0003, '减脂', '2025年10月6日 18:00', '90分钟', '减脂教练');
INSERT INTO `class_table` VALUES (0004, '运动康复', '2025年10月2日 10:00', '45分钟', '运动康复教练');
INSERT INTO `class_table` VALUES (0005, '综合格斗', '2025年10月3日 15:00', '60分钟', '综合格斗教练');
INSERT INTO `class_table` VALUES (0006, '塑形', '2025年10月3日 15:00', '60分钟', '塑形教练');
INSERT INTO `class_table` VALUES (0007, '普拉提', '2025年10月1日 17:30', '60分钟', '普拉提教练');
INSERT INTO `class_table` VALUES (0008, '爵士舞', '2025年10月9日 09:00', '90分钟', '爵士舞教练');
INSERT INTO `class_table` VALUES (0009, '杠铃操', '2025年10月4日 15:00', '60分钟', '杠铃操教练');
INSERT INTO `class_table` VALUES (0010, '动感单车', '2025年10月8日 15:00', '45分钟', '动感单车教练');
INSERT INTO `class_table` VALUES (0011, '健美操', '2025年10月10日 18:00', '60分钟', '健美操教练');


-- ----------------------------
-- Table structure for classorder
-- ----------------------------
DROP TABLE IF EXISTS `class_order`;
CREATE TABLE `class_order`  (
  `class_order_id` int NOT NULL AUTO_INCREMENT COMMENT '报名表id',
  `class_id` int NULL DEFAULT NULL COMMENT '课程id',
  `class_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '课程名称',
  `coach` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '教练',
  `member_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员姓名',
  `member_account` int NULL DEFAULT NULL COMMENT '会员账号',
  `class_begin` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开课时间',
  PRIMARY KEY (`class_order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of classorder
-- ----------------------------
INSERT INTO `class_order` VALUES (1, 0002, '瑜伽', '瑜伽教练', '李四', 202500788, '2025年10月2日 10:20');
INSERT INTO `class_order` VALUES (2, 0002, '瑜伽', '瑜伽教练', '王五', 202532539, '2025年10月2日 10:20');
INSERT INTO `class_order` VALUES (3, 0004, '运动康复', '运动康复教练', 'Mike', 202556754, '2025年10月2日 10:00');
INSERT INTO `class_order` VALUES (4, 0001, '增肌', '增肌教练', 'Mike', 202556754, '2025年10月1日 15:00');
INSERT INTO `class_order` VALUES (5, 0001, '增肌', '增肌教练', 'Tylor', 202583406, '2025年10月1日 15:00');
INSERT INTO `class_order` VALUES (6, 0002, '瑜伽', '瑜伽教练', 'Tylor', 202583406, '2025年10月2日 10:20');
INSERT INTO `class_order` VALUES (7, 0001, '增肌', '增肌教练', '李四', 202500788, '2025年10月1日 15:00');
INSERT INTO `class_order` VALUES (8, 0001, '增肌', '增肌教练', '马六', 202586416, '2025年10月1日 15:00');
INSERT INTO `class_order` VALUES (9, 0003, '减脂', '减脂教练', '马六', 202586416, '2025年10月6日 18:00');
INSERT INTO `class_order` VALUES (10, 0003, '减脂', '减脂教练', 'Lily', 202523664, '2025年10月6日 18:00');
INSERT INTO `class_order` VALUES (11, 0003, '减脂', '减脂教练', 'Emma', 202553468, '2025年10月6日 18:00');



-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member`  (
  `member_account` int NOT NULL COMMENT '会员账号',
  `member_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '123456' COMMENT '会员密码',
  `member_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员姓名',
  `member_gender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '会员性别',
  `member_age` int NULL DEFAULT NULL COMMENT '会员年龄',
  `member_height` int NULL DEFAULT NULL COMMENT '会员身高',
  `member_weight` int NULL DEFAULT NULL COMMENT '会员体重',
  `member_phone` bigint NULL DEFAULT NULL COMMENT '会员电话',
  `card_time` date NULL DEFAULT NULL COMMENT '办卡时间',
  `card_class` int NULL DEFAULT NULL COMMENT '购买课时',
  `card_next_class` int NULL DEFAULT NULL COMMENT '剩余课时',
  PRIMARY KEY (`member_account`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES (202509867, '123456', '张三', '女', 24, 182, 60, 13515548482, '2025-10-01', 40, 40);
INSERT INTO `member` VALUES (202500788, '123456', '李四', '男', 31, 178, 60, 13131554873, '2025-10-02', 50, 50);
INSERT INTO `member` VALUES (202532539, '123456', '王五', '男', 31, 178, 60, 13154875489, '2025-10-03', 40, 40);
INSERT INTO `member` VALUES (202586416, '123456', '马六', '女', 23, 160, 45, 13124576857, '2025-10-03', 30, 30);
INSERT INTO `member` VALUES (202506725, '123456', 'Tom', '男', 24, 178, 88, 13758784959, '2025-10-04', 30, 30);
INSERT INTO `member` VALUES (202583406, '123456', 'Tylor', '女', 19, 170, 60, 13786457488,'2025-10-06', 30, 30);
INSERT INTO `member` VALUES (202576587, '123456', 'Jack', '男', 33, 177, 90, 13767546666, '2025-10-05', 30, 30);
INSERT INTO `member` VALUES (202556754, '123456', 'Mike', '男', 36, 166, 67, 13786532448, '2025-10-07', 30, 30);
INSERT INTO `member` VALUES (202553468, '123456', 'Emma', '女', 25, 173, 44, 13786457124,  '2025-10-08', 50, 50);
INSERT INTO `member` VALUES (202521345, '123456', 'Ava', '女', 28, 160, 40, 13754457488, '2025-10-08', 30, 30);
INSERT INTO `member` VALUES (202589776, '123456', 'Chloe', '女', 27, 170, 50, 13986337489,  '2025-10-09', 30, 30);
INSERT INTO `member` VALUES (202523664, '123456', 'Lily', '女', 25, 165, 51, 15986457423,  '2025-10-10', 30, 30);

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `employee_account` int NOT NULL COMMENT '员工账号',
  `employee_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工姓名',
  `employee_gender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工性别',
  `employee_age` int NULL DEFAULT NULL COMMENT '员工年龄',
  `entry_time` date NULL DEFAULT NULL COMMENT '入职时间',
  `staff` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务',
  `employee_message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`employee_account`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (101038721,  '教练1', '女', 26, '2025-10-02', '健身教练', '健美冠军');
INSERT INTO `employee` VALUES (101068283,  '教练2', '男', 34, '2025-10-05', '健身教练', '职业教练');
INSERT INTO `employee` VALUES (101053687,  '教练3', '男', 30, '2025-10-07', '健身教练', '职业教练');
INSERT INTO `employee` VALUES (101045354,  '教练4', '男', 24, '2025-10-09', '健身教练', '职业教练');
INSERT INTO `employee` VALUES (101058973,  '保洁1', '女', 48, '2025-10-03', '保洁员', '模范员工');
INSERT INTO `employee` VALUES (101034208,  '保洁2', '女', 48, '2025-10-01', '保洁员', '');

-- ----------------------------
-- Table structure for equipment
-- ----------------------------
DROP TABLE IF EXISTS `equipment`;
CREATE TABLE `equipment`  (
  `equipment_id` int NOT NULL AUTO_INCREMENT COMMENT '器材id',
  `equipment_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '器材名称',
  `equipment_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '器材位置',
  `equipment_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '器材状态',
  `equipment_message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '器材备注信息',
  PRIMARY KEY (`equipment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of equipment
-- ----------------------------
INSERT INTO `equipment` VALUES (1, '哑铃1', '1号房间', '正常', '');
INSERT INTO `equipment` VALUES (2, '杠铃1', '2号房间', '损坏', '待维修');
INSERT INTO `equipment` VALUES (3, '跑步机1', '2号房间', '维修中', '联系厂家维修');
INSERT INTO `equipment` VALUES (4, '跑步机2', '2号房间', '正常', '');
INSERT INTO `equipment` VALUES (5, '跑步机3', '2号房间', '正常', '');
INSERT INTO `equipment` VALUES (6, '杠铃1', '1号房间', '正常', '');
INSERT INTO `equipment` VALUES (7, '杠铃2', '1号房间', '正常', '');



SET FOREIGN_KEY_CHECKS = 1;


-- ===== 增强功能（签到/收费/维修/公告） =====
SET NAMES utf8mb4;

-- ============================================================
-- 增强功能：会员签到 / 收费记录 / 器材维修 / 场馆公告
-- 数据日期统一落在 2025 年 10 月上旬
-- ============================================================

DROP TABLE IF EXISTS `check_in`;
CREATE TABLE `check_in`  (
  `check_in_id` int NOT NULL AUTO_INCREMENT COMMENT '签到id',
  `member_account` int NOT NULL COMMENT '会员账号',
  `member_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员姓名',
  `check_in_date` date NOT NULL COMMENT '签到日期',
  `check_in_time` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '签到时刻',
  `check_in_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '日常健身' COMMENT '签到类型',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`check_in_id`) USING BTREE,
  INDEX `idx_check_member`(`member_account`) USING BTREE,
  INDEX `idx_check_date`(`check_in_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202509867, '张三', '2025-10-01', '09:11', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202509867, '张三', '2025-10-02', '09:42', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202500788, '李四', '2025-10-02', '09:55', '私教课', '教练2');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202586416, '马六', '2025-10-03', '06:29', '体测', '体脂率记录');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202532539, '王五', '2025-10-03', '07:46', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202500788, '李四', '2025-10-03', '18:40', '课程签到', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202509867, '张三', '2025-10-03', '18:49', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202506725, 'Tom', '2025-10-04', '06:35', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202500788, '李四', '2025-10-04', '09:09', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202509867, '张三', '2025-10-04', '18:18', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202586416, '马六', '2025-10-04', '18:53', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202532539, '王五', '2025-10-04', '19:06', '课程签到', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202586416, '马六', '2025-10-05', '07:42', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202532539, '王五', '2025-10-05', '08:01', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202506725, 'Tom', '2025-10-05', '08:42', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202576587, 'Jack', '2025-10-05', '09:46', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202509867, '张三', '2025-10-05', '19:26', '私教课', '教练2');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202500788, '李四', '2025-10-05', '20:15', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202532539, '王五', '2025-10-06', '07:25', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202583406, 'Tylor', '2025-10-06', '08:35', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202506725, 'Tom', '2025-10-06', '09:19', '私教课', '教练3');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202509867, '张三', '2025-10-06', '09:23', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202500788, '李四', '2025-10-06', '18:08', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202586416, '马六', '2025-10-06', '19:55', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202576587, 'Jack', '2025-10-06', '21:06', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202576587, 'Jack', '2025-10-07', '07:27', '私教课', '教练4');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202500788, '李四', '2025-10-07', '08:03', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202532539, '王五', '2025-10-07', '08:17', '私教课', '教练3');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202509867, '张三', '2025-10-07', '09:02', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202586416, '马六', '2025-10-07', '09:50', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202506725, 'Tom', '2025-10-07', '20:37', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202556754, 'Mike', '2025-10-07', '21:27', '私教课', '教练3');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202509867, '张三', '2025-10-08', '08:32', '体测', '体脂率记录');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202583406, 'Tylor', '2025-10-08', '18:49', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202500788, '李四', '2025-10-08', '18:54', '私教课', '教练1');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202553468, 'Emma', '2025-10-08', '19:06', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202586416, '马六', '2025-10-08', '19:51', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202556754, 'Mike', '2025-10-08', '20:06', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202532539, '王五', '2025-10-08', '20:39', '课程签到', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202521345, 'Ava', '2025-10-08', '21:06', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202506725, 'Tom', '2025-10-08', '21:27', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202553468, 'Emma', '2025-10-09', '06:55', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202532539, '王五', '2025-10-09', '08:51', '体测', '体脂率记录');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202509867, '张三', '2025-10-09', '09:03', '课程签到', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202500788, '李四', '2025-10-09', '19:36', '课程签到', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202576587, 'Jack', '2025-10-09', '19:41', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202556754, 'Mike', '2025-10-09', '19:50', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202506725, 'Tom', '2025-10-09', '20:52', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202521345, 'Ava', '2025-10-09', '20:52', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202586416, '马六', '2025-10-09', '21:09', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202532539, '王五', '2025-10-10', '06:40', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202553468, 'Emma', '2025-10-10', '08:07', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202586416, '马六', '2025-10-10', '09:15', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202523664, 'Lily', '2025-10-10', '18:14', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202506725, 'Tom', '2025-10-10', '18:33', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202576587, 'Jack', '2025-10-10', '18:34', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202556754, 'Mike', '2025-10-10', '19:29', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202583406, 'Tylor', '2025-10-10', '20:14', '日常健身', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202589776, 'Chloe', '2025-10-10', '20:28', '课程签到', '');
INSERT INTO `check_in` (`member_account`, `member_name`, `check_in_date`, `check_in_time`, `check_in_type`, `remark`) VALUES (202509867, '张三', '2025-10-10', '21:52', '日常健身', '');

DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment`  (
  `payment_id` int NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `member_account` int NULL DEFAULT NULL COMMENT '会员账号',
  `member_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员姓名',
  `pay_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收费类型',
  `pay_way` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支付方式',
  `amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '金额',
  `class_count` int NULL DEFAULT 0 COMMENT '购买课时',
  `pay_time` date NULL DEFAULT NULL COMMENT '收费日期',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`payment_id`) USING BTREE,
  INDEX `idx_pay_member`(`member_account`) USING BTREE,
  INDEX `idx_pay_time`(`pay_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202500788, '李四', '商品', '现金', 39.0, 0, '2025-10-01', '运动毛巾 x1');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202509867, '张三', '办卡', '微信', 2580.0, 40, '2025-10-01', '新会员办卡');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202523664, 'Lily', '商品', '银行卡', 25.0, 0, '2025-10-01', '能量棒 x1');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202500788, '李四', '办卡', '现金', 3180.0, 50, '2025-10-02', '新会员办卡');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202556754, 'Mike', '私教课', '现金', 400.0, 1, '2025-10-02', '一对一体能训练');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202523664, 'Lily', '商品', '现金', 259.0, 0, '2025-10-03', '乳清蛋白粉 x1');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202523664, 'Lily', '商品', '支付宝', 259.0, 0, '2025-10-03', '乳清蛋白粉 x1');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202532539, '王五', '办卡', '微信', 2580.0, 40, '2025-10-03', '新会员办卡');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202586416, '马六', '办卡', '支付宝', 1980.0, 30, '2025-10-03', '新会员办卡');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202506725, 'Tom', '办卡', '微信', 1980.0, 30, '2025-10-04', '新会员办卡');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202556754, 'Mike', '商品', '现金', 129.0, 0, '2025-10-04', '健身手套 x1');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202576587, 'Jack', '私教课', '微信', 300.0, 2, '2025-10-04', '一对一体能训练');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202589776, 'Chloe', '商品', '微信', 129.0, 0, '2025-10-04', '健身手套 x1');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202556754, 'Mike', '私教课', '现金', 300.0, 2, '2025-10-05', '一对一体能训练');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202576587, 'Jack', '办卡', '银行卡', 1980.0, 30, '2025-10-05', '新会员办卡');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202583406, 'Tylor', '私教课', '微信', 480.0, 1, '2025-10-05', '一对一体能训练');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202523664, 'Lily', '私教课', '支付宝', 200.0, 2, '2025-10-06', '一对一体能训练');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202523664, 'Lily', '私教课', '微信', 200.0, 2, '2025-10-06', '一对一体能训练');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202583406, 'Tylor', '办卡', '支付宝', 1980.0, 30, '2025-10-06', '新会员办卡');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202586416, '马六', '私教课', '微信', 400.0, 1, '2025-10-06', '一对一体能训练');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202521345, 'Ava', '续费', '银行卡', 1780.0, 30, '2025-10-07', '课时包续费');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202523664, 'Lily', '商品', '微信', 12.0, 0, '2025-10-07', '运动饮料 x1');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202553468, 'Emma', '私教课', '微信', 400.0, 2, '2025-10-07', '一对一体能训练');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202556754, 'Mike', '办卡', '微信', 1980.0, 30, '2025-10-07', '新会员办卡');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202556754, 'Mike', '续费', '微信', 1280.0, 20, '2025-10-07', '课时包续费');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202521345, 'Ava', '办卡', '现金', 1980.0, 30, '2025-10-08', '新会员办卡');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202532539, '王五', '商品', '支付宝', 258.0, 0, '2025-10-08', '健身手套 x2');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202553468, 'Emma', '办卡', '微信', 3180.0, 50, '2025-10-08', '新会员办卡');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202586416, '马六', '商品', '银行卡', 25.0, 0, '2025-10-08', '能量棒 x1');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202500788, '李四', '续费', '现金', 980.0, 15, '2025-10-09', '课时包续费');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202506725, 'Tom', '续费', '支付宝', 1780.0, 30, '2025-10-09', '课时包续费');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202532539, '王五', '续费', '支付宝', 1280.0, 20, '2025-10-09', '课时包续费');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202553468, 'Emma', '私教课', '现金', 480.0, 1, '2025-10-09', '一对一体能训练');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202556754, 'Mike', '私教课', '微信', 400.0, 1, '2025-10-09', '一对一体能训练');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202586416, '马六', '续费', '微信', 980.0, 15, '2025-10-09', '课时包续费');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202589776, 'Chloe', '办卡', '现金', 1980.0, 30, '2025-10-09', '新会员办卡');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202509867, '张三', '续费', '现金', 1280.0, 20, '2025-10-10', '课时包续费');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202523664, 'Lily', '办卡', '银行卡', 1980.0, 30, '2025-10-10', '新会员办卡');
INSERT INTO `payment` (`member_account`, `member_name`, `pay_type`, `pay_way`, `amount`, `class_count`, `pay_time`, `remark`) VALUES (202553468, 'Emma', '续费', '微信', 980.0, 15, '2025-10-10', '课时包续费');

DROP TABLE IF EXISTS `equipment_maintain`;
CREATE TABLE `equipment_maintain`  (
  `maintain_id` int NOT NULL AUTO_INCREMENT COMMENT '维修单号',
  `equipment_id` int NULL DEFAULT NULL COMMENT '器材id',
  `equipment_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '器材名称',
  `fault_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '故障描述',
  `handler` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '处理人',
  `maintain_date` date NULL DEFAULT NULL COMMENT '报修日期',
  `cost` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '维修费用',
  `status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '待维修' COMMENT '维修状态',
  PRIMARY KEY (`maintain_id`) USING BTREE,
  INDEX `idx_mt_equipment`(`equipment_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

INSERT INTO `equipment_maintain` (`equipment_id`, `equipment_name`, `fault_desc`, `handler`, `maintain_date`, `cost`, `status`) VALUES (2, '杠铃1', '杠铃杆轻微弯曲，配重片卡扣松动', '教练2', '2025-10-03', 320.0, '待维修');
INSERT INTO `equipment_maintain` (`equipment_id`, `equipment_name`, `fault_desc`, `handler`, `maintain_date`, `cost`, `status`) VALUES (3, '跑步机1', '跑带跑偏，电机运行有异响', '厂家售后', '2025-10-05', 680.0, '维修中');
INSERT INTO `equipment_maintain` (`equipment_id`, `equipment_name`, `fault_desc`, `handler`, `maintain_date`, `cost`, `status`) VALUES (5, '跑步机3', '控制面板显示闪烁', '教练3', '2025-10-06', 150.0, '已完成');
INSERT INTO `equipment_maintain` (`equipment_id`, `equipment_name`, `fault_desc`, `handler`, `maintain_date`, `cost`, `status`) VALUES (4, '跑步机2', '急停按钮按下后无法复位', '保洁1', '2025-10-07', 0.0, '待维修');
INSERT INTO `equipment_maintain` (`equipment_id`, `equipment_name`, `fault_desc`, `handler`, `maintain_date`, `cost`, `status`) VALUES (6, '杠铃1', '杠铃片缺失两片，已补齐', '教练1', '2025-10-04', 120.0, '已完成');
INSERT INTO `equipment_maintain` (`equipment_id`, `equipment_name`, `fault_desc`, `handler`, `maintain_date`, `cost`, `status`) VALUES (7, '杠铃2', '杠铃架固定螺丝松动，已紧固', '教练4', '2025-10-08', 0.0, '已完成');
INSERT INTO `equipment_maintain` (`equipment_id`, `equipment_name`, `fault_desc`, `handler`, `maintain_date`, `cost`, `status`) VALUES (1, '哑铃1', '橡胶包胶开裂，已更换', '教练2', '2025-10-09', 60.0, '已完成');
INSERT INTO `equipment_maintain` (`equipment_id`, `equipment_name`, `fault_desc`, `handler`, `maintain_date`, `cost`, `status`) VALUES (3, '跑步机1', '定期保养：加注跑带润滑油', '厂家售后', '2025-10-02', 200.0, '已完成');
INSERT INTO `equipment_maintain` (`equipment_id`, `equipment_name`, `fault_desc`, `handler`, `maintain_date`, `cost`, `status`) VALUES (5, '跑步机3', '跑带打滑，张紧度调整', '教练3', '2025-10-03', 80.0, '已完成');
INSERT INTO `equipment_maintain` (`equipment_id`, `equipment_name`, `fault_desc`, `handler`, `maintain_date`, `cost`, `status`) VALUES (4, '跑步机2', '扶手焊点虚接，重新焊接', '厂家售后', '2025-10-09', 260.0, '维修中');

DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告id',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容',
  `author` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发布人',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `is_top` int NULL DEFAULT 0 COMMENT '是否置顶',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

INSERT INTO `notice` (`title`, `content`, `author`, `publish_time`, `is_top`) VALUES ('国庆假期场馆营业时间调整', '10 月 1 日至 10 月 3 日场馆营业时间调整为 09:00-20:00，10 月 4 日起恢复正常（06:30-22:30）。假期期间团课照常进行，请提前 15 分钟到场。', '前台', '2025-10-01 08:30:00', 1);
INSERT INTO `notice` (`title`, `content`, `author`, `publish_time`, `is_top`) VALUES ('新增动感单车与杠铃操两门团课', '应会员需求，本月新增“动感单车”和“杠铃操”两门团课，分别安排在 10 月 8 日 15:00 与 10 月 4 日 15:00，每班限额 20 人，可在“报名选课”中预约。', '教务部', '2025-10-02 10:00:00', 1);
INSERT INTO `notice` (`title`, `content`, `author`, `publish_time`, `is_top`) VALUES ('跑步机 1 号机暂停使用通知', '2 号房间跑步机 1 号机因跑带跑偏正在联系厂家维修，预计 3 个工作日内恢复，期间请使用 2 号、3 号机。给您带来不便敬请谅解。', '设备部', '2025-10-05 16:20:00', 0);
INSERT INTO `notice` (`title`, `content`, `author`, `publish_time`, `is_top`) VALUES ('会员签到功能上线', '即日起会员可在系统中自助签到，签到记录会计入出勤统计。连续签到满 10 天可到前台领取运动毛巾一条。', '运营部', '2025-10-06 09:15:00', 0);
INSERT INTO `notice` (`title`, `content`, `author`, `publish_time`, `is_top`) VALUES ('秋季体测活动报名中', '10 月 7 日至 10 月 10 日提供免费体测服务（体脂率、肌肉量、基础代谢），每人限一次，请在前台登记预约。', '教练组', '2025-10-07 11:00:00', 0);
INSERT INTO `notice` (`title`, `content`, `author`, `publish_time`, `is_top`) VALUES ('私教课程调价说明', '自 10 月 8 日起，一对一体能训练单节价格由 200 元调整为 260 元，已购课包不受影响。', '运营部', '2025-10-08 14:40:00', 0);

-- 已报名课程对应的课时消耗，保持“剩余课时”与报名记录一致
UPDATE `member` m SET m.card_next_class = GREATEST(m.card_class - (SELECT COUNT(*) FROM `class_order` o WHERE o.member_account = m.member_account), 0);


-- ===== 第二批增强（卡到期/课程容量/体测） =====
SET NAMES utf8mb4;

-- ============================================================
-- 第二批增强：会员卡到期日 / 课程容量与教室 / 体测记录
-- ============================================================

ALTER TABLE `member` ADD COLUMN `card_end_date` date NULL DEFAULT NULL COMMENT '会员卡到期日' AFTER `card_next_class`;
UPDATE `member` SET `card_end_date` = '2025-10-05' WHERE `member_account` = 202509867;
UPDATE `member` SET `card_end_date` = '2026-10-02' WHERE `member_account` = 202500788;
UPDATE `member` SET `card_end_date` = '2025-10-28' WHERE `member_account` = 202532539;
UPDATE `member` SET `card_end_date` = '2025-11-02' WHERE `member_account` = 202586416;
UPDATE `member` SET `card_end_date` = '2026-04-04' WHERE `member_account` = 202506725;
UPDATE `member` SET `card_end_date` = '2026-04-05' WHERE `member_account` = 202576587;
UPDATE `member` SET `card_end_date` = '2026-04-06' WHERE `member_account` = 202583406;
UPDATE `member` SET `card_end_date` = '2026-10-07' WHERE `member_account` = 202556754;
UPDATE `member` SET `card_end_date` = '2026-04-08' WHERE `member_account` = 202553468;
UPDATE `member` SET `card_end_date` = '2026-04-08' WHERE `member_account` = 202521345;
UPDATE `member` SET `card_end_date` = '2026-04-09' WHERE `member_account` = 202589776;
UPDATE `member` SET `card_end_date` = '2026-04-10' WHERE `member_account` = 202523664;

ALTER TABLE `class_table` ADD COLUMN `capacity` int NULL DEFAULT 20 COMMENT '课程容量' AFTER `coach`;
ALTER TABLE `class_table` ADD COLUMN `classroom` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上课教室' AFTER `capacity`;
UPDATE `class_table` SET `capacity` = 6, `classroom` = '力量区 A101' WHERE `class_id` = 1;
UPDATE `class_table` SET `capacity` = 4, `classroom` = '瑜伽室 B201' WHERE `class_id` = 2;
UPDATE `class_table` SET `capacity` = 3, `classroom` = '有氧区 A102' WHERE `class_id` = 3;
UPDATE `class_table` SET `capacity` = 8, `classroom` = '康复室 C301' WHERE `class_id` = 4;
UPDATE `class_table` SET `capacity` = 12, `classroom` = '格斗区 D101' WHERE `class_id` = 5;
UPDATE `class_table` SET `capacity` = 10, `classroom` = '操房 B202' WHERE `class_id` = 6;
UPDATE `class_table` SET `capacity` = 10, `classroom` = '瑜伽室 B201' WHERE `class_id` = 7;
UPDATE `class_table` SET `capacity` = 15, `classroom` = '舞蹈室 B203' WHERE `class_id` = 8;
UPDATE `class_table` SET `capacity` = 12, `classroom` = '操房 B202' WHERE `class_id` = 9;
UPDATE `class_table` SET `capacity` = 16, `classroom` = '单车房 A103' WHERE `class_id` = 10;
UPDATE `class_table` SET `capacity` = 20, `classroom` = '操房 B202' WHERE `class_id` = 11;

DROP TABLE IF EXISTS `body_test`;
CREATE TABLE `body_test`  (
  `body_test_id` int NOT NULL AUTO_INCREMENT COMMENT '体测id',
  `member_account` int NULL DEFAULT NULL COMMENT '会员账号',
  `member_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员姓名',
  `test_date` date NULL DEFAULT NULL COMMENT '体测日期',
  `height` int NULL DEFAULT NULL COMMENT '身高(cm)',
  `weight` decimal(5, 1) NULL DEFAULT NULL COMMENT '体重(kg)',
  `body_fat` decimal(4, 1) NULL DEFAULT NULL COMMENT '体脂率(%)',
  `muscle` decimal(5, 1) NULL DEFAULT NULL COMMENT '肌肉量(kg)',
  `bmi` decimal(4, 1) NULL DEFAULT NULL COMMENT 'BMI',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '教练点评',
  PRIMARY KEY (`body_test_id`) USING BTREE,
  INDEX `idx_bt_member`(`member_account`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202509867, '张三', '2025-10-01', 182, 60.2, 19.2, 23.7, 18.2, '状态不错，注意训练后拉伸');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202500788, '李四', '2025-10-02', 178, 61.2, 20.4, 25.8, 19.3, '状态不错，注意训练后拉伸');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202532539, '王五', '2025-10-03', 178, 70.9, 19.4, 29.7, 22.4, '基础代谢正常，建议增加有氧');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202586416, '马六', '2025-10-03', 160, 61.4, 20.3, 25.6, 24.0, '体脂偏高，注意饮食控制');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202506725, 'Tom', '2025-10-04', 178, 83.9, 27.9, 37.4, 26.5, '基础代谢正常，建议增加有氧');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202509867, '张三', '2025-10-04', 182, 59.1, 18.6, 23.9, 17.8, '状态不错，注意训练后拉伸');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202500788, '李四', '2025-10-05', 178, 60.0, 19.7, 26.0, 18.9, '肌肉量提升明显，保持训练频率');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202576587, 'Jack', '2025-10-05', 177, 61.4, 20.7, 26.8, 19.6, '体脂偏高，注意饮食控制');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202532539, '王五', '2025-10-06', 178, 69.9, 18.9, 30.2, 22.1, '状态不错，注意训练后拉伸');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202583406, 'Tylor', '2025-10-06', 170, 64.0, 17.1, 27.7, 22.1, '');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202586416, '马六', '2025-10-06', 160, 60.8, 19.9, 25.9, 23.7, '体重下降但肌肉量保持不变，减脂效果好');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202506725, 'Tom', '2025-10-07', 178, 82.7, 27.2, 37.7, 26.1, '体脂偏高，注意饮食控制');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202556754, 'Mike', '2025-10-07', 166, 80.4, 20.0, 36.4, 29.2, '');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202509867, '张三', '2025-10-08', 182, 58.3, 17.7, 24.5, 17.6, '');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202521345, 'Ava', '2025-10-08', 160, 64.0, 26.1, 28.8, 25.0, '肌肉量提升明显，保持训练频率');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202553468, 'Emma', '2025-10-08', 173, 59.2, 19.6, 24.4, 19.8, '体脂偏高，注意饮食控制');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202576587, 'Jack', '2025-10-08', 177, 60.5, 20.0, 27.3, 19.3, '体脂偏高，注意饮食控制');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202500788, '李四', '2025-10-09', 178, 59.5, 19.4, 26.3, 18.8, '肌肉量提升明显，保持训练频率');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202583406, 'Tylor', '2025-10-09', 170, 63.3, 16.5, 28.0, 21.9, '状态不错，注意训练后拉伸');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202589776, 'Chloe', '2025-10-09', 170, 78.9, 18.0, 30.5, 27.3, '肌肉量提升明显，保持训练频率');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202523664, 'Lily', '2025-10-10', 165, 66.6, 26.2, 30.0, 24.5, '');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202532539, '王五', '2025-10-10', 178, 69.3, 17.9, 30.3, 21.9, '状态不错，注意训练后拉伸');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202556754, 'Mike', '2025-10-10', 166, 79.3, 19.4, 36.9, 28.8, '体重下降但肌肉量保持不变，减脂效果好');
INSERT INTO `body_test` (`member_account`, `member_name`, `test_date`, `height`, `weight`, `body_fat`, `muscle`, `bmi`, `remark`) VALUES (202586416, '马六', '2025-10-10', 160, 59.8, 18.8, 26.3, 23.4, '体重下降但肌肉量保持不变，减脂效果好');



-- ===== 第三批增强（操作日志） =====
SET NAMES utf8mb4;

-- ============================================================
-- 第三批增强：操作日志
-- ============================================================

DROP TABLE IF EXISTS `operation_log`;
CREATE TABLE `operation_log`  (
  `log_id` int NOT NULL AUTO_INCREMENT COMMENT '日志id',
  `operator` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人',
  `role` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色',
  `action` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作动作',
  `uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求地址',
  `detail` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数摘要',
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '来源IP',
  `created_at` datetime NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`log_id`) USING BTREE,
  INDEX `idx_log_time`(`created_at`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;
