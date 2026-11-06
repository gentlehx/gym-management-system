package com.milotnt.service;

import com.milotnt.pojo.EquipmentMaintain;

import java.math.BigDecimal;
import java.util.List;

/**
 * 器材维修
 *
 * @author MiloTnT
 */
public interface EquipmentMaintainService {

    List<EquipmentMaintain> findAll();

    Boolean insertMaintain(EquipmentMaintain maintain);

    Boolean updateStatus(Integer maintainId, String status);

    Boolean deleteById(Integer maintainId);

    Integer selectPendingCount();

    BigDecimal selectTotalCost();
}
