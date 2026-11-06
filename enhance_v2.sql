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
