<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../common/css.jsp" />
<jsp:include page="../common/js.jsp" />
<jsp:include page="../common/validator.jsp" />
<jsp:include page="../common/loading.jsp" />
<jsp:include page="../common/dataGrid.jsp" />

<%-- <script src="<%=request.getContextPath()%>/resource/js/jquery-migrate-1.1.0.js"></script> --%>
<%-- <script src="<%=request.getContextPath()%>/resource/js/jquery.jqprint-0.3.js"></script> --%>
<style type="text/css">
/*   table,tr,td,th{ */
/*     border:1px solid  black; */
/*   } */
</style>
<script type="text/javascript">
   $(function(){
	   var projectPath=$("#projectPath").val(); 
	   
	   var $table = $('#table');
	   
	   $("#btnRAdd").bind("click",function(){
		   window.open(projectPath+"/project/add", "_self");
	   });
	   
	   $("#btnPrint").bind("click",function(){
		   $table.jqprint();
	   });
	   
	   
	   var initTable=function(d){
		   $('#table').bootstrapTable({
// 			    data:d.rows,
 				url: projectPath+'/project/getPrintData?state='+$("#state").val()+"&startDate="+$("#startDate").val()+"&endDate="+$("#endDate").val()+"&pageNum="+$("#pageNum").val()+"&pageSize="+$("#pageSize").val(),
			    columns: [{
			        field: 'acceptDate',
			        title: '接单日期'
			    }, {
			        field: 'client',
			        title: '客户'
			    }, {
			        field: 'contacts',
			        title: '联系人/电话'
			    }, {
			        field: 'projectName',
			        title: '项目'
			    }, {
			        field: 'hmoney',
			        title: '已收金额'
			    }, {
			        field: 'nmoney',
			        title: '未收金额'
			    }, {
			        field: 'estimateDate',
			        title: '预计交货日期'
			    }, {
			        field: 'business',
			        title: '业务'
			    }, {
			        field: 'design',
			        title: '设计'
			    }, {
			        field: 'description',
			        title: '备注'
			    },{
			        field: 'state',
			        title: '状态',
			        width:60,
			        formatter:function(value, row, index){
			        	 if(value==1)
			                	return "已完成";
			                else
			                	return "未完成"
			        }
			    }]
			});
	   };
	   
	 initTable();
	   
   });
</script>
</head>
<body>
	<input id="projectPath" type="hidden" value="<%=request.getContextPath()%>">
	
	<input id="state" type="hidden" value="${state}">
	<input id="startDateStr" type="hidden" value="${startDateStr}">
	<input id="endDateStr" type="hidden" value="${endDateStr}">
	<input id="pageNum" type="hidden" value="${pageNum}">
	<input id="pageSize" type="hidden" value="${pageSize}">
	
	
<%-- 	<jsp:include page="../common/header.jsp" /> --%>
<!-- 	<div class="jumbotron"></div> -->
	<div class="container" style="width:80%;">
	      <div class="rows" style="text-align:center;">
	          <h1>星空广告业务清单</h1>
	      </div>
		  <table id="table" >
		  </table>
	</div>
</body>
</html>
