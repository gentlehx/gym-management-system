package com.milotnt.mapper;

import com.milotnt.pojo.EquipmentMaintain;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

/**
 * 器材维修记录
 *
 * @author MiloTnT
 */
@Mapper
public interface EquipmentMaintainMapper {

    //查询全部维修记录
    List<EquipmentMaintain> findAll();

    //新增维修记录
    Integer insertMaintain(EquipmentMaintain maintain);

    //更新维修状态
    Integer updateStatus(@Param("maintainId") Integer maintainId, @Param("status") String status);

    //删除维修记录
    Integer deleteById(Integer maintainId);

    //未完成的维修单数量
    Integer selectPendingCount();

    //维修费用合计
    BigDecimal selectTotalCost();
}
