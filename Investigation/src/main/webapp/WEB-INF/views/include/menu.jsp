<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>		
		<header class="main-header">
			<!-- Logo -->
			<a href="/" class="logo"> 
				<span class="logo-lg"><b>Investigation</b> System</span>
			</a>
			<!-- Header Navbar: style can be found in header.less -->
			<nav class="navbar navbar-static-top" role="navigation">
				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">
						<!-- Messages: style can be found in dropdown.less-->
						<li class="dropdown messages-menu">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								<i class="fa fa-envelope-o"></i>
								<span class="label label-success">4</span>
							</a>
						</li>
						<!-- Tasks: style can be found in dropdown.less -->
						<li class="dropdown tasks-menu">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								<i class="fa fa-flag-o"></i> 
								<span class="label label-danger"></span>
							</a>
							<ul class="dropdown-menu">
								<li class="header">진행률</li>
								<li>
									<!-- inner menu: contains the actual data -->
									<ul class="menu">
										<li>
											<!-- Task item -->
											<a href="#">
												<h3>
													설문1 <small class="pull-right">20%</small>
												</h3>
												<div class="progress xs">
													<div class="progress-bar progress-bar-aqua"
														style="width: 20%" role="progressbar" aria-valuenow="20"
														aria-valuemin="0" aria-valuemax="100">
														<span class="sr-only">20% Complete</span>
													</div>
												</div>
											</a>
										</li>
										<!-- end task item -->
										<li>
											<!-- Task item -->
											<a href="#">
												<h3>
													설문2 <small class="pull-right">40%</small>
												</h3>
												<div class="progress xs">
													<div class="progress-bar progress-bar-green"
														style="width: 40%" role="progressbar" aria-valuenow="20"
														aria-valuemin="0" aria-valuemax="100">
														<span class="sr-only">40% Complete</span>
													</div>
												</div>
											</a>
										</li>
										<!-- end task item -->
										<li>
											<!-- Task item --> 
											<a href="#">
												<h3>
													설문3 <small class="pull-right">60%</small>
												</h3>
												<div class="progress xs">
													<div class="progress-bar progress-bar-red"
														style="width: 60%" role="progressbar" aria-valuenow="20"
														aria-valuemin="0" aria-valuemax="100">
														<span class="sr-only">60% Complete</span>
													</div>
												</div>
											</a>
										</li>
										<!-- end task item -->
										<li>
											<!-- Task item --> 
											<a href="#">
												<h3>
													설문4 <small class="pull-right">80%</small>
												</h3>
												<div class="progress xs">
													<div class="progress-bar progress-bar-yellow"
														style="width: 80%" role="progressbar" aria-valuenow="20"
														aria-valuemin="0" aria-valuemax="100">
														<span class="sr-only">80% Complete</span>
													</div>
												</div>
											</a>
										</li>
										<!-- end task item -->
									</ul>
								</li>
								<li class="footer"><a href="#">View all tasks</a></li>
							</ul>
						</li>
						<!-- User Account: style can be found in dropdown.less -->
						<li class="dropdown user user-menu">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								<img src="/resources/dist/img/testimage.jpg" class="user-image"
									alt="User Image" />
								<span class="hidden-xs">사용자 정보</span>
							</a>
							<ul class="dropdown-menu">
								<!-- User image -->
								<li class="user-header">
									<img src="/resources/dist/img/testimage.jpg" class="img-circle"
										alt="User Image" />
									<p><small>이름 : 전경준 <br>
										소속 : aa - bb - cc <br>
										사원번호 - 124221 <br></small>
									</p>
								</li>
								<!-- Menu Footer-->
								<li class="user-footer">
									<div class="pull-right">
										<a href="#" class="btn btn-default btn-flat">Sign out</a>
									</div>
								</li>
							</ul>
						</li>
						<!-- Control Sidebar Toggle Button -->
						<li>
							<a href="#" data-toggle="control-sidebar"><i
								class="fa fa-gears"></i>
							</a>
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
						<img src="/resources/dist/img/testimage2.jpg"
							class="img-circle" alt="User Image" />
					</div>
					<div class="pull-left info">
						<p>안녕?</p>
						<a href="#">
							<i class="fa fa-circle text-success"></i> xx
						</a>
					</div>
				</div>
				<!-- search form -->
				<!-- 
				<form action="#" method="get" class="sidebar-form">
					<div class="input-group">
						<input type="text" name="q" class="form-control" placeholder="Search..." /> 
						<span class="input-group-btn">
							<button type='submit' name='search' id='search-btn'
								class="btn btn-flat">
								<i class="fa fa-search"></i>
							</button>
						</span>
					</div>
				</form>
				 -->
				<!-- /.search form -->
				<!-- sidebar menu: : style can be found in sidebar.less -->
				<ul class="sidebar-menu">
					<li class="header">메뉴</li>
					<li class="treeview">
						<a href="#"> 
							<i class="fa fa-dashboard"></i> <span>설명</span> 
							<i class="fa fa-angle-left pull-right"></i>
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
						<a href="/investigation/state"> 
							<i class="fa fa-files-o"></i>
							<span>설문 참여</span>
							<span class="label label-primary pull-right">4</span>
						</a>
						<!--  
						<ul class="treeview-menu">
							<li>
								<a href="../layout/top-nav.html"><i
									class="fa fa-circle-o"></i> 1
								</a>
							</li>
							<li>
								<a href="/layout/boxed.html"><i
									class="fa fa-circle-o"></i> 2
								</a>
							</li>
							<li>
								<a href="layout/fixed.html"><i
									class="fa fa-circle-o"></i> 3
								</a>
							</li>
							<li>
								<a href="../layout/collapsed-sidebar.html">
									<i class="fa fa-circle-o"></i> 4
								</a>
							</li>
						</ul>
						-->
					</li>
					<li>
						<a href="../widgets.html"> <i class="fa fa-th"></i>
							<span>설문 결과(개인)</span>
							<small class="label pull-right bg-green">new</small>
						</a>
					</li>
					<li>
						<a href="/manager/registry"> <i class="fa fa-th"></i>
							<span>설문 등록 - 관리자 메뉴</span>
							<small class="label pull-right bg-green">new</small>
						</a>
					</li>
					<li>
						<a href="../widgets.html"> <i class="fa fa-th"></i>
							<span>설문 출제 - 관리자 메뉴</span>
							<small class="label pull-right bg-green">new</small>
						</a>
					</li>
					<li>
						<a href="../widgets.html"> <i class="fa fa-th"></i>
							<span>설문 결과 - 관리자 메뉴</span>
							<small class="label pull-right bg-green">new</small>
						</a>
						<!--  이거 클릭하면 나오는 페이지에서
						설문 차수, 조사 대상, 조사 인원, 답변율 보여주고
						체크 박스로 비교 하고 싶은 설문 선택 두개 할 수 있게 하고
						각 설문 별로 결과보기 버튼 옆에 누르기 -->
					</li>
					<li class="treeview">
						<a href="#"> <i
							class="fa fa-pie-chart"></i> <span>ㅌㅌ</span> <i
							class="fa fa-angle-left pull-right"></i>
						</a>
						<ul class="treeview-menu">
							<li>
								<a href="../charts/chartjs.html"><i
									class="fa fa-circle-o"></i> 답변율
								</a>
							</li>
							<li>
								<a href="../charts/morris.html"><i
									class="fa fa-circle-o"></i> Morris
								</a>
							</li>
							<li>
								<a href="../charts/flot.html"><i
									class="fa fa-circle-o"></i> Flot
								</a>
							</li>
							<li>
								<a href="../charts/inline.html"><i
									class="fa fa-circle-o"></i> Inline charts
								</a>
							</li>
						</ul>
					</li>
					<!--  
					<li class="treeview">
						<a href="#"> <i class="fa fa-laptop"></i>
							<span>UI Elements</span> <i class="fa fa-angle-left pull-right"></i>
						</a>
						<ul class="treeview-menu">
							<li><a href="../UI/general.html"><i
									class="fa fa-circle-o"></i> General</a></li>
							<li><a href="../UI/icons.html"><i class="fa fa-circle-o"></i>
									Icons</a></li>
							<li><a href="../UI/buttons.html"><i
									class="fa fa-circle-o"></i> Buttons</a></li>
							<li><a href="../UI/sliders.html"><i
									class="fa fa-circle-o"></i> Sliders</a></li>
							<li><a href="../UI/timeline.html"><i
									class="fa fa-circle-o"></i> Timeline</a></li>
							<li><a href="../UI/modals.html"><i
									class="fa fa-circle-o"></i> Modals</a></li>
						</ul>
					</li>
					<li class="treeview active">
						<a href="#"> <i
							class="fa fa-edit"></i> <span>Forms</span> <i
							class="fa fa-angle-left pull-right"></i>
						</a>
						<ul class="treeview-menu">
							<li class="active"><a href="general.html"><i
									class="fa fa-circle-o"></i> General Elements</a></li>
							<li><a href="advanced.html"><i class="fa fa-circle-o"></i>
									Advanced Elements</a></li>
							<li><a href="editors.html"><i class="fa fa-circle-o"></i>
									Editors</a></li>
						</ul>
					</li>
					<li class="treeview">
						<a href="#"> <i class="fa fa-table"></i>
							<span>Tables</span> <i class="fa fa-angle-left pull-right"></i>
						</a>
						<ul class="treeview-menu">
							<li><a href="../tables/simple.html"><i
									class="fa fa-circle-o"></i> Simple tables</a></li>
							<li><a href="../tables/data.html"><i
									class="fa fa-circle-o"></i> Data tables</a></li>
						</ul>
					</li>
					<li>
						<a href="../calendar.html"> <i class="fa fa-calendar"></i>
							<span>Calendar</span> <small class="label pull-right bg-red">3</small>
						</a>
					</li>
					<li>
						<a href="../mailbox/mailbox.html"> <i
							class="fa fa-envelope"></i> <span>Mailbox</span> <small
							class="label pull-right bg-yellow">12</small>
						</a>
					</li>
					<li class="treeview">
						<a href="#"> <i class="fa fa-folder"></i>
							<span>Examples</span> <i class="fa fa-angle-left pull-right"></i>
						</a>
						<ul class="treeview-menu">
							<li><a href="../examples/invoice.html"><i
									class="fa fa-circle-o"></i> Invoice</a></li>
							<li><a href="../examples/login.html"><i
									class="fa fa-circle-o"></i> Login</a></li>
							<li><a href="../examples/register.html"><i
									class="fa fa-circle-o"></i> Register</a></li>
							<li><a href="../examples/lockscreen.html"><i
									class="fa fa-circle-o"></i> Lockscreen</a></li>
							<li><a href="../examples/404.html"><i
									class="fa fa-circle-o"></i> 404 Error</a></li>
							<li><a href="../examples/500.html"><i
									class="fa fa-circle-o"></i> 500 Error</a></li>
							<li><a href="../examples/blank.html"><i
									class="fa fa-circle-o"></i> Blank Page</a></li>
						</ul>
					</li>
					<li class="treeview">
						<a href="#"> <i class="fa fa-share"></i>
							<span>Multilevel</span> <i class="fa fa-angle-left pull-right"></i>
						</a>
						<ul class="treeview-menu">
							<li><a href="#"><i class="fa fa-circle-o"></i> Level One</a></li>
							<li><a href="#"><i class="fa fa-circle-o"></i> Level One
									<i class="fa fa-angle-left pull-right"></i></a>
								<ul class="treeview-menu">
									<li><a href="#"><i class="fa fa-circle-o"></i> Level
											Two</a></li>
									<li><a href="#"><i class="fa fa-circle-o"></i> Level
											Two <i class="fa fa-angle-left pull-right"></i></a>
										<ul class="treeview-menu">
											<li><a href="#"><i class="fa fa-circle-o"></i> Level
													Three</a></li>
											<li><a href="#"><i class="fa fa-circle-o"></i> Level
													Three</a></li>
										</ul></li>
								</ul></li>
							<li><a href="#"><i class="fa fa-circle-o"></i> Level One</a></li>
						</ul>
					</li>
					<li><a href="/resources/documentation/index.html"><i
							class="fa fa-book"></i> <span>Documentation</span></a></li>
					<li class="header">LABELS</li>
					<li><a href="#"><i class="fa fa-circle-o text-red"></i> <span>Important</span></a></li>
					<li><a href="#"><i class="fa fa-circle-o text-yellow"></i>
							<span>Warning</span></a></li>
					<li><a href="#"><i class="fa fa-circle-o text-aqua"></i> <span>Information</span></a></li>
					 -->
				</ul>
			</section>
			<!-- /.sidebar -->
		</aside>