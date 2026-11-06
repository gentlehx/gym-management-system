package com.milotnt.service.impl;

import com.milotnt.mapper.NoticeMapper;
import com.milotnt.pojo.Notice;
import com.milotnt.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author MiloTnT
 */
@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    private NoticeMapper noticeMapper;

    @Override
    public List<Notice> findAll() {
        return noticeMapper.findAll();
    }

    @Override
    public List<Notice> findLatest(Integer limit) {
        return noticeMapper.findLatest(limit);
    }

    @Override
    public Boolean insertNotice(Notice notice) {
        return noticeMapper.insertNotice(notice) > 0;
    }

    @Override
    public Boolean deleteById(Integer noticeId) {
        return noticeMapper.deleteById(noticeId) > 0;
    }

    @Override
    public Boolean updateTop(Integer noticeId, Integer isTop) {
        return noticeMapper.updateTop(noticeId, isTop) > 0;
    }

    @Override
    public Integer selectTotalCount() {
        return noticeMapper.selectTotalCount();
    }
}
