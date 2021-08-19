package com.czp.casms.controller;

import com.czp.casms.lang.Result;
import com.czp.casms.model.vo.ComputersVo;
import com.czp.casms.model.vo.RepairEchartsVo;
import com.czp.casms.service.ComputersService;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author CZP
 * @since 2021-05-08
 */
@RestController
@RequestMapping("/computers")
public class ComputersController {
    @Resource
    private ComputersService computersService;

    @PostMapping("/getComputersByUserId/{id}")
    public Result getComputersByUserId(@PathVariable int id) {
        List<ComputersVo> computersList = computersService.getComputersByUserId(id);
        return Result.success(computersList);
    }

    @PostMapping("/getComputersRepair")
    @ApiOperation("查询所有电脑维修次数")
    public Result getComputersRepair() {
        List<RepairEchartsVo> repairEcharts = computersService.getComputersRepair();
        return Result.success(repairEcharts);
    }
}
