package com.milotnt.pojo;

/**
 * 操作日志
 *
 * @author MiloTnT
 */
public class OperationLog {

    private Integer logId;
    private String operator;
    private String role;
    private String action;
    private String uri;
    private String detail;
    private String ip;
    private String createdAt;

    public Integer getLogId() {
        return logId;
    }

    public void setLogId(Integer logId) {
        this.logId = logId;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getUri() {
        return uri;
    }

    public void setUri(String uri) {
        this.uri = uri;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "OperationLog{" +
                "operator='" + operator + '\'' +
                ", action='" + action + '\'' +
                ", uri='" + uri + '\'' +
                ", createdAt='" + createdAt + '\'' +
                '}';
    }
}
