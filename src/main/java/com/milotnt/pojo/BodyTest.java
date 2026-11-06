package com.milotnt.pojo;

import java.math.BigDecimal;

/**
 * 会员体测记录
 *
 * @author MiloTnT
 */
public class BodyTest {

    private Integer bodyTestId;
    private Integer memberAccount;
    private String memberName;
    private String testDate;
    private Integer height;
    private BigDecimal weight;
    private BigDecimal bodyFat;
    private BigDecimal muscle;
    private BigDecimal bmi;
    private String remark;

    public Integer getBodyTestId() {
        return bodyTestId;
    }

    public void setBodyTestId(Integer bodyTestId) {
        this.bodyTestId = bodyTestId;
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

    public String getTestDate() {
        return testDate;
    }

    public void setTestDate(String testDate) {
        this.testDate = testDate;
    }

    public Integer getHeight() {
        return height;
    }

    public void setHeight(Integer height) {
        this.height = height;
    }

    public BigDecimal getWeight() {
        return weight;
    }

    public void setWeight(BigDecimal weight) {
        this.weight = weight;
    }

    public BigDecimal getBodyFat() {
        return bodyFat;
    }

    public void setBodyFat(BigDecimal bodyFat) {
        this.bodyFat = bodyFat;
    }

    public BigDecimal getMuscle() {
        return muscle;
    }

    public void setMuscle(BigDecimal muscle) {
        this.muscle = muscle;
    }

    public BigDecimal getBmi() {
        return bmi;
    }

    public void setBmi(BigDecimal bmi) {
        this.bmi = bmi;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Override
    public String toString() {
        return "BodyTest{" +
                "bodyTestId=" + bodyTestId +
                ", memberAccount=" + memberAccount +
                ", memberName='" + memberName + '\'' +
                ", testDate='" + testDate + '\'' +
                ", weight=" + weight +
                ", bodyFat=" + bodyFat +
                ", bmi=" + bmi +
                '}';
    }
}
