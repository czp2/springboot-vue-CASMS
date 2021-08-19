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
 * @date 2021/4/18 13:35
 */
@Data
@EqualsAndHashCode(callSuper = false)
@ApiModel(value="Problem对象", description="")
public class ProblemVo implements Serializable {
    private Integer problemId;

    private String userName;

    private String solver;

    private String model;

    private String title;

    private String content;

    private String state;

    private Integer solutionId;

    @ApiModelProperty(value = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime solutionTime;
}
