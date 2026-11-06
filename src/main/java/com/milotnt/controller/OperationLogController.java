package com.milotnt.controller;

import com.milotnt.pojo.OperationLog;
import com.milotnt.service.OperationLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

/**
 * 操作日志
 *
 * @author MiloTnT
 */
@Controller
@RequestMapping("/log")
public class OperationLogController {

    @Autowired
    private OperationLogService operationLogService;

    //日志列表
    @RequestMapping("/selLog")
    public String selectLog(String keyword, Model model) {
        List<OperationLog> logList = (keyword == null || keyword.trim().isEmpty())
                ? operationLogService.findAll() : operationLogService.selectByKeyword(keyword.trim());
        model.addAttribute("logList", logList);
        model.addAttribute("keyword", keyword == null ? "" : keyword);
        model.addAttribute("logTotal", operationLogService.selectTotalCount());
        return "selectLog";
    }

    //清空日志
    @RequestMapping("/clearLog")
    public String clearLog(RedirectAttributes attributes) {
        operationLogService.deleteAll();
        attributes.addFlashAttribute("msg", "操作日志已清空。");
        return "redirect:selLog";
    }
}
