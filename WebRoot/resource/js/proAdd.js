$(function() {
		var projectPath=$("#projectPath").val(); 
	    var loading=Ladda.create(document.querySelector('#btnReg'));
	    
	    $("#btnBack").bind("click",function(){
	    	window.open(projectPath+"/project/index", "_self");
	    	
	    });
	    
	    $('#acceptDate').datetimepicker({
            pickTime: false
        }).on('dp.change dp.show', function(e) {
            $('#regForm')
                .data('bootstrapValidator')
                .updateStatus('acceptDate', 'NOT_VALIDATED', null)
                .validateField('acceptDate');
        });
	    
	    $('#estimateDate').datetimepicker({
            pickTime: false
        }).on('dp.change dp.show', function(e) {
        	 $('#regForm')
             .data('bootstrapValidator')
             .updateStatus('estimateDate', 'NOT_VALIDATED', null)
             .validateField('estimateDate');
        });
	    
	    
		$("#btnReg").bind("click",function(){
		   $('#regForm').bootstrapValidator('validate');
		   if($('#regForm').data('bootstrapValidator').isValid()){
			   loading.start();
			   $.ajax({
			        type: "post",
			        dataType: "json",
			        url: projectPath+"/project/doAdd",
			        data: $('#regForm').serialize(),
			        success: function(data) {
			        	loading.stop();
			        	if(data.valid==="success"){
			        		toastr.success('操作成功');
			        		window.open(projectPath+"/project/index", "_self");
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
	        	acceptDate: {
	                message: '输入的接单日期无效',
	                validators: {
	                    notEmpty: {
	                        message: '请输入接单日期'
	                    },
				        date: {
				        	format: 'YYYY-MM-DD'
				        }
	                },
	            },
	            client: {
	                validators: {
	                    notEmpty: {
	                        message: '请输入客户'
	                    },
	                    stringLength: {
	                        min:1,
	                        max: 100,
	                        message: '客户长度在3~100个字符长度'
	                    }
	                }
	            },
	            contacts: {
	                validators: {
	                    notEmpty: {
	                        message: '请输入联系人/电话'
	                    },
	                    stringLength: {
	                        min:1,
	                        max: 100,
	                        message: '长度在1~100个字符长度'
	                    }
	                }
	            },
	            projectName: {
	                validators: {
	                    notEmpty: {
	                        message: '请输入项目'
	                    },
	                    stringLength: {
	                        min:1,
	                        max: 200,
	                        message: '长度在1~200个字符长度'
	                    }
	                }
	            },
	            hmoney: {
	                validators: {
	                    notEmpty: {
	                        message: '请输入已收金额'
	                    },
	                    integer: {
	                        message: '请输入数字'
	                    }
	                }
	            },
	            nmoney: {
	                validators: {
	                    notEmpty: {
	                        message: '请输入未收金额'
	                    },
	                    integer: {
	                        message: '请输入数字'
	                    }
	                }
	            },
	            estimateDate: {
	                validators: {
	                    notEmpty: {
	                        message: '请输入预计交货日期'
	                    }
	                },
	            },
	            business: {
	                validators: {
	                    notEmpty: {
	                        message: '请输入业务'
	                    },
	                    stringLength: {
	                        min:1,
	                        max: 100,
	                        message: '长度在1~100个字符长度'
	                    }
	                }
	            },
	            design: {
	                validators: {
	                    notEmpty: {
	                        message: '请输入设计'
	                    },
	                    stringLength: {
	                        min:1,
	                        max: 100,
	                        message: '长度在1~100个字符长度'
	                    }
	                }
	            },
	        }
	    });
		
	});