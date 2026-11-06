package com.milotnt.mapper;

import com.milotnt.pojo.Notice;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 场馆公告
 *
 * @author MiloTnT
 */
@Mapper
public interface NoticeMapper {

    //查询全部公告（置顶在前）
    List<Notice> findAll();

    //查询最新几条公告
    List<Notice> findLatest(Integer limit);

    //发布公告
    Integer insertNotice(Notice notice);

    //删除公告
    Integer deleteById(Integer noticeId);

    //设置/取消置顶
    Integer updateTop(@Param("noticeId") Integer noticeId, @Param("isTop") Integer isTop);

    //公告数量
    Integer selectTotalCount();
}
