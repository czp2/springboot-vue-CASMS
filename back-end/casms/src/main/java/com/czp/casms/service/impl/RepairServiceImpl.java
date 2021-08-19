package com.czp.casms.service.impl;

import com.czp.casms.model.entity.Repair;
import com.czp.casms.dao.RepairMapper;
import com.czp.casms.model.vo.RepairVo;
import com.czp.casms.service.RepairService;
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
public class RepairServiceImpl extends ServiceImpl<RepairMapper, Repair> implements RepairService {

    @Override
    public List<RepairVo> getRepairs(Integer id) {
        return this.baseMapper.getRepairs(id);
    }
}
