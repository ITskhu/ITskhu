<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문 결과(개인)</title>
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
					참여 완료한 설문 <small>참여 완료한 설문을 보여줍니다.</small>
				</h1>
			</section>
			<section class="content">
				<div class="row">
					<div class="col-md-8">
						<div class="box">
							<div class="box-header">
								<h3 class="box-title">참여 완료 목록</h3>
	
								
							</div>
							<!-- /.box-header -->
							<div class="box-body table-responsive no-padding">
								<table class="table table-hover">
									<tbody>
										<tr>
											<th>순서</th>
											<th>제목</th>
											<th>설명</th>
											<th>마감일</th>
											<th>결과</th>
										</tr>
									<c:forEach var="Question" items="${QuestionList}" varStatus="status">
										<tr>
											<td>${status.count }</td>
											<td>${Question.titleNm }</td>
											<td>${Question.explanation }</td>
											<td>${Question.endDate }</td>
											<td>
												<button type="button" id="id_${Question.stateSeq}"
													class="btn btn-block btn-warning btn-sm"
													onclick="goResult('<c:out value='${Question.stateSeq}'/>', '<c:out value='${Question.version}'/>')">결과보기
												</button>
											</td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
							</div>
							<!-- /.box-body -->
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
function goResult(stateSeq_,version_){
	var $form = $('<form></form>');
	$form.attr('action', "/personal/result");
	$form.attr('method', 'post');
	$form.appendTo('body');
	var version = $("<input type='hidden' value="+version_+" name='version'>");
	var stateSeq = $("<input type='hidden' value="+stateSeq_+" name='stateSeq'>");
	$form.append(version);
	$form.append(stateSeq);
	$form.submit();
};
	</script>
</body>
</html>


