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

<script src="../resource/js/proAdd.js"></script>
</head>
<body>
    <input id="projectPath" type="hidden" value="<%=request.getContextPath()%>">
	<jsp:include page="../common/header.jsp" />
	<div class="jumbotron">
	
	</div>
	<div class="container">
		<form id="regForm" class="form-horizontal" role="form">
			<input id="id" type="hidden" name="id" value="${pro.id}">
			<div class="form-group">
				<label class="col-sm-2 control-label">接单日期</label>
				<div class="col-sm-10">
<!-- 					<input class="form-control" id="focusedInput" type="text" name=acceptDate > -->
<!-- 					<div class="input-group date" id="dobPicker" data-date-format="YYYY/DD/MM"> -->
<!-- 	                <input type="text" class="form-control" name="acceptDate" placeholder="请输入员接单日期..."/> -->
<!-- 	                <span class="input-group-addon"> -->
<!-- 	                    <span class="glyphicon-calendar glyphicon"></span> -->
<!-- 	                </span> -->
	                 <div class="input-group date" id="acceptDate" data-date-format="YYYY-MM-DD">
		                <input type="text" class="form-control" name="acceptDate" placeholder="请输入员接单日期..."/ value="${pro.acceptDate}">
		                <span class="input-group-addon">
		                    <span class="glyphicon-calendar glyphicon"></span>
		                </span>
		            </div>
				</div>
				
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">客户</label>
				<div class="col-sm-10">
					<input class="form-control" id="focusedInput" type="text" name="client" placeholder="请输入客户..." value="${pro.client}">
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword" class="col-sm-2 control-label">
					联系人/电话</label>
				<div class="col-sm-10">
					<input class="form-control" id="disabledInput" type="text" name="contacts" placeholder="该输入联系人/电话..."  value="${pro.contacts}">
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword" class="col-sm-2 control-label">
					项目</label>
				<div class="col-sm-10">
					<input class="form-control" id="disabledInput" type="text" name="projectName" placeholder="请输入项目..." value="${pro.projectName}">
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword" class="col-sm-2 control-label">
					已收金额</label>
				<div class="col-sm-10">
<%-- 					<input class="form-control" id="disabledInput" type="text" name="hmoney" placeholder="请输入已收金额..." value="${pro.hmoney}"> --%>
					<div class="input-group">
				         <span class="input-group-addon">￥</span>
				         <input type="text" class="form-control" name="hmoney" placeholder="请输入已收金额..." value="${pro.hmoney}">
				         <span class="input-group-addon">.00</span>
				      </div>
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword" class="col-sm-2 control-label">
					未收金额</label>
				<div class="col-sm-10">
					<div class="input-group">
				         <span class="input-group-addon">￥</span>
				         <input type="text" class="form-control" name="nmoney" placeholder="请输入未收金额..." value="${pro.nmoney}">
				         <span class="input-group-addon">.00</span>
				      </div>
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword" class="col-sm-2 control-label">
					预计交货日期</label>
				<div class="col-sm-10">
					<div class="input-group date" id="estimateDate" data-date-format="YYYY-MM-DD">
		                <input type="text" class="form-control" name="estimateDate" placeholder="请输入预计交货日期..." value="${pro.estimateDate}">
		                <span class="input-group-addon">
		                    <span class="glyphicon-calendar glyphicon"></span>
		                </span>
		            </div>
		            
				</div>
			</div>
			
			<div class="form-group">
				<label for="inputPassword" class="col-sm-2 control-label">
					业务</label>
				<div class="col-sm-10">
					<input class="form-control" id="disabledInput" type="text" name="business" placeholder="请输入业务人员..." value="${pro.business}">
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword" class="col-sm-2 control-label">
					设计</label>
				<div class="col-sm-10">
					<input class="form-control" id="disabledInput" type="text" name="design" placeholder="请输入设计者..." value="${pro.design}">
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword" class="col-sm-2 control-label">
					备注</label>
				<div class="col-sm-10">
					<input class="form-control" id="disabledInput" type="text" name="description" placeholder="请输入备注..." value="${pro.description}">
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword" class="col-sm-2 control-label">
					完成状态</label>
				<div class="col-sm-10">
					<select class="form-control" name="state">
				        <option value="0" <c:if test="${pro.state==0}">selected="selected"</c:if>>未完成</option>
				        <option value="1" <c:if test="${pro.state==1}">selected="selected"</c:if>>已完成</option>
				     </select>
				</div>
			</div>
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
