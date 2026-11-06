package com.milotnt.controller;

import com.milotnt.pojo.ClassOrder;
import com.milotnt.pojo.ClassTable;
import com.milotnt.service.ClassOrderService;
import com.milotnt.service.ClassTableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.HashMap;
import java.util.List;

/**
 * @author MiloTnT [milotntspace@gmail.com]
 * @date 2021/8/19
 */

@Controller
@RequestMapping("/class")
public class ClassController {

    @Autowired
    private ClassTableService classTableService;

    @Autowired
    private ClassOrderService classOrderService;

    //查询课程
    @RequestMapping("/selClass")
    public String selectClass(Model model) {
        List<ClassTable> classList = classTableService.findAll();

        //各课程已报名人数
        HashMap<Integer, Integer> bookedMap = new HashMap<>();
        for (java.util.Map<String, Object> row : classOrderService.selectCountGroupByClass()) {
            Object cid = row.get("cid");
            Object num = row.get("num");
            if (cid instanceof Number && num instanceof Number) {
                bookedMap.put(((Number) cid).intValue(), ((Number) num).intValue());
            }
        }

        //汇总统计
        int totalBooked = 0, capacityTotal = 0, fullCount = 0;
        for (ClassTable c : classList) {
            int booked = bookedMap.get(c.getClassId()) == null ? 0 : bookedMap.get(c.getClassId());
            int cap = c.getCapacity() == null || c.getCapacity() <= 0 ? 20 : c.getCapacity();
            totalBooked += booked;
            capacityTotal += cap;
            if (booked >= cap) {
                fullCount++;
            }
        }
        int fillRate = capacityTotal > 0 ? Math.min(totalBooked * 100 / capacityTotal, 100) : 0;

        model.addAttribute("classList", classList);
        model.addAttribute("bookedMap", bookedMap);
        model.addAttribute("totalBooked", totalBooked);
        model.addAttribute("capacityTotal", capacityTotal);
        model.addAttribute("fullCount", fullCount);
        model.addAttribute("fillRate", fillRate);
        return "selectClass";
    }

    //跳转新增课程页面
    @RequestMapping("/toAddClass")
    public String toAddClass() {
        return "addClass";
    }

    //新增课程
    @RequestMapping("/addClass")
    public String addClass(ClassTable classTable) {
        if (classTable.getCapacity() == null || classTable.getCapacity() <= 0) {
            classTable.setCapacity(20);
        }
        if (classTable.getClassroom() == null || classTable.getClassroom().trim().isEmpty()) {
            classTable.setClassroom("待安排");
        }
        classTableService.insertClass(classTable);
        return "redirect:selClass";
    }

    //删除课程
    @RequestMapping("/delClass")
    public String deleteClass(Integer classId) {
        classTableService.deleteClassByClassId(classId);
        classTableService.deleteOrderByClassId(classId);
        return "redirect:selClass";
    }

    //查询课程报名信息
    @RequestMapping("/selClassOrder")
    public String selectClassOrder(Integer classId, Model model) {
        List<ClassOrder> classOrderList = classOrderService.selectMemberOrderList(classId);
        model.addAttribute("classOrderList", classOrderList);
        return "selectClassOrder";
    }

}
