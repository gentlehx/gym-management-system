package com.milotnt.controller;

import com.milotnt.pojo.CheckIn;
import com.milotnt.pojo.Member;
import com.milotnt.service.CheckInService;
import com.milotnt.service.MemberService;
import com.milotnt.util.BusinessClock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

/**
 * 签到管理
 *
 * @author MiloTnT
 */
@Controller
@RequestMapping("/checkin")
public class CheckInController {

    @Autowired
    private CheckInService checkInService;
    @Autowired
    private MemberService memberService;

    //签到记录列表
    @RequestMapping("/selCheckin")
    public String selectCheckin(Model model) {
        String latest = checkInService.selectLatestDate();
        String checkInDate = (latest == null || latest.trim().isEmpty()) ? BusinessClock.BUSINESS_DATE : latest;

        model.addAttribute("checkInList", checkInService.findAll());
        model.addAttribute("memberList", memberService.findAll());
        model.addAttribute("checkInDate", checkInDate);
        model.addAttribute("todayCount", checkInService.selectCountByDate(checkInDate));
        model.addAttribute("todayMemberCount", checkInService.selectMemberCountByDate(checkInDate));
        model.addAttribute("totalCount", checkInService.selectTotalCount());
        return "selectCheckin";
    }

    //管理员代签
    @RequestMapping("/addCheckin")
    public String addCheckin(Integer memberAccount, String checkInType, String remark, RedirectAttributes attributes) {
        if (memberAccount == null) {
            attributes.addFlashAttribute("msg", "请选择会员！");
            return "redirect:selCheckin";
        }

        List<Member> members = memberService.selectByMemberAccount(memberAccount);
        if (members == null || members.isEmpty()) {
            attributes.addFlashAttribute("msg", "会员账号不存在！");
            return "redirect:selCheckin";
        }

        String date = BusinessClock.BUSINESS_DATE;
        CheckIn exist = checkInService.selectByMemberAndDate(memberAccount, date);
        if (exist != null) {
            attributes.addFlashAttribute("msg", "该会员 " + date + " 已签到，无需重复签到。");
            return "redirect:selCheckin";
        }

        Member member = members.get(0);
        CheckIn checkIn = new CheckIn();
        checkIn.setMemberAccount(memberAccount);
        checkIn.setMemberName(member.getMemberName());
        checkIn.setCheckInDate(date);
        checkIn.setCheckInTime(BusinessClock.currentTime());
        checkIn.setCheckInType((checkInType == null || checkInType.isEmpty()) ? "日常健身" : checkInType);
        checkIn.setRemark(remark == null ? "" : remark);
        checkInService.insertCheckIn(checkIn);

        attributes.addFlashAttribute("msg", "已为 " + member.getMemberName() + " 完成签到。");
        return "redirect:selCheckin";
    }

    //删除签到记录
    @RequestMapping("/delCheckin")
    public String deleteCheckin(Integer checkInId, RedirectAttributes attributes) {
        checkInService.deleteById(checkInId);
        attributes.addFlashAttribute("msg", "签到记录已删除。");
        return "redirect:selCheckin";
    }
}
