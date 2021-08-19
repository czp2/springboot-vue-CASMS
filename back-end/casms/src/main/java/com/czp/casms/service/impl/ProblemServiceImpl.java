package com.czp.casms.service.impl;

import com.czp.casms.model.entity.Problem;
import com.czp.casms.dao.ProblemMapper;
import com.czp.casms.model.vo.ProblemVo;
import com.czp.casms.service.ProblemService;
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
public class ProblemServiceImpl extends ServiceImpl<ProblemMapper, Problem> implements ProblemService {
    @Override
    public List<ProblemVo> getProblems() {
        return this.baseMapper.getProblems();
    }
}
