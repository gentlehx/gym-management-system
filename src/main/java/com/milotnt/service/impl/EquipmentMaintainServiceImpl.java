package com.milotnt.service.impl;

import com.milotnt.mapper.EquipmentMaintainMapper;
import com.milotnt.pojo.EquipmentMaintain;
import com.milotnt.service.EquipmentMaintainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

/**
 * @author MiloTnT
 */
@Service
public class EquipmentMaintainServiceImpl implements EquipmentMaintainService {

    @Autowired
    private EquipmentMaintainMapper equipmentMaintainMapper;

    @Override
    public List<EquipmentMaintain> findAll() {
        return equipmentMaintainMapper.findAll();
    }

    @Override
    public Boolean insertMaintain(EquipmentMaintain maintain) {
        return equipmentMaintainMapper.insertMaintain(maintain) > 0;
    }

    @Override
    public Boolean updateStatus(Integer maintainId, String status) {
        return equipmentMaintainMapper.updateStatus(maintainId, status) > 0;
    }

    @Override
    public Boolean deleteById(Integer maintainId) {
        return equipmentMaintainMapper.deleteById(maintainId) > 0;
    }

    @Override
    public Integer selectPendingCount() {
        return equipmentMaintainMapper.selectPendingCount();
    }

    @Override
    public BigDecimal selectTotalCost() {
        return equipmentMaintainMapper.selectTotalCost();
    }
}
