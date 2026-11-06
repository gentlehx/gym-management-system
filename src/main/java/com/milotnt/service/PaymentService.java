package com.milotnt.service;

import com.milotnt.pojo.Payment;

import java.math.BigDecimal;
import java.util.List;

/**
 * 收费流水
 *
 * @author MiloTnT
 */
public interface PaymentService {

    List<Payment> findAll();

    List<Payment> selectByRange(String start, String end);

    BigDecimal selectSumByRange(String start, String end);

    Integer selectCountByRange(String start, String end);

    List<Payment> selectByMemberAccount(Integer memberAccount);

    Boolean insertPayment(Payment payment);

    Boolean deleteById(Integer paymentId);

    BigDecimal selectTotalAmount();

    Integer selectTotalCount();

    BigDecimal selectAmountByMember(Integer memberAccount);
}
