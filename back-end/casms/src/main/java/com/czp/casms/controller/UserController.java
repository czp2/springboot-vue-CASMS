package com.czp.casms.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.czp.casms.lang.Result;
import com.czp.casms.model.entity.Repair;
import com.czp.casms.model.entity.User;
import com.czp.casms.service.UserService;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.validation.annotation.Validated;
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
@RequestMapping("/user")
public class UserController {
    @Resource
    private UserService userService;

    @PostMapping(value = "/login")
    public Result login(@Validated @RequestBody User user) {
        QueryWrapper<User> userQueryWrapper = new QueryWrapper<User>().eq("user_name", user.getUserName());
        if(user.getRole().equals("普通用户")){
            userQueryWrapper.and(wrapper -> wrapper.eq("role", user.getRole()).or().eq("role", "申请成为维修员"));
        }else {
            userQueryWrapper.eq("role", user.getRole());
        }
        User exsitUser = userService.getOne(userQueryWrapper);
        if (!user.getUserName().isEmpty() && !user.getUserPwd().isEmpty()) {
            if (exsitUser == null) {
                return Result.fail("该用户未注册或者身份认证失败");
            } else if (!exsitUser.getUserPwd().equals(user.getUserPwd())) {
                return Result.fail("密码错误,请重新输入");
            } else {
                return Result.success(200, "身份认证成功", exsitUser);
            }
        } else {
            return Result.fail("后端未接受到参数");
        }
    }

    @ApiOperation(value = "用户注册", notes = "用户注册")
    @PostMapping("/register")
    public Result register(@Validated @RequestBody User user) {
        QueryWrapper<User> wrapperUserName = new QueryWrapper<User>().eq("user_name", user.getUserName());
        QueryWrapper<User> wrapperEmail = new QueryWrapper<User>().eq("email", user.getEmail());
        if (userService.getOne(wrapperEmail) != null) {
            return Result.fail("该邮箱已被注册");
        } else if (userService.getOne(wrapperUserName) != null) {
            return Result.fail("该用户名已被注册");
        } else {
            user.setRole("普通用户");
            user.setAvator("dog.png");
            userService.save(user);
            return Result.success("注册成功，可前往登录界面");
        }
    }

    @ApiOperation(value = "查询所有用户", notes = "查询所有用户")
    @PostMapping(value = "/getUsers")
    public Result getUsers(@RequestParam String query) {
        QueryWrapper<User> userQueryWrapper;
        List<User> list;
        if(query.equals("1")){
            userQueryWrapper = new QueryWrapper<User>().eq("role","申请成为维修员");
            list = userService.list(userQueryWrapper);
        }else {
            list = userService.list();
        }
        return Result.success(list);
    }

    @ApiOperation(value = "查询单个用户", notes = "查询单个用户")
    @PostMapping(value = "/getUserById")
    public Result getUserById(@RequestParam Integer id) {
        User user = userService.getById(id);
        return Result.success(user);
    }

    @ApiOperation(value = "删除用户", notes = "删除用户")
    @DeleteMapping(value = "/deleteUserById/{id}")
    public Result deleteUserById(@PathVariable @ApiParam("删除的用户ID") Integer id) {
        userService.removeById(id);
        return Result.success("删除成功");
    }

    @PutMapping("/userInfoSet")
    public Result updateUserInfo(@RequestBody User user) {
        userService.updateById(user);
        return Result.success("修改成功");
    }

    @ApiOperation(value = "模糊查询用户", notes = "模糊查询用户")
    @PostMapping("/selectUser")
    public Result selectUser(@RequestParam String element) {
        QueryWrapper<User> userQueryWrapper = new QueryWrapper<User>()
                .like("user_name", element)
                .or().like("user_id", element)
                .or().like("address", element)
                .or().like("realname", element)
                .or().like("tel", element);
        List<User> userList = userService.list(userQueryWrapper);
        return Result.success(200,"查询成功",userList);
    }
}
