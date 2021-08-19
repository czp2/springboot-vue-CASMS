package com.czp.casms.model.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

@Data
@ApiModel(value = "Reply对象", description = "帖子回复表")
public class ReplySaveDto implements Serializable {

    @ApiModelProperty(value = "帖子ID")
    private Integer problemId;

    private Integer userId;

    @ApiModelProperty(value = "回复内容")
    private String replyContent;

}