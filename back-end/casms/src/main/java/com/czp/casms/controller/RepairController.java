package com.czp.casms.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.czp.casms.lang.Result;
import com.czp.casms.model.entity.Repair;
import com.czp.casms.model.vo.RepairVo;
import com.czp.casms.service.RepairService;
import io.swagger.annotations.ApiParam;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author CZP
 * @since 2021-04-03
 */
@RestController
@RequestMapping("/repair")
public class RepairController {
    @Resource
    private RepairService repairService;

    @PostMapping("/create")
    public Result add(@RequestBody @ApiParam("参数") Repair repair) {
        repairService.saveOrUpdate(repair);
        return Result.success("成功申请，请等待管理员审核，审核通过后才能得到处理");
    }

    @DeleteMapping("/delete/{id}")
    public Result remove(@PathVariable Integer id) {
        repairService.removeById(id);
        return Result.success(null);
    }

    @PutMapping("/update")
    public Result update(@RequestBody @ApiParam("信息") Repair repair) {
        repairService.updateById(repair);
        return Result.success(null);
    }

    @PostMapping("/getRepairList")
    public Result getRepairList(@RequestBody @ApiParam("信息") Repair repair) {
        String state = repair.getState();
        QueryWrapper<Repair> wrapper;
        if (!state.equals("")) {
            if (state.equals("待审核")||state.equals("已审核")) {
                wrapper = new QueryWrapper<Repair>().eq("state", state);
            } else {
                Integer repairman = repair.getRepairman();
                wrapper = new QueryWrapper<Repair>()
                        .eq("repairman", repairman)
                        .eq("state", state);
            }
        } else {
            wrapper = new QueryWrapper<Repair>().ne("state", "待审核");
        }
        List<Repair> repairList = repairService.list(wrapper);
        return Result.success(repairList);
    }

    @PostMapping("/selectRepair")
    public Result selectRepair(@RequestParam String element) {
        QueryWrapper<Repair> queryWrapper = new QueryWrapper<Repair>()
                .like("repairman", element)
                .or().like("repair_content", element);
        List<Repair> repairList = repairService.list(queryWrapper);
        return Result.success(200, "查询成功", repairList);
    }

    @PostMapping("/getMyRepair/{id}")
    public Result getRepairs(@PathVariable @ApiParam("用户ID") Integer id) {
        List<RepairVo> repairList = repairService.getRepairs(id);
        return Result.success(repairList);
    }
}
