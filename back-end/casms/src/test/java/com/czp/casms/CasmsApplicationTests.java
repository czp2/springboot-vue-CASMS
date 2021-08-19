package com.czp.casms;

import com.czp.casms.model.entity.User;
import com.czp.casms.service.UserService;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import javax.annotation.Resource;
import java.util.List;

@SpringBootTest
class CasmsApplicationTests {
    @Resource
    private UserService userService;

    @Test
    void contextLoads() {
        List<User> list = userService.list();
        list.forEach(System.out::println);
    }

    @Test
    void testInsert() {
        User user = new User();
        user.setUserName("test1");
        user.setUserPwd("123456");
        user.setRole("ordinary_users");
        userService.save(user);
    }

}
