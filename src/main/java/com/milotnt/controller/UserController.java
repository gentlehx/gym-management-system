package com.milotnt.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.milotnt.pojo.BodyTest;
import com.milotnt.pojo.CheckIn;
import com.milotnt.pojo.ClassOrder;
import com.milotnt.pojo.ClassTable;
import com.milotnt.pojo.Member;
import com.milotnt.pojo.Payment;
import com.milotnt.service.BodyTestService;
import com.milotnt.service.CheckInService;
import com.milotnt.service.ClassOrderService;
import com.milotnt.service.ClassTableService;
import com.milotnt.service.MemberService;
import com.milotnt.service.NoticeService;
import com.milotnt.service.PaymentService;
import com.milotnt.util.BusinessClock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @author MiloTnT [milotntspace@gmail.com]
 * @date 2021/8/21
 */

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private ClassTableService classTableService;

    @Autowired
    private MemberService memberService;

    @Autowired
    private ClassOrderService classOrderService;

    @Autowired
    private CheckInService checkInService;

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private NoticeService noticeService;

    @Autowired
    private BodyTestService bodyTestService;

    private final ObjectMapper objectMapper = new ObjectMapper();

    //会员主页（概览）
    @RequestMapping("/toUserMain")
    public String toUserMain(Model model, HttpSession session) {
        Member sessionMember = (Member) session.getAttribute("user");
        if (sessionMember == null) {
            return "redirect:/toUserLogin";
        }
        //重新读一次，保证课时等信息是最新的
        List<Member> members = memberService.selectByMemberAccount(sessionMember.getMemberAccount());
        Member member = members.isEmpty() ? sessionMember : members.get(0);
        session.setAttribute("user", member);

        List<String> dates = checkInService.selectMemberDates(member.getMemberAccount());
        model.addAttribute("member", member);
        model.addAttribute("checkInCount", dates.size());
        model.addAttribute("checkInToday", checkInService.selectByMemberAndDate(
                member.getMemberAccount(), BusinessClock.BUSINESS_DATE) != null);
        model.addAttribute("keepDays", continuousDays(dates));
        model.addAttribute("myPayTotal", paymentService.selectAmountByMember(member.getMemberAccount()));

        List<ClassOrder> myOrders = classOrderService.selectClassOrderByMemberAccount(member.getMemberAccount());
        model.addAttribute("myClassCount", myOrders.size());
        model.addAttribute("myClassList", myOrders);

        //推荐课程：还没报名的课程里取 3 门
        Set<Integer> bookedIds = new HashSet<>();
        for (ClassOrder o : myOrders) {
            bookedIds.add(o.getClassId());
        }
        List<ClassTable> recommendClasses = new ArrayList<>();
        for (ClassTable c : classTableService.findAll()) {
            if (!bookedIds.contains(c.getClassId())) {
                recommendClasses.add(c);
                if (recommendClasses.size() >= 3) {
                    break;
                }
            }
        }
        model.addAttribute("recommendClasses", recommendClasses);

        model.addAttribute("noticeList", noticeService.findLatest(3));
        return "userMain";
    }

    //跳转个人信息页面
    @RequestMapping("/toUserInfo")
    public String toUserInformation(Model model, HttpSession session) {
        Member sessionUser = (Member) session.getAttribute("user");
        List<Member> list = memberService.selectByMemberAccount(sessionUser.getMemberAccount());
        Member member = (list == null || list.isEmpty()) ? sessionUser : list.get(0);
        session.setAttribute("user", member);

        //会员卡状态
        String today = BusinessClock.BUSINESS_DATE;
        String weekLater = LocalDate.parse(today).plusDays(30).toString();
        String end = member.getCardEndDate();
        String cardStatus = "有效";
        if (end != null && !end.isEmpty()) {
            if (end.compareTo(today) < 0) {
                cardStatus = "已到期";
            } else if (end.compareTo(weekLater) <= 0) {
                cardStatus = "即将到期";
            }
        }

        int total = member.getCardClass() == null ? 0 : member.getCardClass();
        int left = member.getCardNextClass() == null ? 0 : member.getCardNextClass();
        int used = Math.max(total - left, 0);
        int percent = total > 0 ? Math.min(used * 100 / total, 100) : 0;

        model.addAttribute("member", member);
        model.addAttribute("cardStatus", cardStatus);
        model.addAttribute("usedClass", used);
        model.addAttribute("usedPercent", percent);
        model.addAttribute("checkInCount", checkInService.selectByMemberAccount(member.getMemberAccount()).size());
        return "userInformation";
    }

    //跳转修改个人信息页面
    @RequestMapping("/toUpdateInfo")
    public String toUpdateUserInformation(HttpSession session, Model model) {
        Member member = (Member) session.getAttribute("user");
        model.addAttribute("member", member);
        return "updateUserInformation";
    }

    //修改个人信息
    @RequestMapping("/updateInfo")
    public String updateUserInformation(HttpSession session, Member member) {
        Member member1 = (Member) session.getAttribute("user");

        member.setMemberAccount(member1.getMemberAccount());
        member.setCardClass(member1.getCardClass());
        member.setCardTime(member1.getCardTime());
        member.setCardNextClass(member1.getCardNextClass());

        memberService.updateMemberByMemberAccount(member);
        //重新读取，保留到期日、课时等未在表单提交的字段
        List<Member> list = memberService.selectByMemberAccount(member.getMemberAccount());
        session.setAttribute("user", (list == null || list.isEmpty()) ? member : list.get(0));
        return "redirect:/user/toUserInfo";
    }

    //跳转我的课程页面
    @RequestMapping("/toUserClass")
    public String toUserClass(Model model, HttpSession session) {
        Member member = (Member) session.getAttribute("user");
        //重新读取，保证课时与数据库一致
        List<Member> fresh = memberService.selectByMemberAccount(member.getMemberAccount());
        if (!fresh.isEmpty()) {
            member = fresh.get(0);
            session.setAttribute("user", member);
        }
        model.addAttribute("member", member);
        Integer memberAccount = member.getMemberAccount();
        List<ClassOrder> classOrderList = classOrderService.selectClassOrderByMemberAccount(memberAccount);
        model.addAttribute("classOrderList", classOrderList);
        return "userClass";
    }

    //退课（返还 1 课时）
    @RequestMapping("delUserClass")
    public String deleteUserClass(Integer classOrderId, HttpSession session, RedirectAttributes attributes) {
        Member member = (Member) session.getAttribute("user");
        classOrderService.deleteByClassOrderId(classOrderId);
        if (member != null) {
            memberService.updateCardNextClass(member.getMemberAccount(), 1);
        }
        attributes.addFlashAttribute("msg", "已退课，课时已返还 1 节。");
        return "redirect:toUserClass";
    }

    //跳转报名选课页面
    @RequestMapping("/toApplyClass")
    public String toUserApplyClass(Model model, HttpSession session) {
        Member member = (Member) session.getAttribute("user");
        List<ClassTable> classList = classTableService.findAll();

        //各课程已报名人数 / 剩余名额
        Map<Integer, Integer> bookedMap = new HashMap<>();
        Map<Integer, Integer> remainMap = new HashMap<>();
        for (Map<String, Object> row : classOrderService.selectCountGroupByClass()) {
            Object cid = row.get("cid");
            Object num = row.get("num");
            if (cid instanceof Number && num instanceof Number) {
                bookedMap.put(((Number) cid).intValue(), ((Number) num).intValue());
            }
        }
        for (ClassTable c : classList) {
            int capacity = c.getCapacity() == null ? 20 : c.getCapacity();
            int booked = bookedMap.get(c.getClassId()) == null ? 0 : bookedMap.get(c.getClassId());
            remainMap.put(c.getClassId(), Math.max(capacity - booked, 0));
        }

        model.addAttribute("member", member);
        model.addAttribute("classList", classList);
        model.addAttribute("bookedMap", bookedMap);
        model.addAttribute("remainMap", remainMap);
        return "userApplyClass";
    }

    //报名选课（每报名一门课消耗 1 课时）
    @RequestMapping("/applyClass")
    public String userApplyClass(Integer classId, HttpSession session, RedirectAttributes attributes) {
        ClassTable classTable = classTableService.selectByClassId(classId);
        Member member = (Member) session.getAttribute("user");
        if (classTable == null || member == null) {
            return "redirect:toApplyClass";
        }

        ClassOrder classOrder1 = classOrderService.selectMemberByClassIdAndMemberAccount(
                classTable.getClassId(), member.getMemberAccount());
        if (classOrder1 != null) {
            attributes.addFlashAttribute("msg", "您已经报名过《" + classTable.getClassName() + "》，无需重复报名。");
            return "redirect:toUserClass";
        }

        if (member.getCardNextClass() == null || member.getCardNextClass() <= 0) {
            attributes.addFlashAttribute("msg", "剩余课时不足，请先到前台续费后再报名。");
            return "redirect:toApplyClass";
        }

        //课程名额校验
        Integer capacity = classTable.getCapacity() == null ? 20 : classTable.getCapacity();
        Integer booked = classOrderService.selectCountByClassId(classTable.getClassId());
        if (booked != null && booked >= capacity) {
            attributes.addFlashAttribute("msg", "《" + classTable.getClassName() + "》名额已满（" + capacity + " 人），请选择其他课程。");
            return "redirect:toApplyClass";
        }

        ClassOrder classOrder = new ClassOrder(classTable.getClassId(), classTable.getClassName(),
                classTable.getCoach(), member.getMemberName(), member.getMemberAccount(),
                classTable.getClassBegin());
        classOrderService.insertClassOrder(classOrder);
        memberService.updateCardNextClass(member.getMemberAccount(), -1);

        attributes.addFlashAttribute("msg", "报名成功，已扣除 1 课时。");
        return "redirect:toUserClass";
    }

    //跳转签到页面
    @RequestMapping("/toCheckIn")
    public String toCheckIn(Model model, HttpSession session) {
        Member member = (Member) session.getAttribute("user");
        if (member == null) {
            return "redirect:/toUserLogin";
        }
        List<CheckIn> checkInList = checkInService.selectByMemberAccount(member.getMemberAccount());
        List<String> dates = checkInService.selectMemberDates(member.getMemberAccount());
        model.addAttribute("member", member);
        model.addAttribute("checkInList", checkInList);
        model.addAttribute("checkInCount", checkInList.size());
        model.addAttribute("keepDays", continuousDays(dates));
        model.addAttribute("checkInToday", checkInService.selectByMemberAndDate(
                member.getMemberAccount(), BusinessClock.BUSINESS_DATE) != null);
        model.addAttribute("businessDate", BusinessClock.BUSINESS_DATE);
        return "userCheckIn";
    }

    //会员签到
    @RequestMapping("/doCheckIn")
    public String doCheckIn(String checkInType, HttpSession session, RedirectAttributes attributes) {
        Member member = (Member) session.getAttribute("user");
        if (member == null) {
            return "redirect:/toUserLogin";
        }

        String date = BusinessClock.BUSINESS_DATE;
        if (checkInService.selectByMemberAndDate(member.getMemberAccount(), date) != null) {
            attributes.addFlashAttribute("msg", "您今天（" + date + "）已经签到过了，明天再来吧！");
            return "redirect:toCheckIn";
        }

        CheckIn checkIn = new CheckIn();
        checkIn.setMemberAccount(member.getMemberAccount());
        checkIn.setMemberName(member.getMemberName());
        checkIn.setCheckInDate(date);
        checkIn.setCheckInTime(BusinessClock.currentTime());
        checkIn.setCheckInType((checkInType == null || checkInType.isEmpty()) ? "日常健身" : checkInType);
        checkIn.setRemark("会员自助签到");
        checkInService.insertCheckIn(checkIn);

        attributes.addFlashAttribute("msg", "签到成功，今天也要好好练！");
        return "redirect:toCheckIn";
    }

    //我的消费记录
    @RequestMapping("/toMyPayment")
    public String toMyPayment(Model model, HttpSession session) {
        Member member = (Member) session.getAttribute("user");
        if (member == null) {
            return "redirect:/toUserLogin";
        }
        List<Payment> paymentList = paymentService.selectByMemberAccount(member.getMemberAccount());
        model.addAttribute("member", member);
        model.addAttribute("paymentList", paymentList);
        model.addAttribute("myPayTotal", paymentService.selectAmountByMember(member.getMemberAccount()));
        return "userPayment";
    }

    //场馆公告
    @RequestMapping("/toNotice")
    public String toNotice(Model model, HttpSession session) {
        model.addAttribute("member", session.getAttribute("user"));
        model.addAttribute("noticeList", noticeService.findAll());
        return "userNotice";
    }

    //体测记录
    @RequestMapping("/toBodyTest")
    public String toBodyTest(Model model, HttpSession session) {
        Member member = (Member) session.getAttribute("user");
        if (member == null) {
            return "redirect:/toUserLogin";
        }
        List<BodyTest> bodyTestList = bodyTestService.selectByMemberAccount(member.getMemberAccount());
        model.addAttribute("member", member);
        model.addAttribute("bodyTestList", bodyTestList);
        model.addAttribute("latest", bodyTestList.isEmpty() ? null : bodyTestList.get(bodyTestList.size() - 1));
        model.addAttribute("first", bodyTestList.isEmpty() ? null : bodyTestList.get(0));
        model.addAttribute("businessDate", BusinessClock.BUSINESS_DATE);
        try {
            model.addAttribute("bodyTestJson", objectMapper.writeValueAsString(bodyTestList));
        } catch (Exception e) {
            model.addAttribute("bodyTestJson", "[]");
        }
        return "userBodyTest";
    }

    //新增体测记录
    @RequestMapping("/addBodyTest")
    public String addBodyTest(BigDecimal weight, BigDecimal bodyFat, BigDecimal muscle, String remark,
                             HttpSession session, RedirectAttributes attributes) {
        Member member = (Member) session.getAttribute("user");
        if (member == null) {
            return "redirect:/toUserLogin";
        }
        if (weight == null || weight.compareTo(BigDecimal.ZERO) <= 0) {
            attributes.addFlashAttribute("msg", "请输入有效的体重！");
            return "redirect:toBodyTest";
        }

        BodyTest bodyTest = new BodyTest();
        bodyTest.setMemberAccount(member.getMemberAccount());
        bodyTest.setMemberName(member.getMemberName());
        bodyTest.setTestDate(BusinessClock.BUSINESS_DATE);
        bodyTest.setHeight(member.getMemberHeight());
        bodyTest.setWeight(weight);
        bodyTest.setBodyFat(bodyFat);
        bodyTest.setMuscle(muscle);
        if (member.getMemberHeight() != null && member.getMemberHeight() > 0) {
            double h = member.getMemberHeight() / 100.0;
            bodyTest.setBmi(weight.divide(new BigDecimal(h * h), 1, RoundingMode.HALF_UP));
        }
        bodyTest.setRemark(remark == null ? "" : remark);
        bodyTestService.insertBodyTest(bodyTest);

        attributes.addFlashAttribute("msg", "体测记录已保存。");
        return "redirect:toBodyTest";
    }

    //从最近一次签到往前计算连续签到天数
    private int continuousDays(List<String> dates) {
        if (dates == null || dates.isEmpty()) {
            return 0;
        }
        if (!dates.get(0).equals(BusinessClock.BUSINESS_DATE)) {
            return 0;
        }
        int days = 1;
        LocalDate cursor = LocalDate.parse(BusinessClock.BUSINESS_DATE);
        for (int i = 1; i < dates.size(); i++) {
            LocalDate expect = cursor.minusDays(1);
            if (dates.get(i).equals(expect.toString())) {
                days++;
                cursor = expect;
            } else {
                break;
            }
        }
        return days;
    }

}
