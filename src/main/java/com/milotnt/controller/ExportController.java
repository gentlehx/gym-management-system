package com.milotnt.controller;

import com.milotnt.pojo.BodyTest;
import com.milotnt.pojo.CheckIn;
import com.milotnt.pojo.Member;
import com.milotnt.pojo.Payment;
import com.milotnt.service.BodyTestService;
import com.milotnt.service.CheckInService;
import com.milotnt.service.MemberService;
import com.milotnt.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 数据导出（CSV，可直接用 Excel 打开）
 *
 * @author MiloTnT
 */
@Controller
@RequestMapping("/export")
public class ExportController {

    @Autowired
    private MemberService memberService;
    @Autowired
    private PaymentService paymentService;
    @Autowired
    private CheckInService checkInService;
    @Autowired
    private BodyTestService bodyTestService;

    //导出会员
    @RequestMapping("/member")
    public void exportMember(HttpServletResponse response) throws IOException {
        StringBuilder sb = new StringBuilder();
        sb.append("会员账号,姓名,性别,年龄,身高(cm),体重(kg),手机号,办卡时间,会员卡到期日,购买课时,剩余课时\r\n");
        List<Member> list = memberService.findAll();
        for (Member m : list) {
            sb.append(csv(String.valueOf(m.getMemberAccount()))).append(',')
                    .append(csv(m.getMemberName())).append(',')
                    .append(csv(m.getMemberGender())).append(',')
                    .append(csv(String.valueOf(m.getMemberAge()))).append(',')
                    .append(csv(String.valueOf(m.getMemberHeight()))).append(',')
                    .append(csv(String.valueOf(m.getMemberWeight()))).append(',')
                    .append(csv(String.valueOf(m.getMemberPhone()))).append(',')
                    .append(csv(m.getCardTime())).append(',')
                    .append(csv(m.getCardEndDate())).append(',')
                    .append(csv(String.valueOf(m.getCardClass()))).append(',')
                    .append(csv(String.valueOf(m.getCardNextClass()))).append("\r\n");
        }
        write(response, "members", sb.toString());
    }

    //导出收费流水
    @RequestMapping("/payment")
    public void exportPayment(HttpServletResponse response) throws IOException {
        StringBuilder sb = new StringBuilder();
        sb.append("流水号,收费日期,会员账号,会员姓名,收费类型,支付方式,金额(元),课时,备注\r\n");
        List<Payment> list = paymentService.findAll();
        for (Payment p : list) {
            sb.append(csv(String.valueOf(p.getPaymentId()))).append(',')
                    .append(csv(p.getPayTime())).append(',')
                    .append(csv(String.valueOf(p.getMemberAccount()))).append(',')
                    .append(csv(p.getMemberName())).append(',')
                    .append(csv(p.getPayType())).append(',')
                    .append(csv(p.getPayWay())).append(',')
                    .append(csv(String.valueOf(p.getAmount()))).append(',')
                    .append(csv(String.valueOf(p.getClassCount()))).append(',')
                    .append(csv(p.getRemark())).append("\r\n");
        }
        write(response, "payments", sb.toString());
    }

    //导出签到记录
    @RequestMapping("/checkin")
    public void exportCheckIn(HttpServletResponse response) throws IOException {
        StringBuilder sb = new StringBuilder();
        sb.append("签到日期,签到时间,会员账号,会员姓名,签到类型,备注\r\n");
        List<CheckIn> list = checkInService.findAll();
        for (CheckIn c : list) {
            sb.append(csv(c.getCheckInDate())).append(',')
                    .append(csv(c.getCheckInTime())).append(',')
                    .append(csv(String.valueOf(c.getMemberAccount()))).append(',')
                    .append(csv(c.getMemberName())).append(',')
                    .append(csv(c.getCheckInType())).append(',')
                    .append(csv(c.getRemark())).append("\r\n");
        }
        write(response, "checkins", sb.toString());
    }

    //导出体测记录
    @RequestMapping("/bodytest")
    public void exportBodyTest(HttpServletResponse response) throws IOException {
        StringBuilder sb = new StringBuilder();
        sb.append("体测日期,会员账号,会员姓名,身高(cm),体重(kg),体脂率(%),肌肉量(kg),BMI,教练点评\r\n");
        List<BodyTest> list = bodyTestService.findAll();
        for (BodyTest b : list) {
            sb.append(csv(b.getTestDate())).append(',')
                    .append(csv(String.valueOf(b.getMemberAccount()))).append(',')
                    .append(csv(b.getMemberName())).append(',')
                    .append(csv(String.valueOf(b.getHeight()))).append(',')
                    .append(csv(String.valueOf(b.getWeight()))).append(',')
                    .append(csv(String.valueOf(b.getBodyFat()))).append(',')
                    .append(csv(String.valueOf(b.getMuscle()))).append(',')
                    .append(csv(String.valueOf(b.getBmi()))).append(',')
                    .append(csv(b.getRemark())).append("\r\n");
        }
        write(response, "bodytests", sb.toString());
    }

    //CSV 转义
    private String csv(String value) {
        if (value == null || "null".equals(value)) {
            return "";
        }
        if (value.contains(",") || value.contains("\"") || value.contains("\n")) {
            return "\"" + value.replace("\"", "\"\"") + "\"";
        }
        return value;
    }

    private void write(HttpServletResponse response, String fileName, String content) throws IOException {
        String date = new SimpleDateFormat("yyyyMMdd").format(new Date());
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/csv;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "_" + date + ".csv\"");
        PrintWriter writer = response.getWriter();
        //BOM：让 Excel 正确识别 UTF-8 中文
        writer.write('\uFEFF');
        writer.write(content);
        writer.flush();
    }
}
