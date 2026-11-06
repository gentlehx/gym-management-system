package com.milotnt.service;

import com.milotnt.pojo.OperationLog;

import java.util.List;

/**
 * 操作日志
 *
 * @author MiloTnT
 */
public interface OperationLogService {

    List<OperationLog> findAll();

    List<OperationLog> selectByKeyword(String keyword);

    Boolean insertLog(OperationLog log);

    Boolean deleteAll();

    Integer selectTotalCount();
}
