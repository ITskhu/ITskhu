<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문 참여</title>
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

<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>

<body class="skin-blue sidebar-mini">
	<div class="wrapper">
		<%@include file="../include/menu.jsp"%>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					설문 참여 <small>참여 가능한 설문을 보여줍니다.</small>
				</h1>
			</section>
			<section class="content">
				<div class="row">
					<div class="col-lg-3 col-xs-6">
						<!-- small box -->
						<div class="small-box bg-aqua">
							<div class="inner">
								<h4>참여 가능 설문</h4>
								
								<c:forEach var="userState" items="${stateY}" varStatus="status">
									<div class="row">
										<div class="col-md-4">${userState.titleNm }</div>
										<div class="col-md-3 col-md-offset-3">
											<!-- <a href="/state/join"> -->
											<a href="#" onclick="goJoin('<c:out value='${userState.version}'/>', '<c:out value='${userState.stateSeq}'/>')" >	
												참여하기	
											</a>
										</div>
									</div>
								</c:forEach>
								
								
							</div>
						</div>
					</div>

					<div class="col-lg-3 col-xs-6">
						<!-- small box -->
						<div class="small-box bg-yellow">
							<div class="inner">
								<h4>종료된 설문</h4>
								<c:forEach var="userState" items="${stateN}" varStatus="status">
									<div class="row">
										<div class="col-md-4">${userState.titleNm }</div>
									</div>
								</c:forEach>
							</div>
						

						</div>
					</div>
					
				</div>
			</section>
		</div>
		<!--  Content Wrapper -->
	</div>
	<!-- ./wrapper -->


	<!-- Bootstrap 3.3.2 JS -->
	<script src="/resources/bootstrap/js/bootstrap.min.js"
		type="text/javascript"></script>
	<!-- FastClick -->
	<script src='/resources/plugins/fastclick/fastclick.min.js'></script>
	<!-- AdminLTE App -->
	<script src="/resources/dist/js/app.min.js" type="text/javascript"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="/resources/dist/js/demo.js" type="text/javascript"></script>
	<script type="text/javascript">
function goJoin(version_, stateSeq_){
	//alert(version_);
	//alert(stateSeq_);
	var $form = $('<form></form>');
	$form.attr('action', "/state/join");
	$form.attr('method', 'post');
	$form.appendTo('body');
	var version = $("<input type='hidden' value="+version_+" name='version'>");
	var stateSeq = $("<input type='hidden' value="+stateSeq_+" name='stateSeq'>");
	$form.append(version);
	$form.append(stateSeq);
	$form.submit();
};
	/*
	function goJoin(cvSeq, userSn ,inputDt){
		alert(cvSeq +":"+ userSn +":"+ inputDt);
		if(inputDt == "" || inputDt == null){
			//실시
			//alert("실시로 가자");
			//personnel/autodiagnosis
			var $form = $('<form></form>');
			$form.attr('action', "${cp}personnel/autodiagnosis");
			$form.attr('method', 'post');
			$form.appendTo('body');

			var csval = "${_csrf.token}";
			var csname = "${_csrf.parameterName}";

			var cvSeq = $("<input type='hidden' value="+cvSeq+" name='cvSeq'>");
			var userSn = $("<input type='hidden' value="+userSn+" name='userSn'>");
			var csrf = $("<input type='hidden' value="+csval+" name="+csname+">");
			$form.append(cvSeq);
			$form.append(userSn);
			$form.append(csrf);
			$form.submit();
			
		}else{
			//결과값 보기
			//confirm
			bootbox.confirm({
					message: "설문 제출은 완료되었습니다. 설문 결과를 보시겠습니까?",
					callback: function(result){
						if(result){
							goDiagnosisResult(cvSeq, userSn);		
						}else{
							return true;
						}				
					}
			}).find('.modal-content').css({color:'#25476A', 'font-size':'1.1em', 'font-weight':'bold'});
		}
	};
	*/
	</script>
</body>
</html>


