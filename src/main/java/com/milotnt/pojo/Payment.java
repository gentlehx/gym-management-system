package com.milotnt.pojo;

import java.math.BigDecimal;

/**
 * 收费流水
 *
 * @author MiloTnT
 */
public class Payment {

    private Integer paymentId;
    private Integer memberAccount;
    private String memberName;
    private String payType;
    private String payWay;
    private BigDecimal amount;
    private Integer classCount;
    private String payTime;
    private String remark;

    public Integer getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(Integer paymentId) {
        this.paymentId = paymentId;
    }

    public Integer getMemberAccount() {
        return memberAccount;
    }

    public void setMemberAccount(Integer memberAccount) {
        this.memberAccount = memberAccount;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public String getPayType() {
        return payType;
    }

    public void setPayType(String payType) {
        this.payType = payType;
    }

    public String getPayWay() {
        return payWay;
    }

    public void setPayWay(String payWay) {
        this.payWay = payWay;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public Integer getClassCount() {
        return classCount;
    }

    public void setClassCount(Integer classCount) {
        this.classCount = classCount;
    }

    public String getPayTime() {
        return payTime;
    }

    public void setPayTime(String payTime) {
        this.payTime = payTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Override
    public String toString() {
        return "Payment{" +
                "paymentId=" + paymentId +
                ", memberAccount=" + memberAccount +
                ", memberName='" + memberName + '\'' +
                ", payType='" + payType + '\'' +
                ", amount=" + amount +
                ", payTime='" + payTime + '\'' +
                '}';
    }
}
