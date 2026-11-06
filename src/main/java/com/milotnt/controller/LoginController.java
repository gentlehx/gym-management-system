package com.milotnt.controller;

import com.milotnt.pojo.Admin;
import com.milotnt.pojo.Member;
import com.milotnt.service.AdminService;
import com.milotnt.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * @author MiloTnT [milotntspace@gmail.com]
 * @date 2021/8/20
 */

@Controller
public class LoginController {

    @Autowired
    private MemberService memberService;
    @Autowired
    private AdminService adminService;
    @Autowired
    private com.milotnt.service.ClassTableService classTableService;
    @Autowired
    private com.milotnt.service.CheckInService checkInService;

    //主页、跳转管理员登录页面
    @RequestMapping("/")
    public String toAdminLogin(Model model) {
        fillLoginStats(model);
        return "adminLogin";
    }

    //跳转会员登录页面
    @RequestMapping("/toUserLogin")
    public String toUserLogin(Model model) {
        fillLoginStats(model);
        return "userLogin";
    }

    //登录页展示的场馆概览数据
    private void fillLoginStats(Model model) {
        model.addAttribute("memberTotal", memberService.selectTotalCount());
        model.addAttribute("classTotal", classTableService.findAll().size());
        model.addAttribute("checkInTotal", checkInService.selectTotalCount());
    }

    //管理员登录
    @RequestMapping("/adminLogin")
    public String adminLogin(Admin admin, Model model, HttpSession session) {
        Admin admin1 = adminService.adminLogin(admin);
        if (admin1 != null) {
            session.setAttribute("admin", admin1);
            //主页的数据统计统一由看板控制器提供
            return "redirect:/admin/dashboard";
        }
        model.addAttribute("msg", "您输入的账号或密码有误，请重新输入！");
        return "adminLogin";
    }

    //会员登录
    @RequestMapping("/userLogin")
    public String userLogin(Member member, Model model, HttpSession session) {
        Member member1 = memberService.userLogin(member);
        if (member1 != null) {
            session.setAttribute("user", member1);
            return "redirect:/user/toUserMain";
        }
        model.addAttribute("msg", "您输入的账号或密码有误，请重新输入！");
        return "userLogin";
    }

    //跳转管理员主页（兼容原有链接）
    @RequestMapping("/toAdminMain")
    public String toAdminMain() {
        return "redirect:/admin/dashboard";
    }

    //跳转会员主页（兼容原有链接）
    @RequestMapping("/toUserMain")
    public String toUserMain() {
        return "redirect:/user/toUserMain";
    }

}
