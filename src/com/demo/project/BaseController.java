package com.demo.project;

import com.demo.common.model.User;
import com.jfinal.core.Controller;

public class BaseController extends Controller{

	
   public User getUserSession(){
		Object obj= getSessionAttr("USER_SESSION");
		if(obj==null)
			return null;
		else
			return (User)obj;
   }
   
   public int getUserId(){
	   User user=getUserSession();
	   if(user==null)return 23;
	   else
		   return user.getInt("id");
   }
   
   public String getBusinessName(){
	   User user=getUserSession();
	   if(user==null)return "";
	   else
		   return user.getStr("name");
   }
   
   public int getUserPosition(){
	   User user=getUserSession();
	   if(user==null)return 0;
	   else
		   return user.getInt("position");
   }
}
