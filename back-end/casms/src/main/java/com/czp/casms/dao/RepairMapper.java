package com.czp.casms.dao;

import com.czp.casms.model.entity.Repair;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.czp.casms.model.vo.RepairVo;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author CZP
 * @since 2021-04-03
 */
public interface RepairMapper extends BaseMapper<Repair> {
    List<RepairVo> getRepairs(Integer id);
}
