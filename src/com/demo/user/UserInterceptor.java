package com.demo.user;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;

/**
 * BlogInterceptor
 * 此拦截器仅做为示例展示，在本 demo 中并不需要
 */
public class UserInterceptor implements Interceptor {
	
	public void intercept(Invocation ai) {
		System.out.println("Before invoking " + ai.getActionKey());
		Object obj= ai.getController().getSessionAttr("USER_SESSION");
		if(obj==null){
			ai.getController().redirect("/user/login");
			return;
		}
//		User u=(User)obj;
//		if(u.getInt("position")==0){
//			ai.getController().redirect("/user/login");
//			return;
//		}
		ai.invoke();
		System.out.println("After invoking " + ai.getActionKey());
	}
}
