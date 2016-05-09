package com.demo.common.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

@SuppressWarnings("serial")
public class ExamType extends Model<ExamType>{

	public static final ExamType dao = new ExamType();
	
	public Page<ExamType> paginate(int pageNumber, int pageSize) {
		return paginate(pageNumber, pageSize, "select *", "from examType order by id asc");
	}
	
	public List<ExamType>getAllType(){
		return dao.find("select * from examType order by id asc");
	}
	
}
