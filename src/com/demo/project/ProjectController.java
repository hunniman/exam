package com.demo.project;

import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.demo.common.model.ExamType;
import com.demo.common.model.Project;
import com.demo.common.model.User;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;

/**
 * BlogController
 * 所有 sql 与业务逻辑写在 Model 或 Service 中，不要写在 Controller 中，养成好习惯，有利于大型项目的开发与维护
 */
@Before(ProjectInterceptor.class)
public class ProjectController extends BaseController {
	
	private static final Logger logger=Logger.getLogger(ProjectController.class);  
	
	public void index() {
		if(getUserPosition()>0){
			List<User> users = User.dao.getUsers();
			setAttr("users", users);
		}
		render("list.jsp");
	}
	
	public void getList(){
		int state=getParaToInt("state");
		String startDateStr=getPara("startDate");
		String endDateStr=getPara("endDate");
		int offset=getParaToInt("offset", 1);
		int limit=getParaToInt("limit", 5);
		int userId=getParaToInt("uid",0);
		int index=offset/limit+1;
		User user=getUserSession();
		if(userId<=0&&getUserPosition()==0){
			userId=user.getInt("id");
		}
		Page<Project> paginate = Project.dao.paginate(index, limit,state,startDateStr,endDateStr,getUserPosition()==1,userId);
		HashMap<String,Object>tempData=new HashMap<String,Object>();
		tempData.put("total", paginate.getTotalRow());
		tempData.put("rows", paginate.getList());
		renderJson(tempData);
	}
	
	
	public void printPage(){
		int state=getParaToInt("state");
		String startDateStr=getPara("startDate");
		String endDateStr=getPara("endDate");
//		int userId=getParaToInt("uid",0);
		int pageNum=getParaToInt("pageNum", 1);
		int pageSize=getParaToInt("pageSize", 5);
//		int index=offset/limit+1;
//		Page<Project> paginate = Project.dao.paginate(pageNum, pageSize,state,startDateStr,endDateStr);
//		HashMap<String,Object>tempData=new HashMap<String,Object>();
//		tempData.put("total", paginate.getTotalRow());
//		tempData.put("rows", paginate.getList());
//		renderJson(tempData);
		int userId=getParaToInt("uid",0);
		setAttr("state", state);
		setAttr("startDateStr", startDateStr);
		setAttr("endDateStr", endDateStr);
		setAttr("pageNum", pageNum);
		setAttr("pageSize", pageSize);
		User user=getUserSession();
		if(userId<=0&&getUserPosition()==0){
			userId=user.getInt("id");
		}
		Page<Project> paginate = Project.dao.paginate(pageNum, pageSize,state,startDateStr,endDateStr,user.getInt("position")==1,userId);
//		render("printPage.jsp");
		generalExcel(paginate.getList());
		renderNull();
	}
	
	
	public void getPrintData(){
		int state=getParaToInt("state");
		String startDateStr=getPara("startDate");
		String endDateStr=getPara("endDate");
		int pageNum=getParaToInt("pageNum", 1);
		int pageSize=getParaToInt("pageSize", 5);
		int userId=getParaToInt("uid",0);
//		int index=offset/limit+1;
		User user=getUserSession();
		if(userId<=0&&getUserPosition()==0){
			userId=user.getInt("id");
		}
		Page<Project> paginate = Project.dao.paginate(pageNum, pageSize,state,startDateStr,endDateStr,user.getInt("position")==1,userId);
		HashMap<String,Object>tempData=new HashMap<String,Object>();
		tempData.put("total", paginate.getTotalRow());
		tempData.put("rows", paginate.getList());
		renderJson(paginate.getList());
	}
	
	
	
	public void add() {
		int id=getParaToInt("id",0);
		Project pro=new Project();
		if(id>0){
			 pro=Project.dao.findById(id);
		}else{
			pro.set("business", getBusinessName());
		}
		setAttr("pro", pro);
		render("add.jsp");
	}
	
	
	public void doAdd() {
		try {
			int id=getParaToInt("id",0);
			String acceptDate=getPara("acceptDate");
			String client=getPara("client");
			String contacts=getPara("contacts");
			String projectName=getPara("projectName");
			int hmoney=getParaToInt("hmoney");
			int nmoney=getParaToInt("nmoney");
			String estimateDate=getPara("estimateDate");
			String business=getPara("business");
			String design=getPara("design");
			String description=getPara("description");
			int state=getParaToInt("state");

			if(id==0){
				Project pro=new Project();
				pro.set("acceptDate", acceptDate);
				pro.set("estimateDate", estimateDate);
				pro.set("client", client);
				pro.set("contacts", contacts);
				pro.set("projectName", projectName);
				pro.set("hmoney", hmoney);
				pro.set("nmoney", nmoney);
				pro.set("business", business);
				pro.set("design", design);
				pro.set("description", description);
				pro.set("state", state);
				pro.set("userId", getUserId());
				pro.set("createTime", new Date());
				pro.save();
			}else{
				Project pro=Project.dao.findById(id);
				if(pro==null){
					logger.warn("id="+id+" pro==null");
				}else{
					pro.set("acceptDate", acceptDate);
					pro.set("estimateDate", estimateDate);
					pro.set("client", client);
					pro.set("contacts", contacts);
					pro.set("projectName", projectName);
					pro.set("hmoney", hmoney);
					pro.set("nmoney", nmoney);
					pro.set("business", business);
					pro.set("design", design);
					pro.set("description", description);
					pro.set("state", state);
					pro.set("userId", getUserId());
					pro.set("updateTime", new Date());
					pro.update();
				}
			}
			renderJson("valid","success");
		} catch (Exception e) {
			renderJson("valid","faild");
			logger.error("doAdd",e);
		}
	}
	
	
	
	public void list() {
		render("userList.jsp");
	}
	
	
	public void delete() {
		try {
			int id=getParaToInt("id");
			Project u=Project.dao.findById(id);
			if(u==null){
				renderJson("valid","faild");
				return;
			}
			u.delete();
			renderJson("valid","success");
		} catch (Exception e) {
			renderJson("valid","faild");
			logger.error("delete ",e);
		}
	}
	
	public  void generalExcel(List<Project>proList){
		String[]header=new String[]{"接单日期","客户","联系人/电话","项目","已收金额","未收金额","预计交货日期","业务","设计","备注"};
		
		String[]fileName=new String[]{"acceptDate","client","contacts","projectName","hmoney","nmoney","estimateDate","business","design","description"};
		 //创建HSSFWorkbook对象(excel的文档对象)
    	XSSFWorkbook wb = new XSSFWorkbook();
        //建立新的sheet对象（excel的表单）
        XSSFSheet sheet=wb.createSheet("业务");
        
        // 设置表格默认列宽度为15个字节  
        sheet.setDefaultColumnWidth((short) 15);  
        // 生成一个样式  
        XSSFCellStyle style = wb.createCellStyle();  
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
        // 生成一个字体  
        XSSFFont font = wb.createFont();  
//        font.setColor(HSSFColor.VIOLET.index);  
        font.setFontHeightInPoints((short) 16);  
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);  
        // 把字体应用到当前的样式  
        style.setFont(font);  
        
        
        
        //在sheet里创建第一行，参数为行索引(excel的行)，可以是0～65535之间的任何一个
        XSSFRow row1=sheet.createRow(1);
        //创建单元格（excel的单元格，参数为列索引，可以是0～255之间的任何一个
        XSSFCell cell=row1.createCell(1);
        //设置单元格内容
        cell.setCellValue("星空广告业务清单");
        cell.setCellStyle(style);
        
        //合并单元格CellRangeAddress构造参数依次表示起始行，截至行，起始列， 截至列
        sheet.addMergedRegion(new CellRangeAddress(1,1,1,header.length));
        
        XSSFRow row2=sheet.createRow(2);
        
        for(int i=1;i<=header.length;i++){
        	//创建单元格并设置单元格内容
        	XSSFCell createCell = getCell(wb, row2, i);
        	createCell.setCellValue(header[i-1]);
        }
        
        /**** 内容开始***/
        int startRows=3;
        for(Project pro:proList){
        	XSSFRow row3=sheet.createRow(startRows);
        	for(int i=1;i<=fileName.length;i++){
        		XSSFCell cellTemp=getCell(wb, row3, i);
        		cellTemp.setCellValue(pro.get((fileName[i-1])).toString());
        	}
        	startRows++;
        }
        try{
            HttpServletResponse response = getResponse();
           // 清空response  
            response.reset();  
            String    mimetype = "application/x-msdownload";
            response.setContentType(mimetype);
            // 设置response的Header  
            String downFileName =System.currentTimeMillis()+".xlsx";
            String inlineType = "attachment"; // 是否内联附件
            response.setHeader("Content-Disposition", inlineType+ ";filename=\"" + downFileName + "\"");
            OutputStream out=response.getOutputStream();
            wb.write(out);
            out.flush();
            out.close();
        }catch (Exception e){
        	
        }

	}
	
	private  XSSFCell getCell(XSSFWorkbook wb ,XSSFRow row,int index){
		XSSFCellStyle style2 = wb.createCellStyle();  
        style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);  
        style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);  
        style2.setBorderRight(HSSFCellStyle.BORDER_THIN);  
        style2.setBorderTop(HSSFCellStyle.BORDER_THIN);  
        style2.setAlignment(HSSFCellStyle.ALIGN_CENTER); 
        style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        XSSFCell createCell = row.createCell(index);
    	createCell.setCellStyle(style2);
    	return createCell;
	}
	
	
	public void add2() {
		render("add2.jsp");
	}
	
	
	public void examManager() {
		render("examManager.jsp");
	}
	
	public void addExamType() {
		int id=getParaToInt("id",0);
		ExamType examType=new ExamType();
		if(id>0){
			examType=ExamType.dao.findById(id);
		}
		setAttr("examType", examType);
		render("addExamType.jsp");
	}
	
	/**
	 * 修改或者增加试卷类型
	 */
	public void doUpdateExamType(){
		try{
			int id=getParaToInt("id",0);
			String name=getPara("name");
//			int state=getParaToInt("state");
//			boolean bState=state==1?true:false;
			ExamType examType=new ExamType();
			if(id<=0){
				examType.set("name", name);
//				examType.set("bState", bState);
				examType.save();
			}else{
				examType=ExamType.dao.findById(id);
				examType.set("name", name);
//				examType.set("bState", bState);
				examType.update();
			}
			renderJson("valid","success");
		}catch(Exception e){
			renderJson("valid","faild");
		}
	}
	
	
	/**
	 * 删除
	 */
	public void doDeleteExamType(){
		try{
			int id=getParaToInt("id",0);
			ExamType examType=ExamType.dao.findById(id);
			if(examType!=null){
				examType.delete();
				renderJson("valid","success");
			}else{
				renderJson("valid","faild");
			}
		}catch(Exception e){
			renderJson("valid","faild");
		}
	}
	
	/**
	 * exam list 	 */
	public void examTypeList(){ 
		render( "examTypeList.jsp");
	}
	
	
	/**
	 * 增加试卷页面
	 */
	public void examAdd() {
		int typeId =getParaToInt("id",0);
		List<ExamType>examTypeList=ExamType.dao.getAllType();
		setAttr("examTypeList", examTypeList);
		render("addExam.jsp");
	}
	
	public void getExamTypleList(){
		List<ExamType>list = ExamType.dao.getAllType();
		HashMap<String,Object>tempData=new HashMap<String,Object>();
		tempData.put("total", list.size());
		tempData.put("rows", list);
		renderJson(tempData);
	}
	
	public static void main(String[] args) {
//		generalExcel();
	}
}


