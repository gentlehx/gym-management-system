package com.milotnt.mapper;

import com.milotnt.pojo.Payment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

/**
 * 收费流水
 *
 * @author MiloTnT
 */
@Mapper
public interface PaymentMapper {

    //查询全部收费流水
    List<Payment> findAll();

    //按日期区间查询收费流水
    List<Payment> selectByRange(@Param("start") String start, @Param("end") String end);

    //按日期区间统计收入
    BigDecimal selectSumByRange(@Param("start") String start, @Param("end") String end);

    //按日期区间统计笔数
    Integer selectCountByRange(@Param("start") String start, @Param("end") String end);

    //查询某会员的消费记录
    List<Payment> selectByMemberAccount(Integer memberAccount);

    //新增收费记录
    Integer insertPayment(Payment payment);

    //删除收费记录
    Integer deleteById(Integer paymentId);

    //收入合计
    BigDecimal selectTotalAmount();

    //收费笔数
    Integer selectTotalCount();

    //某会员消费合计
    BigDecimal selectAmountByMember(Integer memberAccount);
}
