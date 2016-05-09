package com.demo.common.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

@SuppressWarnings("serial")
public class User extends Model<User>{

	public static final User dao = new User();
	
	public Page<User> paginate(int pageNumber, int pageSize) {
		return paginate(pageNumber, pageSize, "select *", "from userInfo order by id asc");
	}
	
	public User getUserByName(String name){
		return dao.findFirst("select * from userInfo where name=?", name);
	}
	
	public User getUserByAccount(String account){
		return dao.findFirst("select * from userInfo where account=?", account);
	}
	
	public List<User> getUsers() {
		List<User>result= dao.find("select * from userInfo order by createTime");
		return result;
	}
	
	public User getByOldPWD(String pwd){
		return dao.findFirst("select * from userInfo where password=?", pwd);
	}
	
	public User getByNameAndPWD(String name,String pwd){
		return dao.findFirst("select * from userInfo where pwd=? and account=?", pwd,name);
	}
}
