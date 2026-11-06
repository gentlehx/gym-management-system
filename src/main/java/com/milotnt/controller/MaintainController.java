package com.milotnt.controller;

import com.milotnt.pojo.Equipment;
import com.milotnt.pojo.EquipmentMaintain;
import com.milotnt.service.EquipmentMaintainService;
import com.milotnt.service.EquipmentService;
import com.milotnt.util.BusinessClock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.List;

/**
 * 器材维修管理
 *
 * @author MiloTnT
 */
@Controller
@RequestMapping("/maintain")
public class MaintainController {

    @Autowired
    private EquipmentMaintainService maintainService;
    @Autowired
    private EquipmentService equipmentService;

    //维修记录列表
    @RequestMapping("/selMaintain")
    public String selectMaintain(Model model) {
        model.addAttribute("maintainList", maintainService.findAll());
        model.addAttribute("equipmentList", equipmentService.findAll());
        model.addAttribute("pendingCount", maintainService.selectPendingCount());
        model.addAttribute("totalCost", maintainService.selectTotalCost());
        return "selectMaintain";
    }

    //登记报修
    @RequestMapping("/addMaintain")
    public String addMaintain(EquipmentMaintain maintain, RedirectAttributes attributes) {
        if (maintain.getEquipmentId() == null) {
            attributes.addFlashAttribute("msg", "请选择需要报修的器材！");
            return "redirect:selMaintain";
        }

        List<Equipment> equipmentList = equipmentService.selectByEquipmentId(maintain.getEquipmentId());
        if (equipmentList == null || equipmentList.isEmpty()) {
            attributes.addFlashAttribute("msg", "器材不存在！");
            return "redirect:selMaintain";
        }
        Equipment equipment = equipmentList.get(0);

        maintain.setEquipmentName(equipment.getEquipmentName());
        maintain.setMaintainDate(BusinessClock.BUSINESS_DATE);
        if (maintain.getStatus() == null || maintain.getStatus().trim().isEmpty()) {
            maintain.setStatus("待维修");
        }
        if (maintain.getCost() == null) {
            maintain.setCost(BigDecimal.ZERO);
        }
        if (maintain.getHandler() == null) {
            maintain.setHandler("");
        }
        if (maintain.getFaultDesc() == null) {
            maintain.setFaultDesc("");
        }
        maintainService.insertMaintain(maintain);

        //器材状态同步为维修中
        equipment.setEquipmentStatus("维修中");
        equipment.setEquipmentMessage(maintain.getFaultDesc());
        equipmentService.updateEquipmentByEquipmentId(equipment);

        attributes.addFlashAttribute("msg", "已登记 " + equipment.getEquipmentName() + " 的维修单，器材状态置为“维修中”。");
        return "redirect:selMaintain";
    }

    //完成维修
    @RequestMapping("/finishMaintain")
    public String finishMaintain(Integer maintainId, Integer equipmentId, RedirectAttributes attributes) {
        maintainService.updateStatus(maintainId, "已完成");

        if (equipmentId != null) {
            List<Equipment> equipmentList = equipmentService.selectByEquipmentId(equipmentId);
            if (equipmentList != null && !equipmentList.isEmpty()) {
                Equipment equipment = equipmentList.get(0);
                equipment.setEquipmentStatus("正常");
                equipment.setEquipmentMessage("");
                equipmentService.updateEquipmentByEquipmentId(equipment);
            }
        }

        attributes.addFlashAttribute("msg", "维修单已完成，器材状态恢复为“正常”。");
        return "redirect:selMaintain";
    }

    //删除维修记录
    @RequestMapping("/delMaintain")
    public String deleteMaintain(Integer maintainId, RedirectAttributes attributes) {
        maintainService.deleteById(maintainId);
        attributes.addFlashAttribute("msg", "维修记录已删除。");
        return "redirect:selMaintain";
    }
}
