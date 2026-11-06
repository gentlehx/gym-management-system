package com.milotnt.service.impl;

import com.milotnt.mapper.BodyTestMapper;
import com.milotnt.pojo.BodyTest;
import com.milotnt.service.BodyTestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author MiloTnT
 */
@Service
public class BodyTestServiceImpl implements BodyTestService {

    @Autowired
    private BodyTestMapper bodyTestMapper;

    @Override
    public List<BodyTest> findAll() {
        return bodyTestMapper.findAll();
    }

    @Override
    public List<BodyTest> selectByMemberAccount(Integer memberAccount) {
        return bodyTestMapper.selectByMemberAccount(memberAccount);
    }

    @Override
    public Boolean insertBodyTest(BodyTest bodyTest) {
        return bodyTestMapper.insertBodyTest(bodyTest) > 0;
    }

    @Override
    public Boolean deleteById(Integer bodyTestId) {
        return bodyTestMapper.deleteById(bodyTestId) > 0;
    }

    @Override
    public Integer selectTotalCount() {
        return bodyTestMapper.selectTotalCount();
    }

    @Override
    public Integer selectMemberCount() {
        return bodyTestMapper.selectMemberCount();
    }
}
