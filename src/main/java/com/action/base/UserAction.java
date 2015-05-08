package com.action.base;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;

import com.action.BaseAction;
import com.entity.base.UserInfo;
import com.model.easyui.Json;
import com.service.user.UserService;
@Namespace("/base")
@Action("user")
public class UserAction extends BaseAction<UserInfo>{
	@Autowired
	public void setService(UserService service) {
		this.service = service;
	}
	public void doNotNeedSecurity_saveUser(){
		//UserServiceImpl service = new UserServiceImpl();
		Json json = new Json();
		UserInfo user = new UserInfo();
		user.setUserName("zhangxiaobing");
		json.setMsg("插入成功");
		
		try{
			service.save(user);
		}catch (Exception e) {
			e.printStackTrace();
		   }
	json.setSuccess(true);
		writeJson(json);
	}
}
