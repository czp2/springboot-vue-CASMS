package com.czp.casms.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.czp.casms.lang.Result;
import com.czp.casms.model.dto.ReplySaveDto;
import com.czp.casms.model.entity.Reply;
import com.czp.casms.model.vo.ReplyVo;
import com.czp.casms.service.ReplyService;
import com.czp.casms.utils.DataTypeUtil;
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
@RequestMapping("/reply")
public class ReplyController {
    @Resource
    private ReplyService replyService;

    @PostMapping("/create")
    @ApiOperation("添加一条回复消息")
    public Result add(@RequestBody @ApiParam("回复消息") ReplySaveDto dto) {
        Reply reply = DataTypeUtil.buildType(Reply.class, dto);
        replyService.save(reply);
        return Result.success(null);
    }

    @DeleteMapping("/delete/{id}")
    @ApiOperation("删除一条回复消息")
    public Result remove(@PathVariable @ApiParam("回复消息的主键ID") Integer id) {
        replyService.removeById(id);
        return Result.success(null);
    }

    @PutMapping("/update")
    @ApiOperation("修改一条回复消息")
    public Result update(@RequestBody @ApiParam("回复消息") Reply reply) {
        replyService.updateById(reply);
        return Result.success(null);
    }

    @PostMapping("/getReplysByProblemId/{id}")
    @ApiOperation("查询回复消息")
    public Result getReplysByProblemId(@PathVariable @ApiParam("问题的主键ID") Integer id) {
        List<ReplyVo> replyList = replyService.getReplysByProblemId(id);
        return Result.success(replyList);
    }
}
