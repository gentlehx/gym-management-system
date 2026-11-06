package com.milotnt.controller;

import com.milotnt.pojo.Notice;
import com.milotnt.service.NoticeService;
import com.milotnt.util.BusinessClock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 公告管理
 *
 * @author MiloTnT
 */
@Controller
@RequestMapping("/notice")
public class NoticeController {

    @Autowired
    private NoticeService noticeService;

    //公告列表
    @RequestMapping("/selNotice")
    public String selectNotice(Model model) {
        model.addAttribute("noticeList", noticeService.findAll());
        model.addAttribute("noticeCount", noticeService.selectTotalCount());
        return "selectNotice";
    }

    //发布公告
    @RequestMapping("/addNotice")
    public String addNotice(Notice notice, RedirectAttributes attributes) {
        if (notice.getTitle() == null || notice.getTitle().trim().isEmpty()) {
            attributes.addFlashAttribute("msg", "请输入公告标题！");
            return "redirect:selNotice";
        }
        if (notice.getContent() == null) {
            notice.setContent("");
        }
        if (notice.getAuthor() == null || notice.getAuthor().trim().isEmpty()) {
            notice.setAuthor("管理员");
        }
        if (notice.getIsTop() == null) {
            notice.setIsTop(0);
        }
        //演示环境统一使用 2025 年 10 月的业务基准日
        notice.setPublishTime(BusinessClock.currentDateTime());

        noticeService.insertNotice(notice);
        attributes.addFlashAttribute("msg", "公告已发布。");
        return "redirect:selNotice";
    }

    //置顶 / 取消置顶
    @RequestMapping("/topNotice")
    public String topNotice(Integer noticeId, Integer isTop, RedirectAttributes attributes) {
        noticeService.updateTop(noticeId, isTop != null && isTop == 1 ? 0 : 1);
        attributes.addFlashAttribute("msg", "公告置顶状态已更新。");
        return "redirect:selNotice";
    }

    //删除公告
    @RequestMapping("/delNotice")
    public String deleteNotice(Integer noticeId, RedirectAttributes attributes) {
        noticeService.deleteById(noticeId);
        attributes.addFlashAttribute("msg", "公告已删除。");
        return "redirect:selNotice";
    }
}
