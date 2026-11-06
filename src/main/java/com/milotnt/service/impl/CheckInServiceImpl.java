package com.milotnt.service.impl;

import com.milotnt.mapper.CheckInMapper;
import com.milotnt.pojo.CheckIn;
import com.milotnt.service.CheckInService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author MiloTnT
 */
@Service
public class CheckInServiceImpl implements CheckInService {

    @Autowired
    private CheckInMapper checkInMapper;

    @Override
    public List<CheckIn> findAll() {
        return checkInMapper.findAll();
    }

    @Override
    public List<CheckIn> selectByMemberAccount(Integer memberAccount) {
        return checkInMapper.selectByMemberAccount(memberAccount);
    }

    @Override
    public CheckIn selectByMemberAndDate(Integer memberAccount, String checkInDate) {
        return checkInMapper.selectByMemberAndDate(memberAccount, checkInDate);
    }

    @Override
    public Boolean insertCheckIn(CheckIn checkIn) {
        return checkInMapper.insertCheckIn(checkIn) > 0;
    }

    @Override
    public Boolean deleteById(Integer checkInId) {
        return checkInMapper.deleteById(checkInId) > 0;
    }

    @Override
    public Integer selectCountByDate(String checkInDate) {
        return checkInMapper.selectCountByDate(checkInDate);
    }

    @Override
    public Integer selectMemberCountByDate(String checkInDate) {
        return checkInMapper.selectMemberCountByDate(checkInDate);
    }

    @Override
    public String selectLatestDate() {
        return checkInMapper.selectLatestDate();
    }

    @Override
    public Integer selectTotalCount() {
        return checkInMapper.selectTotalCount();
    }

    @Override
    public List<String> selectMemberDates(Integer memberAccount) {
        return checkInMapper.selectMemberDates(memberAccount);
    }
}
