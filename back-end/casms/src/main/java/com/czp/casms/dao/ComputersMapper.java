package com.czp.casms.dao;

import com.czp.casms.model.entity.Computers;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.czp.casms.model.vo.ComputersVo;
import com.czp.casms.model.vo.RepairEchartsVo;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author CZP
 * @since 2021-05-08
 */
public interface ComputersMapper extends BaseMapper<Computers> {

    List<ComputersVo> getComputersByUserId(Integer id);

    List<RepairEchartsVo> getComputersRepair();
}
