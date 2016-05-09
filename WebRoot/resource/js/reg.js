$(function() {
		var projectPath=$("#projectPath").val(); 
	    var loading=Ladda.create(document.querySelector('#btnReg'));
		$("#btnReg").bind("click",function(){
		   $('#regForm').bootstrapValidator('validate');
		   if($('#regForm').data('bootstrapValidator').isValid()){
			   loading.start();
			   $.ajax({
			        type: "post",
			        dataType: "json",
			        url: projectPath+"/user/doSignUp",
			        data: $('#regForm').serialize(),
			        success: function(data) {
			        	loading.stop();
			        	if(data.valid==="success"){
			        		toastr.success('注册成功');
			        		window.open(projectPath+"/user/index", "_self");
			        	}else{
			        		toastr.error('注册失败');
			        	}
			        },
			        error: function(err) {
			        	loading.stop();
			        	toastr.error('注册失败');
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
	        	password: {
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
	                        message: '账号长度在3~30个字符长度'
	                    },
	                    remote: {
	                        type: 'POST',
	                        url: projectPath+"/user/checkDunplicateAccount?userId=0",
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
	                        min:1,
	                        max: 30,
	                        message: '员工名字长度在1~30个字符长度'
	                    },
	                    remote: {
	                        type: 'POST',
	                        url: projectPath+"/user/checkDunplicateName?userId=0",
	                        message: '已经存在此员工名字',
	                        delay: 500
	                    }
	                }
	            }
	        }
	    });
		
	});