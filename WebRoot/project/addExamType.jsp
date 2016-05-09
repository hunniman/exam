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

<script src="../resource/js/examType.js"></script>
</head>
<body>
    <input id="projectPath" type="hidden" value="<%=request.getContextPath()%>">
	<jsp:include page="../common/header.jsp" />
	<div class="jumbotron">
	
	</div>
	<div class="container">
		<form id="regForm" class="form-horizontal" role="form">
			<input id="id" type="hidden" name="id" value="${examType.id}">
			<div class="form-group">
				<label class="col-sm-2 control-label">试题名称</label>
				<div class="col-sm-10">
					<input class="form-control" id="focusedInput" type="text" name="name" placeholder="请输入试题名称..."  value="${examType.name}">
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
