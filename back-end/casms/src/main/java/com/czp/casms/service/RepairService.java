package com.czp.casms.service;

import com.czp.casms.model.entity.Repair;
import com.baomidou.mybatisplus.extension.service.IService;
import com.czp.casms.model.vo.RepairVo;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author CZP
 * @since 2021-04-03
 */
public interface RepairService extends IService<Repair> {
    List<RepairVo> getRepairs(Integer id);
}
