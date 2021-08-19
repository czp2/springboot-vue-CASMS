package com.czp.casms.service.impl;

import com.czp.casms.model.entity.User;
import com.czp.casms.dao.UserMapper;
import com.czp.casms.service.UserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author CZP
 * @since 2021-04-03
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

}
