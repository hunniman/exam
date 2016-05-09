$(function() {
		var projectPath=$("#projectPath").val(); 
	    var loading=Ladda.create(document.querySelector('#btnReg'));
	    
	    $("#btnBack").bind("click",function(){
	    	window.open(projectPath+"/project/examTypeList", "_self");
	    	
	    });
	    
	    
		$("#btnReg").bind("click",function(){
		   $('#regForm').bootstrapValidator('validate');
		   if($('#regForm').data('bootstrapValidator').isValid()){
			   loading.start();
			   $.ajax({
			        type: "post",
			        dataType: "json",
			        url: projectPath+"/project/doUpdateExamType",
			        data: $('#regForm').serialize(),
			        success: function(data) {
			        	loading.stop();
			        	if(data.valid==="success"){
			        		toastr.success('操作成功');
			        		window.open(projectPath+"/project/examTypeList", "_self");
			        	}else{
			        		toastr.error('操作失败');
			        	}
			        },
			        error: function(err) {
			        	loading.stop();
			        	toastr.error('操作失败');
			        }
			    });
		   }else{
			   loading.stop();
		   }
		});
		
		$('.form-horizontal').bootstrapValidator({
	        message: 'This value is not valid',
	        feedbackIcons: {
	            valid: 'glyphicon glyphicon-ok',
	            invalid: 'glyphicon glyphicon-remove',
	            validating: 'glyphicon glyphicon-refresh'
	        },
	        fields: {
	        	name: {
	                validators: {
	                    notEmpty: {
	                        message: '请输入试题类型'
	                    },
	                    stringLength: {
	                        min:3,
	                        max: 100,
	                        message: '试题类型长度在3~100个字符长度'
	                    }
	                }
	            }
	        }
	    });
		
	});