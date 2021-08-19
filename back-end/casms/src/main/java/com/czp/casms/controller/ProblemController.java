package com.czp.casms.controller;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.czp.casms.lang.Result;
import com.czp.casms.model.entity.Problem;
import com.czp.casms.model.entity.User;
import com.czp.casms.model.vo.ProblemVo;
import com.czp.casms.service.ProblemService;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author CZP
 * @since 2021-04-01
 */
@RestController
@RequestMapping("/problem")
public class ProblemController {
    @Resource
    private ProblemService problemService;

    @PostMapping("/create")
    public Result add(@RequestBody @ApiParam("问题") Problem problem) {
        problem.setState("待审核");
        problemService.saveOrUpdate(problem);
        return Result.success("发布成功，请等待审核");
    }

    @DeleteMapping("/delete/{id}")
    @ApiOperation("删除问题")
    public Result remove(@PathVariable @ApiParam("ID") Integer id) {
        problemService.removeById(id);
        return Result.success(null);
    }

    @PutMapping("/update")
    @ApiOperation("修改问题")
    public Result update(@RequestBody @ApiParam("帖子信息") Problem problem) {
        problemService.updateById(problem);
        return Result.success(null);
    }

    @PostMapping("/getProblems")
    @ApiOperation("查询问题")
    public Result getProblems() {
        List<ProblemVo> problemList = problemService.getProblems();
        String problemTotal = String.valueOf(problemList.size());
        return Result.success(200,problemTotal,problemList);
    }

    @PostMapping("/reviewProblems")
    @ApiOperation("查询问题")
    public Result reviewProblems() {
        QueryWrapper<Problem> wrapper = new QueryWrapper<Problem>().eq("state", "待审核");
        List<Problem> problemList = problemService.list(wrapper);
        return Result.success(problemList);
    }

    @PostMapping("/getMyProblems/{id}")
    @ApiOperation("查询用户问题")
    public Result getMyProblems(@PathVariable @ApiParam("用户ID") Integer id) {
        QueryWrapper<Problem> wrapper = new QueryWrapper<Problem>().eq("user_id", id);
        List<Problem> problemList = problemService.list(wrapper);
        return Result.success(problemList);
    }
}
