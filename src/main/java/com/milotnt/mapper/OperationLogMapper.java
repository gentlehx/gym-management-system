package com.milotnt.mapper;

import com.milotnt.pojo.OperationLog;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 操作日志
 *
 * @author MiloTnT
 */
@Mapper
public interface OperationLogMapper {

    //最近日志
    List<OperationLog> findAll();

    //按关键字查询（操作人 / 动作）
    List<OperationLog> selectByKeyword(String keyword);

    //写入日志
    Integer insertLog(OperationLog log);

    //清空日志
    Integer deleteAll();

    //日志条数
    Integer selectTotalCount();
}
