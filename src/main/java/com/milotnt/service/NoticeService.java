package com.milotnt.service;

import com.milotnt.pojo.Notice;

import java.util.List;

/**
 * 场馆公告
 *
 * @author MiloTnT
 */
public interface NoticeService {

    List<Notice> findAll();

    List<Notice> findLatest(Integer limit);

    Boolean insertNotice(Notice notice);

    Boolean deleteById(Integer noticeId);

    Boolean updateTop(Integer noticeId, Integer isTop);

    Integer selectTotalCount();
}
