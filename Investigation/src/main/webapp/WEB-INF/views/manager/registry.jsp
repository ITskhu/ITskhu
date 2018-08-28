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
<!-- jquery-3.3.1.min.js -->
<script src="/resources/plugins/jQuery/jquery-3.3.1.min.js"></script>
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
					
								
				<!-- 엑셀 파일 다운 -->
				샘플 파일 다운<br>
				<a href="/manager/sampledownload">
					<button class="btn btn-primary" id="downloadDoc"
						name="downloadDoc">
						<i class="fa fa-download"></i>다운로드
					</button>
				</a>
				<br><br>
				<!-- 엑셀 파일 등록 -->
				업로드 <br>
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
								<td class="text-center"><input id="titleNm" name="titleNm"
									type="text" placeholder="예시 : 17년도 설문 문항"
									class="form-control input-md"></td>
								<td class="text-center"><input type="file" name="excelFile"
									id="excelFile"></td>
								<td class="text-center">
									<div class="btn-group btn-group-xs">
										<button class="btn btn-info" id="uploadDoc" name="uploadDoc">
											<i class="fa fa-upload"></i> 업로드
										</button>
									</div>
								</td>
								<td class="text-center">
									<div class="btn-group btn-group-xs">
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

	<!-- Bootstrap 3.3.2 JS -->
	<script src="/resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<!-- FastClick -->
	<script src='/resources/plugins/fastclick/fastclick.min.js'></script>
	<!-- AdminLTE App -->
	<script src="/resources/dist/js/app.min.js" type="text/javascript"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="/resources/dist/js/demo.js" type="text/javascript"></script>
</body>
</html>


