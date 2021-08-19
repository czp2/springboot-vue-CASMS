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
 * @date 2021/4/18 14:31
 */
@Data
@EqualsAndHashCode(callSuper = false)
@ApiModel(value="Repair对象", description="")
public class RepairVo implements Serializable {
    private Integer repairId;

    private Integer userId;

    private Integer repairman;

    private String repairContent;

    private String state;

    private String tel;

    private String repairmanName;

    private String repairmanRealname;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime appointmentTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime completionTime;

    @ApiModelProperty(value = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
}
