package com.czp.casms.model.vo;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * @author czp
 * @version 1.0
 * @date 2021/4/18 0:49
 */
@Data
@EqualsAndHashCode(callSuper = false)
@ApiModel(value="Reply对象", description="")
public class ReplyVo implements Serializable {
    private Integer replyId;

    private Integer problemId;

    private Integer userId;

    private String replyContent;

    private String userName;

    private String role;

    @ApiModelProperty(value = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
}
