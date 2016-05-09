$(function() {
		var projectPath=$("#projectPath").val(); 
	    var loading=Ladda.create(document.querySelector('#btnReg'));
	    var userId=$("#userId").val();
	    if(userId===""){
	    	userId=0;
	    }
	    $("#btnBack").bind("click",function(){
	    	window.open(projectPath+"/user/list", "_self");
	    	
	    });
		$("#btnReg").bind("click",function(){
		   $('#regForm').bootstrapValidator('validate');
		   if($('#regForm').data('bootstrapValidator').isValid()){
			   loading.start();
			   $.ajax({
			        type: "post",
			        dataType: "json",
			        url: projectPath+"/user/doUpdate",
			        data: $('#regForm').serialize(),
			        success: function(data) {
			        	loading.stop();
			        	if(data.valid==="success"){
			        		toastr.success('修改成功');
			        	}else{
			        		toastr.error('修改失败');
			        	}
			        },
			        error: function(err) {
			        	loading.stop();
			        	toastr.error('修改失败');
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
	        	textPwd: {
	                message: '输入的密码无效',
	                validators: {
	                    notEmpty: {
	                        message: '请输入密码'
	                    },
	                    stringLength: {
	                        min: 6,
	                        max: 30,
	                        message: '密码长度在6~30个字符长度'
	                    },
	                    regexp: {
	                        regexp: /^[a-zA-Z0-9_]+$/,
	                        message: '密码不能包含特殊字符'
	                    }
	                }
	            },
	            textConfirmPwd: {
	                message: '输入的密码无效',
	                validators: {
	                    notEmpty: {
	                        message: '请输入密码'
	                    },
	                    stringLength: {
	                        min: 6,
	                        max: 30,
	                        message: '密码长度在6~30个字符长度'
	                    },
	                    identical: {
	                        field: 'textPwd',
	                        message: '两次输入的密码不相同'
	                    },
	                    regexp: {
	                        regexp: /^[a-zA-Z0-9_]+$/,
	                        message: '密码不能包含特殊字符'
	                    }
	                }
	            },
	            account: {
	                validators: {
	                    notEmpty: {
	                        message: '请输入账号'
	                    },
	                    stringLength: {
	                        min:3,
	                        max: 30,
	                        message: '账号长度在6~30个字符长度'
	                    },
	                    remote: {
	                        type: 'POST',
	                        url: projectPath+"/user/checkDunplicateAccount?userId="+userId,
	                        message: '已经存在此账号',
	                        delay: 500
	                    }
	                }
	            },
	            name: {
	                validators: {
	                    notEmpty: {
	                        message: '请输入员工名字'
	                    },
	                    stringLength: {
	                        min:3,
	                        max: 30,
	                        message: '员工名字长度在6~30个字符长度'
	                    },
	                    remote: {
	                        type: 'POST',
	                        url: projectPath+"/user/checkDunplicateName?userId="+userId,
	                        message: '已经存在此员工名字',
	                        delay: 500
	                    }
	                }
	            }
	        }
	    });
		
	});