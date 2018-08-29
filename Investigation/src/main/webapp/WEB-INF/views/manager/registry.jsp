<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문 등록</title>
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
	name='viewport'>
<!-- Bootstrap 3.3.4 -->
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />
<!-- Font Awesome Icons -->
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css" />
<!-- Ionicons -->
<link
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"
	rel="stylesheet" type="text/css" />
<!-- Theme style -->
<link href="/resources/dist/css/AdminLTE.min.css" rel="stylesheet"
	type="text/css" />
<!-- AdminLTE Skins. Choose a skin from the css/skins 
         folder instead of downloading all of them to reduce the load. -->
<link href="/resources/dist/css/skins/_all-skins.min.css"
	rel="stylesheet" type="text/css" />

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body class="skin-blue sidebar-mini">
	<div class="wrapper">

		<%@include file="../include/menu.jsp" %>
		
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					설문 등록 <small>엑셀 파일로 설문을 등록합니다</small>
				</h1>
			</section>
			<!-- Main content -->
			<section class="content">
					상단부분에는 디폴트 엑셀 파일을 등록해 놓아서 다운로드 하게 할 것임<br>
					그 아래에는 파일 등록으로 엑셀 파일 등록<br>
					(확장자, 시그니처 검사해서 엑셀 아닌거 거름)<br>
					<br>
					그 아래에는 현재 등록된 설문 목록이 나옴<br>
					설문 목록에는 설문 이름, 문항보기, 날짜가 나와야하고<br>
					체크박스로 삭제도 가능하게 해야함.<br><br>
					
								
				<!-- 엑셀 파일 다운 
				샘플 파일 다운<br>
				<a href="/manager/sampledownload">
					<button class="btn btn-primary" id="downloadDoc"
						name="downloadDoc">
						<i class="fa fa-download"></i>다운로드
					</button>
				</a>-->
				<br><br>

				<br>
				<!-- 엑셀 파일 등록 -->
				업로드 <br>
				<h3>주의! .xlsx (엑셀 통합 문서, OpenOffice Spreadsheet 문서) 또는 .xls  로 업로드 해야 합니다.</h3> <br>
				

				<form class="form_upload" id="uploadForm" name="uploadForm"
					method="post" enctype="multipart/form-data">
					<!-- 
					<input type="hidden" name="registryName" id="registryName"
						value="<c:out value='${loginUser.rank.name}'/> <c:out value='${loginUser.name}'/>" />
					<input type="hidden" name="state" id="state"
						value="<c:out value="u"/>" />
					 -->
					<table class="table table-bordered">
						<thead>
							<tr>
								<th class="text-center" width="400px">설문 제목</th>
								<th class="text-center" colspan="2" width="400px">설문 파일</th>
								<th class="text-center" width="150px">엑셀 양식</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="text-center">
									<input id="titleNm" name="titleNm" type="text" placeholder="예시 : 17년도 설문 문항"
										class="form-control input-md">
								</td>
								<td class="text-center">
									<input type="file" name="excelFile" id="excelFile">
								</td>
								<td class="text-center">
									<div class="btn-group btn-group-xs">
										<button class="btn btn-info" id="uploadDoc" name="uploadDoc">
											<i class="fa fa-upload"></i> 업로드
										</button>
									</div>
								</td>
								<td class="text-center">
									<div class="btn-group btn-group-xs">
										<button class="btn" id="downloadDoc" name="downloadDoc">
											<i class="fa fa-download"></i> 다운로드
										</button>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				
			</section>
		</div>
		<!--  Content Wrapper -->
	</div>
	<!-- ./wrapper -->
	<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
	<!-- Bootstrap 3.3.2 JS -->
	<script src="/resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<!-- FastClick -->
	<script src='/resources/plugins/fastclick/fastclick.min.js'></script>
	<!-- AdminLTE App -->
	<script src="/resources/dist/js/app.min.js" type="text/javascript"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="/resources/dist/js/demo.js" type="text/javascript"></script>


	<script type="text/javascript">
$(function () {
	
	$('#uploadDoc').bind({
		click: function(e){
			e.preventDefault();
			alert('엑셀 파일을 등록합니다.');	

			
			var form = $('form')[0];
			var formData = new FormData(form);
			$.ajax({
				url: "/manager/excelregistry",
				type: "POST",
				processData: false,
				contentType: false,
				enctype: "multipart/form-data",
				data: formData,
                beforeSend: function(){    
					//기본적인 확장자 체크
                	
                	//$('#excelFile').val() 하면 파일 경로와 이름 나옴
                	if(typeof excelFile != ''){
                		if(confirm('파일 업로드를 하시겠습니까?')){
                			return true;
						}
						else{
							return false;
						}
                	}
                },
				success:function(data){
					alert(data);
					location.reload();
				},
				error: function(){
            		alert("에러");
         	   }
			})
	
			/*
			$("#uploadForm").ajaxForm({				
                //url: "${cp}manager/question/registry/excel?${_csrf.parameterName}=${_csrf.token}",
                url: "/manager/excelregistry",
                method: "POST",
                enctype: "multipart/form-data",
                dataType: "json",
                beforeSubmit: function(){               					
                	var title_nm = $('#titleNm').val();
                    var excelFile = $('#excelFile').val();  
                    //추가적으로 확장자를 체트하는 구문 추가   	
					if(typeof title_nm != 'undefined' && title_nm != '' && excelFile != '')
					{	
						if(confirm('파일 업로드를 하시겠습니까?'))
						{
							//버튼 unable	
							$('#uploadDoc').attr("disabled", "disabled");
							upLoadingDialog.modal('show');										
							return true;
						}
						else
						{
							upLoadingDialog.modal('hide');
							return false;
						}										
					}
					else
					{	
						alertDialog("", "파일 제목 및 파일명을 입력해주세요.");	
						upLoadingDialog.modal('hide');										
						return false;
					}
                }, //end beforeSubmit
                success: function(data){
                	var state = data.success;
                	//{"success":true,"message":"정상적으로 처리되었습니다.","data":null}
                    if(state == true)
                    {
                    	bootbox.alert({
                    		//title: "알림창",
                            message: "파일 저장을 완료했습니다.",
                            callback: function(){
                            	location.href="${cp}manager/question/registry";      									
                        	}
                    	})
						.find('.modal-content')
						.css({color:'#25476A', 'font-size':'1.1em', 'font-weight':'bold'});
                        //$('#titleNm').val("");
                        //$('#excelFile').replaceWith($('#excelFile').clone(true));
                        //location.href="${cp}manager/question/registry";                          			
                    }else
                    {
                    	$('#uploadDoc').removeAttr("disabled");
                        upLoadingDialog.modal('hide');
                        alertDialog("", "파일 저장을 실패했습니다. 파일확장자를 확인해주세요.");
                    }
				},
                error: function(){
                    upLoadingDialog.modal('hide');
                    $('#uploadDoc').removeAttr("disabled");
                    alertDialog("", "파일 전송을 실패했습니다.");
				}
			});
			$("#uploadForm").submit();	*/		
			
		}//end of click event
	}); //end $('#uploadDoc').bind
	
	
	//샘플 파일 다운로드
	$('#downloadDoc').bind({
		click: function(e){
			alert("샘플 파일을 다운로드합니다.")
			e.preventDefault();
			window.location.assign('/manager/sampledownload');
		}
	});	
	
	/*
	$('#deleteDoc').bind({
		click: function(e){
			e.preventDefault();
			var chkList = [];

			$("input[class='cvchkbox']:checked").each(function(i){
				chkList.push($(this).attr('id'));
			});

			if(chkList.length > 0){
				//삭제 재확인
				bootbox.confirm({
					message: "삭제 하시겠습니까?",
					callback: function(result){
						if(result){							
							var sendData = {"cvRemoveList" : chkList};
							var deleteDialog = bootbox.dialog({
								show: false,
        						title: '입력 전송창',        						
    	        				message: '<p class="text-center"> 입력값을 전송 중입니다. 잠시만 기다려주세요. </p>',
    	        				closeButton: false
    	   					 });   	   					 	
							$.ajax({
				    			url: "delete",
				    			method: "POST",
				    			data: sendData,
				    			beforeSend: function(xhr){
				    				//데이터를 전송하기 전에 헤더에 csrf값을 설정한다			
				    				xhr.setRequestHeader('${_csrf.headerName}','${_csrf.token}');				    				
				    				deleteDialog.modal('show');
				    			},
				    			dataType: "json",
				    			//contentType: "application/json;charset=UTF-8",
				    			complete: function(){
				    				deleteDialog.modal('hide');
				    			},
				    			success: function(data){ 
				    				var state = data.success;
				    				if(state == true){
                        				bootbox.alert({
                            					//title: "알림창",
                            					message: "파일 삭제를 완료했습니다.",
                            					callback: function(){
                        									location.href="${cp}manager/question/registry";      									
                        								}
                            				})
											.find('.modal-content')
											.css({color:'#25476A', 'font-size':'1.1em', 'font-weight':'bold'});                        			
                        			}else{
                        				alertDialog("", "파일 삭제를 실패했습니다. 관리자에게 문의해주세요.");
                        			}
				    			},
				    			error: function(xhr, status, error){
				    				alertDialog("", "명령어 전송을 실패했습니다.");
				    			}
							});//end of ajax
				    			
						}								
					}
				}).find('.modal-content').css({color:'#f00', 'font-size':'1.1em', 'font-weight':'bold'});				
				
			}else{
				alertDialog("", "삭제할 항목을 선택해주세요.");
			}
		}
	});	
	*/
});

</script>
</body>


</html>


