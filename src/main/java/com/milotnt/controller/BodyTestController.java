package com.milotnt.controller;

import com.milotnt.pojo.BodyTest;
import com.milotnt.service.BodyTestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.List;

/**
 * 体测记录（管理端）
 *
 * @author MiloTnT
 */
@Controller
@RequestMapping("/bodytest")
public class BodyTestController {

    @Autowired
    private BodyTestService bodyTestService;

    //体测记录列表
    @RequestMapping("/selBodyTest")
    public String selectBodyTest(Model model) {
        List<BodyTest> bodyTestList = bodyTestService.findAll();

        //平均体脂率
        BigDecimal fatSum = BigDecimal.ZERO;
        int fatCount = 0;
        for (BodyTest b : bodyTestList) {
            if (b.getBodyFat() != null) {
                fatSum = fatSum.add(b.getBodyFat());
                fatCount++;
            }
        }
        BigDecimal avgFat = fatCount > 0
                ? fatSum.divide(new BigDecimal(fatCount), 1, BigDecimal.ROUND_HALF_UP) : BigDecimal.ZERO;

        model.addAttribute("bodyTestList", bodyTestList);
        model.addAttribute("recordCount", bodyTestService.selectTotalCount());
        model.addAttribute("memberCount", bodyTestService.selectMemberCount());
        model.addAttribute("avgFat", avgFat);
        return "selectBodyTest";
    }

    //删除体测记录
    @RequestMapping("/delBodyTest")
    public String deleteBodyTest(Integer bodyTestId, RedirectAttributes attributes) {
        bodyTestService.deleteById(bodyTestId);
        attributes.addFlashAttribute("msg", "体测记录已删除。");
        return "redirect:selBodyTest";
    }
}
