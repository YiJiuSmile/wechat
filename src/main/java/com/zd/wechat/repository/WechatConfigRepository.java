package com.zd.wechat.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.zd.wechat.entity.WechatConfig;
public interface WechatConfigRepository extends JpaRepository<WechatConfig, String> {

}
