package com.milotnt.service;

import com.milotnt.pojo.BodyTest;

import java.util.List;

/**
 * 体测记录
 *
 * @author MiloTnT
 */
public interface BodyTestService {

    List<BodyTest> findAll();

    List<BodyTest> selectByMemberAccount(Integer memberAccount);

    Boolean insertBodyTest(BodyTest bodyTest);

    Boolean deleteById(Integer bodyTestId);

    Integer selectTotalCount();

    Integer selectMemberCount();
}
