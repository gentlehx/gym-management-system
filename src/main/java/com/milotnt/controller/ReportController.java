package com.milotnt.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.milotnt.mapper.StatsMapper;
import com.milotnt.pojo.Payment;
import com.milotnt.service.ClassOrderService;
import com.milotnt.service.PaymentService;
import com.milotnt.util.BusinessClock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;

/**
 * 报表中心
 *
 * @author MiloTnT
 */
@Controller
@RequestMapping("/report")
public class ReportController {

    @Autowired
    private StatsMapper statsMapper;
    @Autowired
    private PaymentService paymentService;
    @Autowired
    private ClassOrderService classOrderService;

    private final ObjectMapper objectMapper = new ObjectMapper();

    @RequestMapping("/selReport")
    public String selectReport(String start, String end, Model model) {
        String[] range = normalize(start, end);
        String from = range[0];
        String to = range[1];

        List<Payment> paymentList = paymentService.selectByRange(from, to);
        BigDecimal income = paymentService.selectSumByRange(from, to);
        Integer payCount = paymentService.selectCountByRange(from, to);
        Integer checkInCount = statsMapper.selectCheckInCountByRange(from, to);
        Integer newMember = statsMapper.selectNewMemberByRange(from, to);

        BigDecimal avgTicket = BigDecimal.ZERO;
        if (payCount != null && payCount > 0) {
            avgTicket = income.divide(new BigDecimal(payCount), 0, RoundingMode.HALF_UP);
        }
        long days = java.time.temporal.ChronoUnit.DAYS.between(LocalDate.parse(from), LocalDate.parse(to)) + 1;
        int avgCheckIn = days > 0 ? Math.round(checkInCount / (float) days) : 0;

        model.addAttribute("start", from);
        model.addAttribute("end", to);
        model.addAttribute("days", days);
        model.addAttribute("paymentList", paymentList);
        model.addAttribute("income", income);
        model.addAttribute("payCount", payCount);
        model.addAttribute("avgTicket", avgTicket);
        model.addAttribute("checkInCount", checkInCount);
        model.addAttribute("avgCheckIn", avgCheckIn);
        model.addAttribute("newMember", newMember);
        model.addAttribute("orderTotal", classOrderService.findAll().size());

        try {
            model.addAttribute("dailyIncomeJson", objectMapper.writeValueAsString(statsMapper.selectDailyIncome(from, to)));
            model.addAttribute("incomeTypeJson", objectMapper.writeValueAsString(statsMapper.selectIncomeByTypeRange(from, to)));
            model.addAttribute("checkInJson", objectMapper.writeValueAsString(statsMapper.selectCheckInByRange(from, to)));
        } catch (Exception e) {
            model.addAttribute("dailyIncomeJson", "[]");
            model.addAttribute("incomeTypeJson", "[]");
            model.addAttribute("checkInJson", "[]");
        }
        return "report";
    }

    //导出区间收费明细
    @RequestMapping("/export")
    public void export(String start, String end, HttpServletResponse response) throws IOException {
        String[] range = normalize(start, end);
        List<Payment> list = paymentService.selectByRange(range[0], range[1]);

        StringBuilder sb = new StringBuilder();
        sb.append("收费日期,会员账号,会员姓名,收费类型,支付方式,金额(元),课时,备注\r\n");
        for (Payment p : list) {
            sb.append(csv(p.getPayTime())).append(',')
                    .append(csv(String.valueOf(p.getMemberAccount()))).append(',')
                    .append(csv(p.getMemberName())).append(',')
                    .append(csv(p.getPayType())).append(',')
                    .append(csv(p.getPayWay())).append(',')
                    .append(csv(String.valueOf(p.getAmount()))).append(',')
                    .append(csv(String.valueOf(p.getClassCount()))).append(',')
                    .append(csv(p.getRemark())).append("\r\n");
        }

        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/csv;charset=UTF-8");
        response.setHeader("Content-Disposition",
                "attachment; filename=\"report_" + range[0].replace("-", "") + "_" + range[1].replace("-", "") + ".csv\"");
        PrintWriter writer = response.getWriter();
        writer.write('\uFEFF');
        writer.write(sb.toString());
        writer.flush();
    }

    //日期参数校正：缺省取 10 月上旬，起止颠倒时自动交换
    private String[] normalize(String start, String end) {
        String from = (start == null || start.trim().isEmpty()) ? "2025-10-01" : start.trim();
        String to = (end == null || end.trim().isEmpty()) ? BusinessClock.BUSINESS_DATE : end.trim();
        try {
            LocalDate d1 = LocalDate.parse(from);
            LocalDate d2 = LocalDate.parse(to);
            if (d1.isAfter(d2)) {
                return new String[]{d2.toString(), d1.toString()};
            }
            return new String[]{d1.toString(), d2.toString()};
        } catch (DateTimeParseException e) {
            return new String[]{"2025-10-01", BusinessClock.BUSINESS_DATE};
        }
    }

    private String csv(String value) {
        if (value == null || "null".equals(value)) {
            return "";
        }
        if (value.contains(",") || value.contains("\"") || value.contains("\n")) {
            return "\"" + value.replace("\"", "\"\"") + "\"";
        }
        return value;
    }
}
