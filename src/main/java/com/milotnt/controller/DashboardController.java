package com.milotnt.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.milotnt.mapper.StatsMapper;
import com.milotnt.pojo.CheckIn;
import com.milotnt.pojo.Member;
import com.milotnt.service.CheckInService;
import com.milotnt.service.EmployeeService;
import com.milotnt.service.EquipmentMaintainService;
import com.milotnt.service.EquipmentService;
import com.milotnt.service.MemberService;
import com.milotnt.service.NoticeService;
import com.milotnt.service.PaymentService;
import com.milotnt.util.BusinessClock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

/**
 * 管理员数据看板
 *
 * @author MiloTnT
 */
@Controller
@RequestMapping("/admin")
public class DashboardController {

    @Autowired
    private StatsMapper statsMapper;
    @Autowired
    private MemberService memberService;
    @Autowired
    private EmployeeService employeeService;
    @Autowired
    private EquipmentService equipmentService;
    @Autowired
    private CheckInService checkInService;
    @Autowired
    private PaymentService paymentService;
    @Autowired
    private NoticeService noticeService;
    @Autowired
    private EquipmentMaintainService maintainService;

    private final ObjectMapper objectMapper = new ObjectMapper();

    @RequestMapping("/dashboard")
    public String dashboard(Model model) {
        //业务日期：取最近一条签到记录的日期，没有数据时回落到演示基准日
        String businessDate = statsMapper.selectBusinessDate();
        if (businessDate == null || businessDate.trim().isEmpty()) {
            businessDate = BusinessClock.BUSINESS_DATE;
        }

        //基础人数
        Integer memberTotal = memberService.selectTotalCount();
        Integer employeeTotal = employeeService.selectTotalCount();
        Integer equipmentTotal = equipmentService.selectTotalCount();

        //签到
        Integer todayCheckIn = checkInService.selectCountByDate(businessDate);
        Integer todayCheckInMember = checkInService.selectMemberCountByDate(businessDate);
        Integer checkInTotal = checkInService.selectTotalCount();
        List<CheckIn> checkInList = checkInService.findAll();
        List<CheckIn> recentCheckIn = new ArrayList<>();
        for (int i = 0; i < checkInList.size() && i < 8; i++) {
            recentCheckIn.add(checkInList.get(i));
        }

        //收费
        java.math.BigDecimal incomeTotal = paymentService.selectTotalAmount();
        Integer paymentCount = paymentService.selectTotalCount();
        java.math.BigDecimal avgAmount = java.math.BigDecimal.ZERO;
        if (paymentCount != null && paymentCount > 0 && incomeTotal != null) {
            avgAmount = incomeTotal.divide(new java.math.BigDecimal(paymentCount), 0, java.math.BigDecimal.ROUND_HALF_UP);
        }

        //器材
        Integer normalEquipment = statsMapper.selectEquipmentNormal();
        Integer equipmentRate = equipmentTotal != null && equipmentTotal > 0
                ? normalEquipment * 100 / equipmentTotal : 0;
        Integer pendingMaintain = maintainService.selectPendingCount();
        java.math.BigDecimal maintainCost = maintainService.selectTotalCost();

        //课时余量最少的会员（剩余课时 <= 10 的标红提醒）
        List<Member> memberList = memberService.findAll();
        List<Member> lowClassMembers = new ArrayList<>(memberList);
        lowClassMembers.sort(new java.util.Comparator<Member>() {
            @Override
            public int compare(Member a, Member b) {
                int va = a.getCardNextClass() == null ? Integer.MAX_VALUE : a.getCardNextClass();
                int vb = b.getCardNextClass() == null ? Integer.MAX_VALUE : b.getCardNextClass();
                return Integer.compare(va, vb);
            }
        });
        if (lowClassMembers.size() > 5) {
            lowClassMembers = new ArrayList<>(lowClassMembers.subList(0, 5));
        }

        //会员卡到期提醒（已到期 / 30 天内到期）
        String soon = java.time.LocalDate.parse(businessDate).plusDays(30).toString();
        List<Member> expiringMembers = new ArrayList<>();
        java.util.HashMap<Integer, String> cardStatusMap = new java.util.HashMap<>();
        for (Member m : memberList) {
            String end = m.getCardEndDate();
            String status = "有效";
            if (end != null && !end.isEmpty()) {
                if (end.compareTo(businessDate) < 0) {
                    status = "已到期";
                } else if (end.compareTo(soon) <= 0) {
                    status = "即将到期";
                }
            }
            cardStatusMap.put(m.getMemberAccount(), status);
            if (!"有效".equals(status)) {
                expiringMembers.add(m);
            }
        }

        model.addAttribute("businessDate", businessDate);
        model.addAttribute("memberTotal", memberTotal);
        model.addAttribute("employeeTotal", employeeTotal);
        model.addAttribute("humanTotal", memberTotal + employeeTotal);
        model.addAttribute("equipmentTotal", equipmentTotal);

        model.addAttribute("todayCheckIn", todayCheckIn);
        model.addAttribute("todayCheckInMember", todayCheckInMember);
        model.addAttribute("checkInTotal", checkInTotal);
        model.addAttribute("recentCheckIn", recentCheckIn);

        model.addAttribute("incomeTotal", incomeTotal);
        model.addAttribute("paymentCount", paymentCount);
        model.addAttribute("avgAmount", avgAmount);

        model.addAttribute("orderTotal", statsMapper.selectOrderTotal());
        model.addAttribute("normalEquipment", normalEquipment);
        model.addAttribute("equipmentRate", equipmentRate);
        model.addAttribute("pendingMaintain", pendingMaintain);
        model.addAttribute("maintainCost", maintainCost);
        model.addAttribute("avgLeftClass", statsMapper.selectAvgLeftClass());
        model.addAttribute("noticeCount", noticeService.selectTotalCount());
        model.addAttribute("lowClassMembers", lowClassMembers);
        model.addAttribute("expiringMembers", expiringMembers);
        model.addAttribute("cardStatusMap", cardStatusMap);
        model.addAttribute("latestNotices", noticeService.findLatest(5));

        //图表明细（JSON，模板里用 JSON.parse 读取）
        try {
            model.addAttribute("checkTrendJson", objectMapper.writeValueAsString(statsMapper.selectCheckInTrend()));
            model.addAttribute("classRankJson", objectMapper.writeValueAsString(statsMapper.selectClassRank()));
            model.addAttribute("incomeJson", objectMapper.writeValueAsString(statsMapper.selectIncomeByType()));
            model.addAttribute("equipJson", objectMapper.writeValueAsString(statsMapper.selectEquipmentStatus()));
            model.addAttribute("payWayJson", objectMapper.writeValueAsString(statsMapper.selectPayWayStat()));
        } catch (Exception e) {
            model.addAttribute("checkTrendJson", "[]");
            model.addAttribute("classRankJson", "[]");
            model.addAttribute("incomeJson", "[]");
            model.addAttribute("equipJson", "[]");
            model.addAttribute("payWayJson", "[]");
        }

        return "adminMain";
    }
}
