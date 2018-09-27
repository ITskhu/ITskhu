<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문항별 통계</title>
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

		<%@include file="../include/menu.jsp" %>
		
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					문항별 통계 <small>설문의 문항별 통계를 확인합니다.</small>
				</h1>
			</section>
			<!-- Main content -->
			<section class="content">
				<div class="row" style="margin: 10px">
					<button type="button" id="button1" class="btn btn-default" style="margin: 5px">가로 막대 비율 그래프</button>
					<button type="button" id="button2" class="btn btn-default" style="margin: 5px">문항 파이 그래프</button>
				</div>
				<div class="row" style="margin: 10px">
					<div class="col-md-9">
						<div id="box1" class="box hide" style=" max-width: 800px">
							<div id="container1" style="min-width: 400px; height: 1500px; margin: 0 auto"></div>
						</div>
						<div id="box2" class="box hide" style=" max-width: 800px">
							<div id="container2" style="min-width: 400px; height: 500px; margin: 0 auto"></div>
						</div>
					</div>
					<div class="col-md-3" style="height: 200px">
						<div class="box box-info hide">
							<div class="box-header with-border">
					        	<h3 class="box-title">문항 선택</h3>
					        </div>
					        <div class="box-body">
				            	<form role="form">
				              		<div class="form-group">
				                 		<label>Select</label>
				                  		<select id="selectVersion" class="form-control">
				                  			<c:forEach begin="1" end="${SentenceCount }" step="1" var="count">
				                  				<option id="select_${count}" value="${count}">${count}번</option>
				                  			</c:forEach>
				                  		</select>
				                  		<button type="button" id="button3" class="btn btn-info pull-right hide" style="margin: 5px">선택</button>
									</div>
								</form>
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
	
	<!-- highcharts -->
	<script src="/resources/plugins/highcharts/highcharts.js"></script>
	<script src="/resources/plugins/highcharts/highcharts-more.js"></script>
	<script src="/resources/plugins/highcharts/exporting.js"></script>
	<script src="/resources/plugins/highcharts/export-data.js"></script>
	<script>
	$(function () {	
		var answerList = '<c:out value="${AnswerList}"/>';
		var stateSeq = '<c:out value="${StateSeq}"/>';
		var version = '<c:out value="${Version}"/>';
		var slen = '<c:out value="${SentenceLength}"/>';
		var sCount = '<c:out value="${SentenceCount}"/>';
		var answerCount = '<c:out value="${AnswerCount}"/>'; 
		var senStrArr = new Array();
		<c:forEach items="${AnswerList}" var="test">
			senStrArr.push("${test}");
		</c:forEach>
		//일차원 배열 35개에 각각 문자열 저장 완료
		
		//결과 객체를 담을 배열 
		var dataArr = [];
		
		for(var j=slen ; j>0 ; j--){
			var staticData = {
				name: (j)+"",
			    data: []
			};
			var temp = new Array();
			temp.push(senStrArr[j-1].split(","));
			for(var i=0 ; i< temp[0].length ; i++){
				staticData.data.push(parseInt(temp[0][i]));
			}
			dataArr.push(staticData);
		}
		
		var senCate = [];
		for(var i=0 ; i< sCount ; i++){
			senCate.push( (i+1)+"번"  );
		}
		
		//클릭한 버튼의 id값을 저장 할 변수
		 var id_check;
		
		$("#button1").click( function(){
			id_check = $(this).attr("id");
			$("#box1").removeClass('hide');
			$("#box2").removeClass('hide');
			$("#box2").addClass('hide');
			
			Highcharts.chart('container1', {
			    chart: {
			        type: 'bar'
			    },
			    title: {
			        text: '가로 막대 비율 그래프'
			    },
			    xAxis: {
			        categories: senCate
			    },
			    yAxis: {
			        min: 0,
			        max: answerCount,
			        title: {
			            text: '%'
			        }
			    },
			    legend: {
			        reversed: true
			    },
			    credits: {
			        enabled: false
			    },
			    plotOptions: {
			        series: {
			            stacking: 'normal',
			            dataLabels: {
			                enabled: true,
			                format: '{point.percentage:.1f} %'
			            }
			        }
			    },
			    tooltip: {
			        pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.percentage:.1f}%)<br/>',
			        shared: true
			    },

			    series: dataArr
			});
		});
		
		
		$("#button2").click( function(){
			id_check = $(this).attr("id");
			$("#button3").removeClass('hide');
			$(".box-info").removeClass('hide');
			
		});
		
		$("#button3").click( function(){
			$("#box2").removeClass('hide');
			$("#box1").removeClass('hide');
			$("#box1").addClass('hide');
			
			var jsonArr;
			var dataArr2 = [];
			var selectSen = $("#selectVersion option:selected").val();
			var send = "stateSeq="+stateSeq+"&selectSen="+selectSen;
			
			$.ajax({
				url: "/manager/selectsentence",
				method: "GET",
				data: send,
				dataType: "text",
				success: function(data){   
					jsonArr = JSON.parse(data);
					for(var i=0 ; i<jsonArr.length ; i++){
						var tempData2 = {
							name: i+1,
							y: jsonArr[i]
						};
						dataArr2.push(tempData2);
					}
					PieChart();
				},
				error: function(xhr, status, error){
					alert("전송을 실패했습니다.");
					alert(xhr);
					alert(status);
					alert(error);  
				}
			});//end of ajax  
			
			function PieChart(){
				Highcharts.chart('container2', {
				    chart: {
				        plotBackgroundColor: null,
				        plotBorderWidth: null,
				        plotShadow: false,
				        type: 'pie'
				    },
				    title: {
				        text: '문항 파이 그래프'
				    },
				    subtitle: {
				        text: selectSen+'번 문항'
				    },
				    credits: {
				        enabled: false
				    },
				    tooltip: {
				        pointFormat: '{series.name}: <b>{point.y}</b>  <b>({point.percentage:.1f})%</b>'
				    },
				    plotOptions: {
				        pie: {
				            allowPointSelect: true,
				            cursor: 'pointer',
				            dataLabels: {
				                enabled: true,
				                format: '<b>{point.name}</b>: {point.percentage:.1f} %',
				                style: {
				                    color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
				                }
				            }
				        }
				    },
				    series: [{
				        name: '선택',
				        colorByPoint: true,
				        data: dataArr2
				    }]
				});
			}
			
			
		});

	});
	</script>
</body>


</html>


