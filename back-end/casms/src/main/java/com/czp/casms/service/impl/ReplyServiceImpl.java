package com.czp.casms.service.impl;

import com.czp.casms.model.entity.Reply;
import com.czp.casms.dao.ReplyMapper;
import com.czp.casms.model.vo.ReplyVo;
import com.czp.casms.service.ReplyService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author CZP
 * @since 2021-04-03
 */
@Service
public class ReplyServiceImpl extends ServiceImpl<ReplyMapper, Reply> implements ReplyService {

    @Override
    public List<ReplyVo> getReplysByProblemId(Integer id) {
        return this.baseMapper.getReplysByProblemId(id);
    }
}
