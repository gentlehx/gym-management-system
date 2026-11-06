package com.milotnt.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.milotnt.pojo.BodyTest;
import com.milotnt.pojo.CheckIn;
import com.milotnt.pojo.ClassOrder;
import com.milotnt.pojo.Member;
import com.milotnt.pojo.Payment;
import com.milotnt.service.BodyTestService;
import com.milotnt.service.CheckInService;
import com.milotnt.service.ClassOrderService;
import com.milotnt.service.MemberService;
import com.milotnt.service.PaymentService;
import com.milotnt.util.BusinessClock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

/**
 * @author MiloTnT [milotntspace@gmail.com]
 * @date 2021/8/16
 */

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;
    @Autowired
    private CheckInService checkInService;
    @Autowired
    private PaymentService paymentService;
    @Autowired
    private BodyTestService bodyTestService;
    @Autowired
    private ClassOrderService classOrderService;

    private final ObjectMapper objectMapper = new ObjectMapper();

    //会员 360 档案
    @RequestMapping("/detail")
    public String memberDetail(Integer memberAccount, Model model) {
        if (memberAccount == null) {
            return "redirect:selMember";
        }
        List<Member> memberList = memberService.selectByMemberAccount(memberAccount);
        if (memberList == null || memberList.isEmpty()) {
            return "redirect:selMember";
        }
        Member member = memberList.get(0);

        //卡状态
        String today = BusinessClock.BUSINESS_DATE;
        String soon = LocalDate.parse(today).plusDays(30).toString();
        String cardStatus = "有效";
        String end = member.getCardEndDate();
        if (end != null && !end.isEmpty()) {
            if (end.compareTo(today) < 0) {
                cardStatus = "已到期";
            } else if (end.compareTo(soon) <= 0) {
                cardStatus = "即将到期";
            }
        }

        List<CheckIn> checkInList = checkInService.selectByMemberAccount(memberAccount);
        List<Payment> paymentList = paymentService.selectByMemberAccount(memberAccount);
        List<BodyTest> bodyTestList = bodyTestService.selectByMemberAccount(memberAccount);
        List<ClassOrder> classOrderList = classOrderService.selectClassOrderByMemberAccount(memberAccount);
        BigDecimal payTotal = paymentService.selectAmountByMember(memberAccount);

        //课时进度
        int total = member.getCardClass() == null ? 0 : member.getCardClass();
        int left = member.getCardNextClass() == null ? 0 : member.getCardNextClass();
        int used = Math.max(total - left, 0);
        int percent = total > 0 ? Math.min(used * 100 / total, 100) : 0;

        model.addAttribute("member", member);
        model.addAttribute("cardStatus", cardStatus);
        model.addAttribute("checkInList", checkInList);
        model.addAttribute("checkInCount", checkInList.size());
        model.addAttribute("paymentList", paymentList);
        model.addAttribute("payTotal", payTotal);
        model.addAttribute("bodyTestList", bodyTestList);
        model.addAttribute("classOrderList", classOrderList);
        model.addAttribute("usedClass", used);
        model.addAttribute("leftClass", left);
        model.addAttribute("usedPercent", percent);
        model.addAttribute("today", today);
        try {
            model.addAttribute("bodyTestJson", objectMapper.writeValueAsString(bodyTestList));
            model.addAttribute("checkInJson", objectMapper.writeValueAsString(checkInList));
        } catch (Exception e) {
            model.addAttribute("bodyTestJson", "[]");
            model.addAttribute("checkInJson", "[]");
        }
        return "memberDetail";
    }

    //查询会员（支持按姓名/账号/手机号搜索）
    @RequestMapping("/selMember")
    public String selectMember(String keyword, Model model) {
        List<Member> memberList = (keyword == null || keyword.trim().isEmpty())
                ? memberService.findAll() : memberService.selectByKeyword(keyword.trim());

        //会员卡状态：已到期 / 即将到期（30 天内）/ 有效
        String today = BusinessClock.BUSINESS_DATE;
        String soon = LocalDate.parse(today).plusDays(30).toString();
        HashMap<Integer, String> cardStatusMap = new HashMap<>();
        for (Member m : memberList) {
            String end = m.getCardEndDate();
            String status = "有效";
            if (end != null && !end.isEmpty()) {
                if (end.compareTo(today) < 0) {
                    status = "已到期";
                } else if (end.compareTo(soon) <= 0) {
                    status = "即将到期";
                }
            }
            cardStatusMap.put(m.getMemberAccount(), status);
        }

        //汇总统计
        int validCount = 0, warnCount = 0, expiredCount = 0, lowClassCount = 0;
        for (Member m : memberList) {
            String status = cardStatusMap.get(m.getMemberAccount());
            if ("已到期".equals(status)) {
                expiredCount++;
            } else if ("即将到期".equals(status)) {
                warnCount++;
            } else {
                validCount++;
            }
            if (m.getCardNextClass() != null && m.getCardNextClass() <= 5) {
                lowClassCount++;
            }
        }

        model.addAttribute("memberList", memberList);
        model.addAttribute("keyword", keyword == null ? "" : keyword);
        model.addAttribute("cardStatusMap", cardStatusMap);
        model.addAttribute("validCount", validCount);
        model.addAttribute("warnCount", warnCount);
        model.addAttribute("expiredCount", expiredCount);
        model.addAttribute("lowClassCount", lowClassCount);
        model.addAttribute("today", today);
        return "selectMember";
    }

    //跳转新增会员页面
    @RequestMapping("/toAddMember")
    public String toAddMember() {
        return "addMember";
    }

    //新增会员
    @RequestMapping("/addMember")
    public String addMember(Member member) {
        //会员账号&卡号随机生成
        Random random = new Random();
        String account1 = "2025";
        for (int i = 0; i < 5; i++) {
            account1 += random.nextInt(10);
        }
        Integer account = Integer.parseInt(account1);

        //初始密码
        String password = "123456";

        //获取当前日期
        // 办卡日期固定为 2025-10-08（演示用；原为 new Date() 取系统当前日期）
        Date date = java.sql.Date.valueOf("2025-10-08");
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String nowDay = simpleDateFormat.format(date);

        Integer nextClass = member.getCardClass();

        member.setMemberAccount(account);
        member.setMemberPassword(password);
        member.setCardTime(nowDay);
        member.setCardNextClass(nextClass);
        //新会员默认一年有效期
        member.setCardEndDate(LocalDate.parse(nowDay).plusYears(1).toString());

        memberService.insertMember(member);

        return "redirect:selMember";

    }

    //删除会员
    @RequestMapping("/delMember")
    public String deleteMember(Integer memberAccount) {
        memberService.deleteByMemberAccount(memberAccount);
        return "redirect:selMember";
    }

    //跳转会员修改页面
    @RequestMapping("/toUpdateMember")
    public String toUpdateMember(Integer memberAccount, Model model) {
        List<Member> memberList = memberService.selectByMemberAccount(memberAccount);
        model.addAttribute("memberList", memberList);
        return "updateMember";
    }

    //修改会员信息
    @RequestMapping("/updateMember")
    public String updateMember(Member member) {
        memberService.updateMemberByMemberAccount(member);
        return "redirect:selMember";
    }


    //跳转会员卡查询页面
    @RequestMapping("/toSelByCard")
    public String toSelectByCardId() {
        return "selectByMemberAccount";
    }

    //根据会员卡号查询
    @RequestMapping("/selByCard")
    public String selectByCardId(Model model, Integer memberAccount) {
        List<Member> memberList = memberService.selectByMemberAccount(memberAccount);
        if (memberList != null) {
            model.addAttribute("memberList", memberList);
        } else {
            String message = "会员卡号不存在！";
            model.addAttribute("noMessage", message);
        }
        return "selectByMemberAccount";
    }

}
