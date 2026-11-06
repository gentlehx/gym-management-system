package com.milotnt.pojo;

/**
 * 会员签到记录
 *
 * @author MiloTnT
 */
public class CheckIn {

    private Integer checkInId;
    private Integer memberAccount;
    private String memberName;
    private String checkInDate;
    private String checkInTime;
    private String checkInType;
    private String remark;

    public Integer getCheckInId() {
        return checkInId;
    }

    public void setCheckInId(Integer checkInId) {
        this.checkInId = checkInId;
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

    public String getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(String checkInDate) {
        this.checkInDate = checkInDate;
    }

    public String getCheckInTime() {
        return checkInTime;
    }

    public void setCheckInTime(String checkInTime) {
        this.checkInTime = checkInTime;
    }

    public String getCheckInType() {
        return checkInType;
    }

    public void setCheckInType(String checkInType) {
        this.checkInType = checkInType;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Override
    public String toString() {
        return "CheckIn{" +
                "checkInId=" + checkInId +
                ", memberAccount=" + memberAccount +
                ", memberName='" + memberName + '\'' +
                ", checkInDate='" + checkInDate + '\'' +
                ", checkInTime='" + checkInTime + '\'' +
                ", checkInType='" + checkInType + '\'' +
                '}';
    }
}
