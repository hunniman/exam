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
		   window.open(projectPath+"/project/addExamType", "_self");
	   });
	   $("#btnRAddExam").bind("click",function(){
		   window.open(projectPath+"/project/examAdd", "_self");
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
 				url: projectPath+'/project/getExamTypleList',
			    pagination: true,
			    pageSize: 10,
			    pageNumber:1,
			    columns: [{
			        field: 'id',
			        title: 'ID'
			    }, {
			        field: 'name',
			        title: '试卷名称'
			    },
// 			    ,{
// 			        field: 'state',
// 			        title: '状态',
// 			        width:60,
// 			        formatter:function(value, row, index){
// 			        	 if(value==1)
// 			                	return "可用";
// 			                else
// 			                	return "不可用"
// 			        }
// 			    },{
	      {
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
		            window.open(projectPath+"/project/addExamType?id="+row.id,"_self");
		            
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
		        				        url: projectPath+"/project/doDeleteExamType",
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
			
			
		   <div class="rws">
		   
		
				<div class="col-sm-12" style="text-align:right;" >
					 <button id="btnRAdd" class="btn btn-primary ladda-button" data-style="expand-right" type="button">
						  <span class="ladda-label">增加试卷类型</span>
					 </button>
					 <button id="btnRAddExam" class="btn btn-primary ladda-button" data-style="expand-right" type="button">
						  <span class="ladda-label">增加试卷</span>
					 </button>
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
