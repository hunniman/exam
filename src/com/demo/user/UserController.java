package com.demo.user;

import java.util.Date;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.demo.common.model.Blog;
import com.demo.common.model.User;
import com.demo.project.BaseController;
import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;

/**
 * BlogController
 * 所有 sql 与业务逻辑写在 Model 或 Service 中，不要写在 Controller 中，养成好习惯，有利于大型项目的开发与维护
 */
@Before(UserInterceptor.class)
public class UserController extends BaseController {
	
	private static final Logger logger=Logger.getLogger(UserController.class);  
	
	@Clear
	public void index() {
		render("login.jsp");
	}
	
	@Clear
	public void register() {
		render("signUp.jsp");
	}
	
	
	public void list() {
		render("userList.jsp");
	}
	
	
	public void examManager() {
		render("userList.jsp");
	}
	
	@Clear
	public void logOut() {
		removeSessionAttr("USER_SESSION");
		render("login.jsp");
	}
	
	public void update() {
		int id=getParaToInt("id");
		int flag=getParaToInt("flag",0);
		if(id>0){
			User user=User.dao.findById(id);
			if(user!=null){
				setAttr("user", user);
			}
		}
		setAttr("flag", flag);
		render("update.jsp");
	}
	
	@Before(UserInterceptor2.class)
	public void getUserList(){
		int offset=getParaToInt("offset", 1);
		int limit=getParaToInt("limit", 5);
		int index=offset/limit+1;
		Page<User> paginate = User.dao.paginate(index, limit);
		HashMap<String,Object>tempData=new HashMap<String,Object>();
		tempData.put("total", paginate.getTotalRow());
		tempData.put("rows", paginate.getList());
		renderJson(tempData);
	}
	
	@Clear
	public void doLogin() {
		try {
			String name=getPara("name");
			String password=getPara("password");
			String ecPwd=SecretUtils.encryptToMD5(password);
			User u=User.dao.getByNameAndPWD(name, ecPwd);
			if(u==null){
				renderJson("valid","faild");
			}else if(u.getBoolean("lock")){
				renderJson("valid","lock");
			}else{
				setSessionAttr("USER_SESSION", u);
				renderJson("valid","success");
			}
		} catch (Exception e) {
			renderJson("valid","faild");
			logger.error("doSignUp",e);
		}
	}
	
	@Clear
	public void doSignUp() {
		try {
			String name=getPara("name");
			String password=getPara("password");
//			String textConfirmPwd=getPara("textConfirmPwd");
			String account=getPara("account");
//			int position=getParaToInt("position");
			User u=new User();
			u.set("name", name);
			u.set("pwd", SecretUtils.encryptToMD5(password));
			u.set("account", account);
			u.set("position", 0);
			u.set("createTime", new Date());
			u.set("lock", false);
			u.save();
			renderJson("valid","success");
		} catch (Exception e) {
			renderJson("valid","faild");
			logger.error("doSignUp",e);
		}
	}
	
	
	
	public void doUpdate() {
		try {
			int id=getParaToInt("id");
			String name=getPara("name");
//			String password=getPara("password");
//			String textConfirmPwd=getPara("textConfirmPwd");
			String account=getPara("account");
			int position=getParaToInt("position",-1);
			User u=User.dao.findById(id);
			if(u==null){
				renderJson("valid","faild");
				return;
			}
			u.set("name", name);
//			u.set("pwd", SecretUtils.encryptToMD5(password));
			u.set("account", account);
			if(position>-1)
				u.set("position", position);
			u.update();
			renderJson("valid","success");
		} catch (Exception e) {
			renderJson("valid","faild");
			logger.error("doUpdate",e);
		}
	}
	
	public void deleteUser() {
		try {
			int id=getParaToInt("id");
			User u=User.dao.findById(id);
			if(u==null){
				renderJson("valid","faild");
				return;
			}
			u.delete();
			renderJson("valid","success");
		} catch (Exception e) {
			renderJson("valid","faild");
			logger.error("deleteUser",e);
		}
	}
	
	@Clear
	public void checkDunplicateName() {
		try {
			String name=getPara("name");
			int userId=getParaToInt("userId",0);
			if(name.equals(""))
				renderJson("valid",false);
			User u=User.dao.getUserByName(name);
			if(userId==0){
				if(u!=null){
					renderJson("valid",false);
				}else{
					renderJson("valid",true);
				}
			}else{
				if(u!=null&&u.getInt("id")!=userId){
					renderJson("valid",false);
				}else{
					renderJson("valid",true);
				}
			}
		} catch (Exception e) {
			renderJson("valid",false);
			logger.error("checkDunplicateName",e);
		}
	}
	
	@Clear
	public void checkDunplicateAccount() {
		try {
			String account=getPara("account");
			int userId=getParaToInt("userId",0);
			if(account.equals(""))
				renderJson("valid",false);
			User u=User.dao.getUserByAccount(account);
			if(userId==0){
				if(u!=null){
					renderJson("valid",false);
				}else{
					renderJson("valid",true);
				}
			}else{
				if(u!=null&&u.getInt("id")!=userId){
					renderJson("valid",false);
				}else{
					renderJson("valid",true);
				}
			}
		} catch (Exception e) {
			renderJson("valid",false);
			logger.error("checkDunplicateAccount",e);
		}
	}
	
	public void password(){
		setAttr("userId", getUserId());
		render("updatePWD.jsp");
	}
	
	public void updatePassword(){
		try {
			int id=getParaToInt("userId",0);
		    String password=getPara("password");
		    User user=User.dao.findById(id);
		    if(user!=null){
		    	user.set("pwd", SecretUtils.encryptToMD5(password));
		    	user.update();
		    	renderJson("valid","success");
		    }
		} catch (Exception e) {
			logger.error("updatePassword error ",e);
			renderJson("valid","faild");
		}
	}
}


