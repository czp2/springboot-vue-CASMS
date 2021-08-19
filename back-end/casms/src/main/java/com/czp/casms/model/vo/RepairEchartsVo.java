package com.czp.casms.model.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author czp
 * @version 1.0
 * @date 2021/5/13 23:27
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class RepairEchartsVo {
    private String model;
    private Integer count;
}
