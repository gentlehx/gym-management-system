package com.milotnt.service;

import com.milotnt.pojo.CheckIn;

import java.util.List;

/**
 * 会员签到
 *
 * @author MiloTnT
 */
public interface CheckInService {

    List<CheckIn> findAll();

    List<CheckIn> selectByMemberAccount(Integer memberAccount);

    CheckIn selectByMemberAndDate(Integer memberAccount, String checkInDate);

    Boolean insertCheckIn(CheckIn checkIn);

    Boolean deleteById(Integer checkInId);

    Integer selectCountByDate(String checkInDate);

    Integer selectMemberCountByDate(String checkInDate);

    String selectLatestDate();

    Integer selectTotalCount();

    List<String> selectMemberDates(Integer memberAccount);
}
