package com.milotnt.service.impl;

import com.milotnt.mapper.PaymentMapper;
import com.milotnt.pojo.Payment;
import com.milotnt.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

/**
 * @author MiloTnT
 */
@Service
public class PaymentServiceImpl implements PaymentService {

    @Autowired
    private PaymentMapper paymentMapper;

    @Override
    public List<Payment> findAll() {
        return paymentMapper.findAll();
    }

    @Override
    public List<Payment> selectByRange(String start, String end) {
        return paymentMapper.selectByRange(start, end);
    }

    @Override
    public BigDecimal selectSumByRange(String start, String end) {
        return paymentMapper.selectSumByRange(start, end);
    }

    @Override
    public Integer selectCountByRange(String start, String end) {
        return paymentMapper.selectCountByRange(start, end);
    }

    @Override
    public List<Payment> selectByMemberAccount(Integer memberAccount) {
        return paymentMapper.selectByMemberAccount(memberAccount);
    }

    @Override
    public Boolean insertPayment(Payment payment) {
        return paymentMapper.insertPayment(payment) > 0;
    }

    @Override
    public Boolean deleteById(Integer paymentId) {
        return paymentMapper.deleteById(paymentId) > 0;
    }

    @Override
    public BigDecimal selectTotalAmount() {
        return paymentMapper.selectTotalAmount();
    }

    @Override
    public Integer selectTotalCount() {
        return paymentMapper.selectTotalCount();
    }

    @Override
    public BigDecimal selectAmountByMember(Integer memberAccount) {
        return paymentMapper.selectAmountByMember(memberAccount);
    }
}
