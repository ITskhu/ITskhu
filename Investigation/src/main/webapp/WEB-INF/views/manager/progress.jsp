<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문 진행 상황</title>
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
 <!-- DataTables -->
<link href="/resources/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />	
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
					설문 진행 상황 <small>설문의 진행 상황을 확인합니다.</small>
				</h1>
			</section>
			<!-- Main content -->
			<section class="content">
				<div class=" col-md-8">
					<div class="box box-success">
						<div class="box-header">
							<h3 class="box-title">설문 목록</h3>
						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div id="example2_wrapper"
								class="dataTables_wrapper form-inline dt-bootstrap">
								<div class="row">
									<div class="col-sm-6"></div>
									<div class="col-sm-6"></div>
								</div>
								<div class="row">
									<div class="col-sm-12">
										<table id="example2"
											class="table table-bordered table-hover dataTable" role="grid"
											aria-describedby="example2_info">
											<thead>
												<tr role="row">
													<th width="30px">순서</th>
													<th>제목</th>
													<th width="50px">시작일</th>
													<th width="50px">종료일</th>
													<th colspan="2">설문 응답 비율</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="Question" items="${QuestionList }" varStatus="status">
													<tr>
														<td><c:out value="${status.count}" /></td>
														<td><c:out value="${Question.titleNm}" /></td>
														<td><fmt:parseDate value="${Question.startDate}"
																var="postDate" pattern="yyyymmdd" /> <fmt:formatDate
																value="${postDate}" pattern="yyyy-mm-dd" />
														</td>
														<td><fmt:parseDate value="${Question.endDate}"
																var="postDate" pattern="yyyymmdd" /> <fmt:formatDate
																value="${postDate}" pattern="yyyy-mm-dd" />
														</td>
														<td>
															<c:if test="${Question.answerRatio <50}">
																<div class="progress progress-xs progress-striped active">
											                    	<div class="progress-bar progress-bar-danger"
											                    		style="width: ${Question.answerRatio}%">
											                    	</div>
											                	</div>
															</c:if>
															<c:if test="${Question.answerRatio >=50
																&& Question.answerRatio <100 }">
																<div class="progress progress-xs progress-striped active">
											                    	<div class="progress-bar progress-bar-primary"
											                    		style="width: ${Question.answerRatio}%">
											                    	</div>
											                	</div>
															</c:if>
															<c:if test="${Question.answerRatio == 100}">
																<div class="progress progress-xs progress-striped active">
											                    	<div class="progress-bar progress-bar-success"
											                    		style="width: ${Question.answerRatio}%">
											                    	</div>
											                	</div>
															</c:if>
														</td>
														<td width="30px">
															<c:if test="${Question.answerRatio <50}">
																<span class="badge bg-red">${Question.answerRatio}%</span>
															</c:if>
															<c:if test="${Question.answerRatio >=50
																&& Question.answerRatio <100 }">
																<span class="badge bg-light-blue">${Question.answerRatio}%</span>
															</c:if>
															<c:if test="${Question.answerRatio == 100}">
																<span class="badge bg-green">${Question.answerRatio}%</span>
															</c:if>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
	
							</div>
						</div>
						<!-- /.box-body -->
					</div>
				</div>
			</section>
		</div>
		<!--  Content Wrapper -->
	</div>
	<!-- ./wrapper -->
	<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
	<!-- Bootstrap 3.3.2 JS -->
	<script src="/resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<!-- DataTables -->
	<script src="/resources/plugins/datatables/jquery.dataTables.min.js"></script>
	<script src="/resources/plugins/datatables/dataTables.bootstrap.min.js"></script>
	<!-- bootbox -->
	<script src="/resources/plugins/bootbox/bootbox.min.js"></script>
	<!-- SlimScroll -->
	<script src="/resources/plugins/slimScroll/jquery.slimscroll.min.js"></script>
	<!-- FastClick -->
	<script src='/resources/plugins/fastclick/fastclick.min.js'></script>
	<!-- AdminLTE App -->
	<script src="/resources/dist/js/app.min.js" type="text/javascript"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="/resources/dist/js/demo.js" type="text/javascript"></script>
	<script>
	$(function () {
		
		
		$("#example2").DataTable({
			'paging'      : true,
		    'lengthChange': true,
		    'searching'   : false,
		    'ordering'    : false,
		    'info'        : true,
		    'autoWidth'   : false
		});
	});
	</script>
</body>


</html>


