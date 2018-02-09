package com.zd.wechat.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.zd.wechat.entity.WechatTemplate;
public interface WechatTemplateRepository extends JpaRepository<WechatTemplate, String> {

}
