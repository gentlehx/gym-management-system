package com.milotnt.interceptor;

import com.milotnt.pojo.Admin;
import com.milotnt.pojo.Member;
import com.milotnt.pojo.OperationLog;
import com.milotnt.service.OperationLogService;
import com.milotnt.util.BusinessClock;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 操作日志拦截器：把关键写操作记录到 operation_log 表。
 * 只做旁路记录，任何异常都不影响主流程。
 *
 * @author MiloTnT
 */
@Component
public class OperationLogInterceptor implements HandlerInterceptor {

    private static final Logger logger = LoggerFactory.getLogger(OperationLogInterceptor.class);

    @Autowired
    private OperationLogService operationLogService;

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler,
                                Exception ex) {
        try {
            String uri = request.getRequestURI();
            if (!isWriteOperation(uri)) {
                return;
            }
            //只记录执行成功的请求
            if (response.getStatus() >= 400) {
                return;
            }

            OperationLog log = new OperationLog();
            log.setUri(uri);
            log.setAction(resolveAction(uri));
            log.setCreatedAt(BusinessClock.currentDateTime());
            log.setIp(clientIp(request));

            HttpSession session = request.getSession(false);
            log.setOperator("匿名访客");
            log.setRole("未登录");
            if (session != null) {
                Object admin = session.getAttribute("admin");
                Object user = session.getAttribute("user");
                if (admin instanceof Admin) {
                    log.setOperator("管理员" + ((Admin) admin).getAdminAccount());
                    log.setRole("管理员");
                } else if (user instanceof Member) {
                    Member m = (Member) user;
                    log.setOperator(m.getMemberName() + "（" + m.getMemberAccount() + "）");
                    log.setRole("会员");
                }
            }

            log.setDetail(buildDetail(request));
            operationLogService.insertLog(log);
        } catch (Exception e) {
            //日志失败不影响业务，但要留下痕迹便于排查
            logger.warn("操作日志写入失败: {}", e.getMessage());
        }
    }

    //判断是否为写操作（本工程部分写操作仍使用 GET，因此按路径关键字识别）
    private boolean isWriteOperation(String uri) {
        String[] keys = {"/add", "/del", "/update", "/finish", "/apply", "/doCheckIn", "/top",
                "adminLogin", "userLogin"};
        for (String key : keys) {
            if (uri.contains(key)) {
                return true;
            }
        }
        return false;
    }

    //把请求地址翻译成可读的动作名
    private String resolveAction(String uri) {
        if (uri.contains("adminLogin")) return "管理员登录";
        if (uri.contains("userLogin")) return "会员登录";
        if (uri.contains("doCheckIn")) return "会员自助签到";
        if (uri.contains("addCheckIn") || uri.contains("addCheckin")) return "代会员签到";
        if (uri.contains("delCheckIn") || uri.contains("delCheckin")) return "删除签到记录";
        if (uri.contains("addPayment")) return "新增收费";
        if (uri.contains("delPayment")) return "删除收费记录";
        if (uri.contains("addMaintain")) return "登记器材维修";
        if (uri.contains("finishMaintain")) return "完成器材维修";
        if (uri.contains("delMaintain")) return "删除维修记录";
        if (uri.contains("addNotice")) return "发布公告";
        if (uri.contains("delNotice")) return "删除公告";
        if (uri.contains("topNotice")) return "公告置顶切换";
        if (uri.contains("addBodyTest")) return "新增体测记录";
        if (uri.contains("delBodyTest")) return "删除体测记录";
        if (uri.contains("applyClass")) return "报名课程";
        if (uri.contains("delUserClass")) return "退课";
        if (uri.contains("addMember")) return "新增会员";
        if (uri.contains("delMember")) return "删除会员";
        if (uri.contains("updateMember")) return "修改会员信息";
        if (uri.contains("addEmployee")) return "新增员工";
        if (uri.contains("delEmployee")) return "删除员工";
        if (uri.contains("updateEmployee")) return "修改员工信息";
        if (uri.contains("addEquipment")) return "新增器材";
        if (uri.contains("delEquipment")) return "删除器材";
        if (uri.contains("updateEquipment")) return "修改器材信息";
        if (uri.contains("addClass")) return "新增课程";
        if (uri.contains("delClass")) return "删除课程";
        if (uri.contains("updateInfo")) return "修改个人资料";
        return "写操作";
    }

    //参数摘要：隐藏密码，超长截断
    private String buildDetail(HttpServletRequest request) {
        Map<String, String[]> params = request.getParameterMap();
        StringBuilder sb = new StringBuilder();
        for (Map.Entry<String, String[]> entry : params.entrySet()) {
            String key = entry.getKey();
            if (key.toLowerCase().contains("password")) {
                continue;
            }
            String[] values = entry.getValue();
            String value = (values == null || values.length == 0) ? "" : String.join(",", values);
            if (value.isEmpty()) {
                continue;
            }
            if (sb.length() > 0) {
                sb.append("; ");
            }
            sb.append(key).append("=").append(value);
            if (sb.length() > 400) {
                break;
            }
        }
        String detail = sb.toString();
        return detail.length() > 450 ? detail.substring(0, 450) + "..." : detail;
    }

    private String clientIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip != null && !ip.isEmpty() && !"unknown".equalsIgnoreCase(ip)) {
            int idx = ip.indexOf(',');
            return idx > 0 ? ip.substring(0, idx).trim() : ip.trim();
        }
        return request.getRemoteAddr();
    }
}
