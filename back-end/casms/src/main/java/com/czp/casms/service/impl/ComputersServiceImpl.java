package com.czp.casms.service.impl;

import com.czp.casms.model.entity.Computers;
import com.czp.casms.dao.ComputersMapper;
import com.czp.casms.model.vo.ComputersVo;
import com.czp.casms.model.vo.RepairEchartsVo;
import com.czp.casms.service.ComputersService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author CZP
 * @since 2021-05-08
 */
@Service
public class ComputersServiceImpl extends ServiceImpl<ComputersMapper, Computers> implements ComputersService {

    @Override
    public List<ComputersVo> getComputersByUserId(Integer id) {
        return this.baseMapper.getComputersByUserId(id);
    }

    @Override
    public List<RepairEchartsVo> getComputersRepair() {
        return this.baseMapper.getComputersRepair();
    }
}
