package com.czp.casms.lang;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ApiModel("结果集")
public class Result {

    @ApiModelProperty("状态码")
    private int code;//状态码
    @ApiModelProperty("消息")
    private String msg;
    @ApiModelProperty("结果数据")
    private Object data;

    public static Result success(Object data) {
        return success(200, "success", data);
    }

    public static Result success(int code, String msg, Object data) {
        return new Result(code, msg, data);
    }

    public static Result fail(String msg) {
        return fail(500, msg, null);
    }

    public static Result fail(int code, String msg, Object data) {
        return new Result(code, msg, data);
    }

}