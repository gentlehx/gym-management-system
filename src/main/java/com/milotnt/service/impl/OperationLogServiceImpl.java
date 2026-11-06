package com.milotnt.service.impl;

import com.milotnt.mapper.OperationLogMapper;
import com.milotnt.pojo.OperationLog;
import com.milotnt.service.OperationLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author MiloTnT
 */
@Service
public class OperationLogServiceImpl implements OperationLogService {

    @Autowired
    private OperationLogMapper operationLogMapper;

    @Override
    public List<OperationLog> findAll() {
        return operationLogMapper.findAll();
    }

    @Override
    public List<OperationLog> selectByKeyword(String keyword) {
        return operationLogMapper.selectByKeyword(keyword);
    }

    @Override
    public Boolean insertLog(OperationLog log) {
        return operationLogMapper.insertLog(log) > 0;
    }

    @Override
    public Boolean deleteAll() {
        return operationLogMapper.deleteAll() > 0;
    }

    @Override
    public Integer selectTotalCount() {
        return operationLogMapper.selectTotalCount();
    }
}
