package com.czp.casms.dao;

import com.czp.casms.model.entity.Problem;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.czp.casms.model.vo.ProblemVo;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author CZP
 * @since 2021-04-03
 */
public interface ProblemMapper extends BaseMapper<Problem> {

    List<ProblemVo> getProblems();
}
