package com.milotnt.mapper;

import com.milotnt.pojo.BodyTest;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 体测记录
 *
 * @author MiloTnT
 */
@Mapper
public interface BodyTestMapper {

    //查询全部体测记录
    List<BodyTest> findAll();

    //查询某会员的体测记录（按日期正序，便于画趋势）
    List<BodyTest> selectByMemberAccount(Integer memberAccount);

    //新增体测记录
    Integer insertBodyTest(BodyTest bodyTest);

    //删除体测记录
    Integer deleteById(Integer bodyTestId);

    //记录条数
    Integer selectTotalCount();

    //参与体测的会员数
    Integer selectMemberCount();
}
