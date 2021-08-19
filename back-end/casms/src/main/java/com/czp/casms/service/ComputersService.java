package com.czp.casms.service;

import com.czp.casms.model.entity.Computers;
import com.baomidou.mybatisplus.extension.service.IService;
import com.czp.casms.model.vo.ComputersVo;
import com.czp.casms.model.vo.RepairEchartsVo;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author CZP
 * @since 2021-05-08
 */
public interface ComputersService extends IService<Computers> {
    List<ComputersVo> getComputersByUserId(Integer id);

    List<RepairEchartsVo> getComputersRepair();
}
