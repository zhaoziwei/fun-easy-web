package com.action.base;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;

import com.action.BaseAction;


/**
 * 机构action
 * 
 * 
 */
@Namespace("/base")
@Action
public class BranchAction extends BaseAction {

	/**
	 * 注入业务逻辑，使当前action调用service.xxx的时候，直接是调用基础业务逻辑
	 * 
	 * 如果想调用自己特有的服务方法时，请使用((TServiceI) service).methodName()这种形式强转类型调用
	 * 
	 * @param service
	 */
//	@Autowired
//	public void setService(BranchServiceI service) {
//		this.service = service;
//	}
//	public void doNotNeedSecurity_combobox(){
//		HqlFilter hqlFilter = new HqlFilter();
//		hqlFilter.addFilter("QUERY_t#ifdel_S_EQ", "0");
//		writeJson(service.findByFilter(hqlFilter));
//	}
}
