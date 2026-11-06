package com.milotnt.controller;

import com.milotnt.pojo.ClassTable;
import com.milotnt.pojo.EquipmentMaintain;
import com.milotnt.pojo.Member;
import com.milotnt.service.ClassTableService;
import com.milotnt.service.EquipmentMaintainService;
import com.milotnt.service.MemberService;
import com.milotnt.util.BusinessClock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * 待办中心：把需要处理的事情聚合到一页
 *
 * @author MiloTnT
 */
@Controller
@RequestMapping("/todo")
public class TodoController {

    @Autowired
    private MemberService memberService;
    @Autowired
    private EquipmentMaintainService maintainService;
    @Autowired
    private ClassTableService classTableService;

    @RequestMapping("")
    public String todo(Model model) {
        String today = BusinessClock.BUSINESS_DATE;
        String soon = LocalDate.parse(today).plusDays(30).toString();

        List<Member> memberList = memberService.findAll();
        List<Member> expired = new ArrayList<>();
        List<Member> expiring = new ArrayList<>();
        List<Member> lowClass = new ArrayList<>();
        for (Member m : memberList) {
            String end = m.getCardEndDate();
            if (end != null && !end.isEmpty()) {
                if (end.compareTo(today) < 0) {
                    expired.add(m);
                } else if (end.compareTo(soon) <= 0) {
                    expiring.add(m);
                }
            }
            if (m.getCardNextClass() != null && m.getCardNextClass() <= 10) {
                lowClass.add(m);
            }
        }
        //已到期按到期日升序（拖得最久的最靠前）
        expired.sort((a, b) -> a.getCardEndDate().compareTo(b.getCardEndDate()));

        //课时余量榜：不论是否触达阈值，始终给出最需要续费的 5 位会员
        List<Member> lowClassRank = new ArrayList<>(memberList);
        lowClassRank.sort((a, b) -> {
            int x = a.getCardNextClass() == null ? 0 : a.getCardNextClass();
            int y = b.getCardNextClass() == null ? 0 : b.getCardNextClass();
            return Integer.compare(x, y);
        });
        if (lowClassRank.size() > 5) {
            lowClassRank = lowClassRank.subList(0, 5);
        }

        List<EquipmentMaintain> pendingMaintain = new ArrayList<>();
        for (EquipmentMaintain r : maintainService.findAll()) {
            if (!"已完成".equals(r.getStatus())) {
                pendingMaintain.add(r);
            }
        }

        //当天的课程：class_begin 形如 “2025年10月10日 18:00”
        LocalDate date = LocalDate.parse(today);
        String prefix = date.getYear() + "年" + date.getMonthValue() + "月" + date.getDayOfMonth() + "日";
        List<ClassTable> todayClasses = new ArrayList<>();
        for (ClassTable c : classTableService.findAll()) {
            if (c.getClassBegin() != null && c.getClassBegin().startsWith(prefix)) {
                todayClasses.add(c);
            }
        }

        model.addAttribute("today", today);
        model.addAttribute("expiredMembers", expired);
        model.addAttribute("expiringMembers", expiring);
        model.addAttribute("lowClassMembers", lowClass);
        model.addAttribute("lowClassRank", lowClassRank);
        model.addAttribute("pendingMaintain", pendingMaintain);
        model.addAttribute("todayClasses", todayClasses);
        model.addAttribute("todoTotal", expired.size() + expiring.size() + lowClass.size()
                + pendingMaintain.size() + todayClasses.size());
        return "todo";
    }
}
