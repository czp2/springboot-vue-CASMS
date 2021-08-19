package com.czp.casms.service;

import com.czp.casms.model.entity.Reply;
import com.baomidou.mybatisplus.extension.service.IService;
import com.czp.casms.model.vo.ReplyVo;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author CZP
 * @since 2021-04-03
 */
public interface ReplyService extends IService<Reply> {
    List<ReplyVo> getReplysByProblemId(Integer id);
}
