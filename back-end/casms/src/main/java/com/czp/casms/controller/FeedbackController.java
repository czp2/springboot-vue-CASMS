package com.czp.casms.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.czp.casms.lang.Result;
import com.czp.casms.model.dto.ReplySaveDto;
import com.czp.casms.model.entity.Feedback;
import com.czp.casms.model.entity.Problem;
import com.czp.casms.model.entity.Reply;
import com.czp.casms.model.vo.ReplyVo;
import com.czp.casms.service.FeedbackService;
import com.czp.casms.utils.DataTypeUtil;
import io.swagger.annotations.ApiOperation;
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
 * @since 2021-04-24
 */
@RestController
@RequestMapping("/feedback")
public class FeedbackController {
    @Resource
    private FeedbackService feedbackService;

    @PostMapping("/create")
    @ApiOperation("添加一条反馈")
    public Result add(@RequestBody Feedback feedback) {
        feedbackService.save(feedback);
        return Result.success(null);
    }

    @DeleteMapping("/delete/{id}")
    @ApiOperation("删除一条反馈")
    public Result remove(@PathVariable Integer id) {
        feedbackService.removeById(id);
        return Result.success(null);
    }

    @PutMapping("/update")
    @ApiOperation("修改一条反馈")
    public Result update(@RequestBody @ApiParam("回复消息") Feedback feedback) {
        feedbackService.updateById(feedback);
        return Result.success(null);
    }

    @PostMapping("/getFeedbacks")
    @ApiOperation("查询反馈")
    public Result getFeedbacks() {
        List<Feedback> feedbackList = feedbackService.list();
        return Result.success(feedbackList);
    }

    @PostMapping("/getFeedbacksByUserId/{id}")
    public Result getFeedbacksByUserId(@PathVariable Integer id) {
        QueryWrapper<Feedback> wrapper = new QueryWrapper<Feedback>().eq("user_id", id);
        List<Feedback> feedbackList = feedbackService.list(wrapper);
        return Result.success(feedbackList);
    }
}
