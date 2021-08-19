package com.czp.casms.service;

import com.czp.casms.model.entity.Problem;
import com.baomidou.mybatisplus.extension.service.IService;
import com.czp.casms.model.vo.ProblemVo;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author CZP
 * @since 2021-04-03
 */
public interface ProblemService extends IService<Problem> {
    List<ProblemVo> getProblems();
}
