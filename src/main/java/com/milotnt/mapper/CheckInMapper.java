package com.milotnt.mapper;

import com.milotnt.pojo.CheckIn;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 会员签到
 *
 * @author MiloTnT
 */
@Mapper
public interface CheckInMapper {

    //查询全部签到记录（按时间倒序）
    List<CheckIn> findAll();

    //查询某会员的签到记录
    List<CheckIn> selectByMemberAccount(Integer memberAccount);

    //查询某会员某天是否已签到
    CheckIn selectByMemberAndDate(@Param("memberAccount") Integer memberAccount, @Param("checkInDate") String checkInDate);

    //新增签到
    Integer insertCheckIn(CheckIn checkIn);

    //删除签到
    Integer deleteById(Integer checkInId);

    //某天签到人次
    Integer selectCountByDate(String checkInDate);

    //某天签到人数（去重）
    Integer selectMemberCountByDate(String checkInDate);

    //最近一个有签到记录的日期（演示数据为 2025 年 10 月）
    String selectLatestDate();

    //签到总条数
    Integer selectTotalCount();

    //某会员连续签到天数（从最近一次签到往前数）
    List<String> selectMemberDates(Integer memberAccount);
}
