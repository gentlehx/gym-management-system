package com.milotnt.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 数据看板统计
 *
 * @author MiloTnT
 */
@Mapper
public interface StatsMapper {

    //按日收入（区间）
    List<Map<String, Object>> selectDailyIncome(@Param("start") String start, @Param("end") String end);

    //收入构成（区间）
    List<Map<String, Object>> selectIncomeByTypeRange(@Param("start") String start, @Param("end") String end);

    //签到趋势（区间）
    List<Map<String, Object>> selectCheckInByRange(@Param("start") String start, @Param("end") String end);

    //区间新增会员
    Integer selectNewMemberByRange(@Param("start") String start, @Param("end") String end);

    //区间签到人次
    Integer selectCheckInCountByRange(@Param("start") String start, @Param("end") String end);

    //近 10 天签到趋势
    List<Map<String, Object>> selectCheckInTrend();

    //课程报名排行
    List<Map<String, Object>> selectClassRank();

    //收入构成（按收费类型）
    List<Map<String, Object>> selectIncomeByType();

    //器材状态分布
    List<Map<String, Object>> selectEquipmentStatus();

    //支付方式分布
    List<Map<String, Object>> selectPayWayStat();

    //课程报名总数
    Integer selectOrderTotal();

    //器材总数 / 正常数
    Integer selectEquipmentTotal();

    Integer selectEquipmentNormal();

    //会员平均剩余课时
    Double selectAvgLeftClass();

    //最新数据日期
    String selectBusinessDate();
}
