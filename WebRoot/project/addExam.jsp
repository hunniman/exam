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

<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/bootstrapvalidator/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css">
<script src="<%=request.getContextPath()%>/resource/bootstrapvalidator/bootstrap-datetimepicker/js/moment.min.js"></script>
<script src="<%=request.getContextPath()%>/resource/bootstrapvalidator/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>

<script src="../resource/js/examAdd.js"></script>
</head>
<body>
    <input id="projectPath" type="hidden" value="<%=request.getContextPath()%>">
	<jsp:include page="../common/header.jsp" />
	<div class="jumbotron">
	
	</div>
	<div class="container">
<!-- 	  <div class="rws"> -->
<!-- 				<div class="col-sm-12" style="text-align:right;" > -->
<!-- 					 <button id="btnRAddExam" class="btn btn-primary ladda-button" data-style="expand-right" type="button"> -->
<!-- 						  <span class="ladda-label">增加题目</span> -->
<!-- 					 </button> -->
<!-- 				</div> -->
<!-- 		</div> -->
<!-- 		<br> -->
		<form id="regForm" class="form-horizontal" role="form">
			<input id="id" type="hidden" name="id" value="${examType.id}">
			
			<div class="form-group">
				<label for="inputPassword" class="col-sm-2 control-label">
					试题：</label>
				<div class="col-sm-10">
					<select class="form-control" name="state">
						<option value="0"> </option>
					    <c:forEach var="a" items="${examTypeList}">
					      <option value="${a.id}" <c:if test="${pro.state==0}">selected="selected"</c:if>>${a.name}</option>
					    </c:forEach>
<%-- 				        <option value="0" <c:if test="${pro.state==0}">selected="selected"</c:if>>未完成</option> --%>
<%-- 				        <option value="1" <c:if test="${pro.state==1}">selected="selected"</c:if>>已完成</option> --%>
				     </select>
				</div>
			</div>
			
			
			<div class="form-group">
				<label class="col-sm-2 control-label">试题内容</label>
				<div class="col-sm-10">
<%-- 					<input class="form-control" id="focusedInput" type="text" name="name" placeholder="请输入试题名称..."  value="${examType.name}"> --%>
					<textarea rows="10" style="width:100%;" class="form-control" name="name" placeholder="请输入试题内容..."></textarea>
				</div>
			</div>
<!-- 			<div class="form-group"> -->
<!-- 				<label class="col-sm-2 control-label">状态</label> -->
<!-- 				<div class="col-sm-10"> -->
<!-- 				    <input type="checkbox" value="1" name="state">可用 -->
<!-- 				</div> -->
<!-- 			</div> -->
			
			<div class="form-group">
				<div class="col-sm-10">
				</div>
				<div class="col-sm-2">
				   <div style="text-align: right;">
					<button id="btnBack" class="btn btn-primary ladda-button" data-style="expand-right" type="button">
						  <span class="ladda-label">返回列表</span>
					 </button>
					 <button id="btnReg" class="btn btn-primary ladda-button" data-style="expand-right" type="button">
						  <span class="ladda-label">提交</span>
					 </button>
				   </div>
				</div>
			</div>
		</form>
	</div>

</body>
</html>
