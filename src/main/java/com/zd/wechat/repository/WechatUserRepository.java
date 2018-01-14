package com.zd.wechat.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.zd.wechat.entity.WechatUser;

public interface WechatUserRepository extends JpaRepository<WechatUser, String> {

}
