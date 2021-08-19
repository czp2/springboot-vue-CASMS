package com.czp.casms.model.vo;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;

/**
 * @author czp
 * @version 1.0
 * @date 2021/5/8 9:53
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ComputersVo {
    private Integer userId;

    private Integer computerId;

    private String company;

    private String model;

    private String cpu;

    private String graphicsCard;

    private Integer memory;

    private String storage;

    @ApiModelProperty(value = "购买时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;

    @ApiModelProperty(value = "保修截止时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime warranty;
}
