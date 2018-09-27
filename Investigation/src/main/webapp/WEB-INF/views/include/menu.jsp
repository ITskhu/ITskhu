<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>		
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
		<header class="main-header">
			<!-- Logo -->
			<a href="/main" class="logo"> 
				<span class="logo-lg"><b>Investigation</b> System</span>
			</a>
			<!-- Header Navbar: style can be found in header.less -->
			<nav class="navbar navbar-static-top" role="navigation">
				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">
						
						<!-- User Account: style can be found in dropdown.less -->
						<li class="dropdown user user-menu">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								<img src="/resources/dist/img/testimage.png" class="user-image"
									alt="User Image" />
								<span class="hidden-xs">사용자 정보</span>
							</a>
							<ul class="dropdown-menu">
								<!-- User image -->
								<li class="user-header">
									<img src="/resources/dist/img/testimage.png" class="img-circle"
										alt="User Image" />
									<p><small>이름 : ${login.name } <br>
										부서코드 : ${login.departCode } <br>
										사원번호 : ${login.empno }<br></small>
									</p>
								</li>
								<!-- Menu Footer-->
								<li class="user-footer">
									<div class="pull-right">
										<a href="/user/logout" class="btn btn-default btn-flat">Sign out</a>
									</div>
								</li>
							</ul>
						</li>
					</ul>
				</div>
			</nav>
		</header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar">
			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">
				<!-- Sidebar user panel -->
				<div class="user-panel">
					<div class="pull-left image">
						<img src="/resources/dist/img/testimage2.png"
							class="img-circle" alt="User Image" />
					</div>
					<div class="pull-left info">
						<p>안녕?</p>
						<a href="#">
							<i class="fa fa-circle text-success"></i> xx
						</a>
					</div>
				</div>
				<ul class="sidebar-menu">
					<li class="header">메뉴</li>
					<li class="treeview">
						<a href="#"> 
							<i class="fa fa-dashboard"></i> <span>설명</span> 
						</a>
						<ul class="treeview-menu">
							<li>
								<a href="/introduce/introduce"><i class="fa fa-circle-o"></i>체계 소개</a>
							</li>
							<li>
								<a href="/introduce/how"><i class="fa fa-circle-o"></i>참여 방식</a>
							</li>
						</ul>
					</li>
					<li class="treeview">
						<a href="/state"> 
							<i class="fa fa-files-o"></i>
							<span>설문 참여</span>
						</a>
					</li>
					<li>
						<a href="/personal"> <i class="fa fa-th"></i>
							<span>설문 결과(개인)</span>
						</a>
					</li>
					<c:if test="${login.master==1}">
						<li>
							<a href="/manager/registry"> <i class="fa fa-th"></i>
								<span>설문 등록 - 관리자 메뉴</span>
							</a>
						</li>
						<li>
							<a href="/manager/making"> <i class="fa fa-th"></i>
								<span>설문 출제 - 관리자 메뉴</span>
							</a>
						</li>
						<li class="treeview">
							<a href="#"> <i
								class="fa fa-pie-chart"></i> <span>설문 결과 - 관리자 메뉴</span> <i
								class="fa fa-angle-left pull-right"></i>
							</a>
							<ul class="treeview-menu">
								<li>
									<a href="/manager/progress"><i
										class="fa fa-circle-o"></i>설문 진행 상황
									</a>
								</li>
								<li>
									<a href="/manager/statisticseq"><i
										class="fa fa-circle-o"></i>통계
									</a>
								</li>
							</ul>
						</li>
					</c:if>
					
				</ul>
			</section>
			<!-- /.sidebar -->
		</aside>