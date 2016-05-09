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


<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/bootstrapvalidator/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css">
<script src="<%=request.getContextPath()%>/resource/bootstrapvalidator/bootstrap-datetimepicker/js/moment.min.js"></script>
<script src="<%=request.getContextPath()%>/resource/bootstrapvalidator/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>

<!-- <script src="../resource/js/login.js"></script> -->
<script type="text/javascript">
   $(function(){
	   var projectPath=$("#projectPath").val(); 
	   
	   var $table = $('#table');
	   
	   $("#btnRAdd").bind("click",function(){
		   window.open(projectPath+"/project/add", "_self");
	   });
	   
	   $("#btnPrint").bind("click",function(){
		   
		   var d=$table.bootstrapTable("getOptions");
		   var num=d.pageNumber;
		   var size=d.pageSize;
		   var userId=$("#ddlUser  option:selected").val();
		   if(userId===undefined){
			   userId=0;
		   }
		   var url=projectPath+"/project/printPage?state="+$("#ddlState  option:selected").val()+"&startDate="+$("#startDateVal").val()+"&endDate="+$("#endDateVal").val()+"&uid="+userId+"&pageNum="+num+"&pageSize="+size;
		   window.open(url, "_blank");
	   });
	   
	   $('#startDate').datetimepicker({
           pickTime: false
       });
	    
	   
	   $('#endDate').datetimepicker({
           pickTime: false
       });
	  
	  
	   $("#btnFind").bind("click",function(){
		   $table.bootstrapTable('destroy');
// 		   $table.bootstrapTable('refresh');
		   initTable();
	   });
	   
	   var dele=function(id){
		   $.ajax({
		        type: "post",
		        dataType: "json",
		        url: projectPath+"/user/deleteUser",
		        data: {id:id},
		        success: function(data) {
		           if(data.valid==="success"){
		        		toastr.success('删除成功');
		        		
		        	}else{
		        		toastr.error('删除失败');
		        	}
		        },
		        error: function(err) {
		        	toastr.error('删除用户数据失败');
		        }
		    });  
	   };
	   
	   var initTable=function(d){
		   var userId=$("#ddlUser  option:selected").val();
		   if(userId===undefined){
			   userId=0;
		   }
		   $('#table').bootstrapTable({
// 			    data:d.rows,
 				url: projectPath+'/project/getList?state='+$("#ddlState  option:selected").val()+"&startDate="+$("#startDateVal").val()+"&endDate="+$("#endDateVal").val()+"&uid="+userId,
			    pagination: true,
			    pageSize: 10,
			    pageNumber:1,
			    columns: [{
			        field: 'id',
			        title: 'ID'
			    }, {
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
			    }, {
			        field: 'createTime',
			        title: '建单时间'
			    }, {
			        field: 'updateTime',
			        title: '修改时间',
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
			    },{
                    field: 'operate',
                    title: '操作',
                    align: 'center',
                    events: operateEvents,
                    width:50,
                    formatter: operateFormatter
                }]
			});
	   };
	   
	   function operateFormatter(value, row, index) {
	        return [
	            '<a class="like" href="javascript:void(0)" title="Like">',
	            '<i class="glyphicon glyphicon-edit"></i>',
	            '</a>  ',
	            '<a class="remove" href="javascript:void(0)" title="Remove">',
	            '<i class="glyphicon glyphicon-remove"></i>',
	            '</a>'
	        ].join('');
	   };
	   
	   window.operateEvents = {
		        'click .like': function (e, value, row, index) {
// 		        	alert(row.id);
// 		            alert('You click like action, row: ' + JSON.stringify(row));
		            window.open(projectPath+"/project/add?id="+row.id,"_self");
		            
		        },
		        'click .remove': function (e, value, row, index) {
		        	
		        	Modal.confirm(
		        			  {
		        			    msg: "确认删除？"
		        			  })
		        			  .on( function (e) {
		        				  $.ajax({
		        				        type: "post",
		        				        dataType: "json",
		        				        url: projectPath+"/project/delete",
		        				        data: {id:row.id},
		        				        success: function(data) {
		        				           if(data.valid==="success"){
		        				        		toastr.success('删除成功');
		        				        		 $table.bootstrapTable('remove', {
		        						                field: 'id',
		        						                values: [row.id]
		        						            });
		        				        	}else{
		        				        		toastr.error('删除失败');
		        				        	}
		        				        },
		        				        error: function(err) {
		        				        	toastr.error('删除数据失败');
		        				        }
		        				    });  
		        			});
		        	
		           
		        }
	   };
	   
// 	   getData();
	   
	 initTable();
	   
// 	   $('#table').bootstrapTable({
// 	        data: data
// 	    });
// 	   $('#table').bootstrapTable({
// 		    url: projectPath+'/user/getUserList',
// 		    columns: [{
// 		        field: 'id',
// 		        title: 'Item ID'
// 		    }, {
// 		        field: 'name',
// 		        title: 'Item Name'
// 		    }, {
// 		        field: 'createTime',
// 		        title: 'Item Price'
// 		    }, ]
// 		});
   });
</script>
</head>
<body>
	<input id="projectPath" type="hidden" value="<%=request.getContextPath()%>">
	<jsp:include page="../common/header.jsp" />
	<div class="jumbotron"></div>
	<div class="container" style="width:90%;">
			
			
		   <div class="rows">
		   		 <form id="regForm" class="form-horizontal" role="form">
		   		 	 <c:if test="${sessionScope.USER_SESSION.position==0}">
						      <div class="col-sm-3">
												<div class="form-group">
												      <label for="firstname" class="col-sm-3 control-label">开始日期</label>
												      <div class="col-sm-9">
													         <div class="input-group date" id="startDate" data-date-format="YYYY-MM-DD">
												                <input type="text" class="form-control" id="startDateVal">
												                <span class="input-group-addon">
												                    <span class="glyphicon-calendar glyphicon"></span>
												                </span>
												            </div>
												      </div>
												   </div>
								</div>
							
							  <div class="col-sm-3">
											<div class="form-group">
											      <label for="firstname" class="col-sm-3 control-label">结束日期</label>
											      <div class="col-sm-9">
											          <div class="input-group date" id="endDate" data-date-format="YYYY-MM-DD">
											                <input type="text" class="form-control" id="endDateVal">
											                <span class="input-group-addon">
											                    <span class="glyphicon-calendar glyphicon"></span>
											                </span>
											            </div>
											      </div>
											   </div>
							</div>
							
							 <div class="col-sm-3">
											<div class="form-group">
											      <label for="firstname" class="col-sm-4 control-label">是否完成</label>
											      <div class="col-sm-8">
											         <select id="ddlState" class="form-control">
											            <option value="-1"></option>
											            <option value="0">未完成</option>
											            <option value="1">已完成</option>
											         </select>
											      </div>
											   </div>
							</div>
							 </c:if>



							 <c:if test="${sessionScope.USER_SESSION.position==1}">
										<div class="col-sm-3">
														<div class="form-group">
														      <label for="firstname" class="col-sm-3 control-label">开始</label>
														      <div class="col-sm-9">
															         <div class="input-group date" id="startDate" data-date-format="YYYY-MM-DD">
														                <input type="text" class="form-control" id="startDateVal">
														                <span class="input-group-addon">
														                    <span class="glyphicon-calendar glyphicon"></span>
														                </span>
														            </div>
														      </div>
														   </div>
										</div>
									
									  <div class="col-sm-3">
													<div class="form-group">
													      <label for="firstname" class="col-sm-3 control-label">结束</label>
													      <div class="col-sm-9">
													          <div class="input-group date" id="endDate" data-date-format="YYYY-MM-DD">
													                <input type="text" class="form-control" id="endDateVal">
													                <span class="input-group-addon">
													                    <span class="glyphicon-calendar glyphicon"></span>
													                </span>
													            </div>
													      </div>
													   </div>
									</div>
									
									 <div class="col-sm-2">
													<div class="form-group">
													      <label for="firstname" class="col-sm-4 control-label">状态</label>
													      <div class="col-sm-8">
													         <select id="ddlState" class="form-control">
													            <option value="-1"></option>
													            <option value="0">未完成</option>
													            <option value="1">已完成</option>
													         </select>
													      </div>
													   </div>
									</div>
									
									<div class="col-sm-2">
													<div class="form-group">
													      <label for="firstname" class="col-sm-4 control-label">用户</label>
													      <div class="col-sm-8">
													         <select id="ddlUser" class="form-control">
													            <option value="-1"></option>
													            <c:forEach var="u" items="${users}">
														            <option value="${u.id}">${u.name }</option>
													            </c:forEach>
													         </select>
													      </div>
													   </div>
									</div>
							 </c:if>
					</form>
				
				<div class="col-sm-2">
					 <button id="btnFind" class="btn btn-primary ladda-button" data-style="expand-right" type="button">
						  <span class="ladda-label">筛选</span>
					 </button>
					 <button id="btnRAdd" class="btn btn-primary ladda-button" data-style="expand-right" type="button">
						  <span class="ladda-label">增加业务</span>
					 </button>
					 
					  <button id="btnPrint" class="btn btn-primary ladda-button" data-style="expand-right" type="button">
						  <span class="ladda-label">Excel</span>
					 </button>
<%-- 						<a href="<%=request.getContextPath()%>/project/add">增加业务</a> --%>
				</div>
		   </div>
		  <table id="table" data-pagination="true" data-id-field="id" data-side-pagination="server" >
		  </table>
		  
		  
		  
		  
		  
		  
    <!-- system modal start -->
    <div id="ycf-alert" class="modal">
      <div class="modal-dialog modal-sm">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
            <h5 class="modal-title"><i class="fa fa-exclamation-circle"></i> [Title]</h5>
          </div>
          <div class="modal-body small">
            <p>[Message]</p>
          </div>
          <div class="modal-footer" >
            <button type="button" class="btn btn-primary ok" data-dismiss="modal">[BtnOk]</button>
            <button type="button" class="btn btn-default cancel" data-dismiss="modal">[BtnCancel]</button>
          </div>
        </div>
      </div>
    </div>
  <!-- system modal end -->
	</div>
</body>
</html>
