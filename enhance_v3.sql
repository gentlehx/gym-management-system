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

