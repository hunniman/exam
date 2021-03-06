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

<script src="<%=request.getContextPath()%>/resource/js/update.js"></script>
</head>
<body>
    <input id="projectPath" type="hidden" value="<%=request.getContextPath()%>">
	<jsp:include page="../common/header.jsp" />
	<div class="jumbotron">
	
	</div>
	<div class="container">
		<form id="regForm" class="form-horizontal" role="form">
		 	<input id="userId" type="hidden" name="id" value="${user.id}">
			<div class="form-group">
				<label class="col-sm-2 control-label">员工名字</label>
				<div class="col-sm-10">
					<input class="form-control" id="focusedInput" type="text" name="name" placeholder="请输入员工名字..." value="${user.name}">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">账号</label>
				<div class="col-sm-10">
					<input class="form-control" id="focusedInput" type="text" name="account" placeholder="请输入账号..." readonly="readonly" value="${user.account}">
				</div>
			</div>
<!-- 			<div class="form-group"> -->
<!-- 				<label for="inputPassword" class="col-sm-2 control-label"> -->
<!-- 					密码</label> -->
<!-- 				<div class="col-sm-10"> -->
<!-- 					<input class="form-control" id="disabledInput" type="password" name="password" placeholder="该输入密码..." > -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<div class="form-group"> -->
<!-- 				<label for="inputPassword" class="col-sm-2 control-label"> -->
<!-- 					确认密码</label> -->
<!-- 				<div class="col-sm-10"> -->
<!-- 					<input class="form-control" id="disabledInput" type="password" name="textConfirmPwd" placeholder="该确认密码..." > -->
<!-- 				</div> -->
<!-- 			</div> -->

		<c:if test="${sessionScope.USER_SESSION!=null}">
			<c:if test="${sessionScope.USER_SESSION.position==1}">
				<div class="form-group">
					<label for="inputPassword" class="col-sm-2 control-label">
						职位</label>
					<div class="col-sm-10">
						<select class="form-control" name="position">
					        <option value="0" <c:if test="${user.position==0}">selected="selected"</c:if>>普通</option>
					        <option value="1" <c:if test="${user.position==1}">selected="selected"</c:if>>管理员</option>
					     </select>
					</div>
				</div>
			</c:if>
		</c:if>
			<div class="form-group">
				<div class="col-sm-10">
				</div>
				<div class="col-sm-2">
				   <div style="text-align: right;">
<!-- 					<button type="button" id="btnReg" class="btn btn-primary">注册</button> -->
					<c:if test="${flag==0}">
						<button id="btnBack" class="btn btn-primary ladda-button" data-style="expand-right" type="button">
							  <span class="ladda-label">返回列表</span>
						 </button>
					</c:if>
					 <button id="btnReg" class="btn btn-primary ladda-button" data-style="expand-right" type="button">
						  <span class="ladda-label">修改</span>
					 </button>
				   </div>
				</div>
			</div>
		</form>
	</div>

</body>
</html>
