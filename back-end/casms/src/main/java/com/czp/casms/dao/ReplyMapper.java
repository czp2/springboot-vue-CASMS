package com.czp.casms.dao;

import com.czp.casms.model.entity.Reply;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.czp.casms.model.vo.ReplyVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author CZP
 * @since 2021-04-03
 */
public interface ReplyMapper extends BaseMapper<Reply> {

    List<ReplyVo> getReplysByProblemId(@Param("id") Integer id);
}
