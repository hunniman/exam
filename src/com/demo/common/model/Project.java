package com.demo.common.model;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

@SuppressWarnings("serial")
public class Project extends Model<Project>{

	public static final Project dao = new Project();
	
	public Page<Project> paginate(int pageNumber, int pageSize,int state,String startDate,String endDate,boolean isAdmin,int userId) {
		StringBuilder sb=new StringBuilder("from project where 1=1 ");
		if(state>-1){
			sb.append("and state="+state);
		}
		if(!startDate.equals("")&&endDate.equals("")){
			sb.append(" and createTime>='"+startDate+" 00:00:00"+"'");
		}else if(!startDate.equals("")&&!endDate.equals("")){
			sb.append(" and createTime>='"+startDate +" 00:00:00"+"' and createTime<='"+endDate+" 00:00:00"+"'");
		}else if(startDate.equals("")&&!endDate.equals("")){
			sb.append(" and createTime<='"+endDate+" 00:00:00"+"'");
		}
		if(userId>0){
			sb.append(" and userId="+userId);
		}
		sb.append(" order by id desc");
		return paginate(pageNumber, pageSize, "select *", sb.toString());
	}
	
	
}
