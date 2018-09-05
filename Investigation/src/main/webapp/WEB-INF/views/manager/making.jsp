<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문 출제</title>
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
					설문 출제 <small>설문을 출제합니다.</small>
				</h1>
<<<<<<< HEAD
				아래 조직도는 임시로 출력한 것이라서 코드가 개판임.<br>
				
				<ul>
				<c:forEach var="levelOne" items="${LevelOne }" varStatus="status">
					<li>
						<label>
							<input type="checkbox" value="${levelOne.name}">
						</label>
						<c:out value="${levelOne.name}"/>
						<ul>
							<c:forEach var="levelTwo" items="${LevelTwo }" varStatus="status">
								<c:if test="${levelOne.levelCode == levelTwo.highDepartCode }">
									<li>
										<label>
											<input type="checkbox" value="${levelTwo.name}">
										</label>
										<c:out value="${levelTwo.name}"/>
										<ul>
											<c:forEach var="levelThree" items="${LevelThree }" varStatus="status">
												<c:if test="${levelTwo.levelCode == levelThree.highDepartCode }">
													<li>
														<label>
															<input type="checkbox" value="${levelThree.name}">
														</label>
														<c:out value="${levelThree.name}"/>
													</li>
												</c:if>
											</c:forEach>
										</ul>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</li>
				</c:forEach>
				</ul>
			</section>
			<!-- Main content -->
			<section class="content">
					
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


=======
				
				아래 조직도는 임시로 출력한 것이라서 코드가 개판임.<br>
				<c:forEach var="Department" items="${DepartList }" varStatus="status">
					${Department.name}<br>	
				</c:forEach>
				<!-- 
<ul>
<c:forEach var="Department" items="${DepartList }" varStatus="status">
	<c:if test="${Department.departLevel == 1}">
		<li>${Department.name}
	</c:if>
	<c:if test="${ (Department.departLevel == 2) &&  (Department.departCode == 'A00B00')}">
			<ul>
				<li>
					${Department.name}S
				</li>	
			</ul>
	</c:if>
	<c:if test="${ (Department.departLevel == 2) }">
			<ul>
				<li>
					${Department.name}
			
	</c:if>
	<c:if test="${Department.departLevel == 3}">
					<ul>
						<li>
							${Department.name}
						</li>
					</ul>
				</li>
			</ul>
		</li>
	</c:if>
</c:forEach>
</ul>  -->
				
				<ul>
					<li>1
						<ul>
							<li>1-1</li>
							<li>1-2</li>
						</ul>
					</li>
					<li>2</li>
					<li>3</li>
				</ul>
			</section>
			<!-- Main content -->
			<section class="content">
					
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


	<script type="text/javascript">
>>>>>>> branch 'master' of https://github.com/ITskhu/ITskhu.git

</body>


</html>


