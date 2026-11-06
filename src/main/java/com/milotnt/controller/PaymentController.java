package com.milotnt.controller;

import com.milotnt.pojo.Member;
import com.milotnt.pojo.Payment;
import com.milotnt.service.MemberService;
import com.milotnt.service.PaymentService;
import com.milotnt.util.BusinessClock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.List;

/**
 * 收费管理
 *
 * @author MiloTnT
 */
@Controller
@RequestMapping("/payment")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;
    @Autowired
    private MemberService memberService;

    //收费流水列表
    @RequestMapping("/selPayment")
    public String selectPayment(Model model) {
        List<Payment> paymentList = paymentService.findAll();
        model.addAttribute("paymentList", paymentList);
        model.addAttribute("memberList", memberService.findAll());
        model.addAttribute("totalAmount", paymentService.selectTotalAmount());
        model.addAttribute("paymentCount", paymentService.selectTotalCount());
        return "selectPayment";
    }

    //新增收费记录
    @RequestMapping("/addPayment")
    public String addPayment(Payment payment, RedirectAttributes attributes) {
        if (payment.getMemberAccount() == null) {
            attributes.addFlashAttribute("msg", "请选择会员！");
            return "redirect:selPayment";
        }
        if (payment.getAmount() == null || payment.getAmount().compareTo(BigDecimal.ZERO) <= 0) {
            attributes.addFlashAttribute("msg", "请输入正确的收费金额！");
            return "redirect:selPayment";
        }

        List<Member> members = memberService.selectByMemberAccount(payment.getMemberAccount());
        if (members == null || members.isEmpty()) {
            attributes.addFlashAttribute("msg", "会员账号不存在！");
            return "redirect:selPayment";
        }
        Member member = members.get(0);

        payment.setMemberName(member.getMemberName());
        if (payment.getPayTime() == null || payment.getPayTime().trim().isEmpty()) {
            //演示环境统一使用 2025 年 10 月的业务基准日
            payment.setPayTime(BusinessClock.BUSINESS_DATE);
        }
        if (payment.getClassCount() == null) {
            payment.setClassCount(0);
        }
        if (payment.getPayWay() == null || payment.getPayWay().trim().isEmpty()) {
            payment.setPayWay("微信");
        }
        if (payment.getRemark() == null) {
            payment.setRemark("");
        }
        paymentService.insertPayment(payment);

        //购买课时自动补充到会员剩余课时
        if (payment.getClassCount() > 0) {
            memberService.updateCardNextClass(member.getMemberAccount(), payment.getClassCount());
        }

        attributes.addFlashAttribute("msg", "已记录 " + member.getMemberName() + " 的收费 "
                + payment.getAmount() + " 元" + (payment.getClassCount() > 0
                ? "，并增加 " + payment.getClassCount() + " 课时。" : "。"));
        return "redirect:selPayment";
    }

    //删除收费记录
    @RequestMapping("/delPayment")
    public String deletePayment(Integer paymentId, RedirectAttributes attributes) {
        paymentService.deleteById(paymentId);
        attributes.addFlashAttribute("msg", "收费记录已删除（不回退课时）。");
        return "redirect:selPayment";
    }
}
