<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인 결과</title>
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
					개인 결과<small>개인 결과의 통계를 봅니다.</small>
				</h1>
			</section>
			<section class="content">
				<c:set var="userItemAvg" value="${fn:split(UserResult.itemsAvg, ',') }"/>
				<c:set var="itemString" value="${fn:split(ItemString, ',') }"/>
				<div class="row">
					
				</div>
				
				<div class="row" style="margin: 10px">
					<button type="button" id="button1" class="btn btn-default" style="margin: 5px">방사형 그래프</button>
					<button type="button" id="button2" class="btn btn-default" style="margin: 5px">막대 그래프</button>
					<button type="button" id="button3" class="btn btn-default hide" style="margin: 5px">비교하기</button>
				</div>
				<div class="row" style="margin: 10px">
					<div class="col-md-9">
						<div class="box box-success hide" >
							<div id="container" style="min-width: 400px; max-width: 600px; height: 400px; margin: 0 auto"></div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="box box-danger hide">
							<div class="box-header with-border">
					        	<h3 class="box-title">개인 결과 비교 <small>같은 버전의 설문만 가능</small></h3>
					        </div>
					        <div class="box-body">
				            	<form role="form">
				              		<div class="form-group">
				                 		<label>Select</label>
				                  		<select id="selectVersion" class="form-control">
				                  		</select>
				                  		<button type="button" id="button4" class="btn btn-info pull-right hide" style="margin: 5px">선택</button>
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
	
	<script type="text/javascript">
$(function () {
	
	var userItemAvg = '<c:out value="${UserResult.itemsAvg}"/>';
	var userItemArr = userItemAvg.split(",");
	
	var itemString = '<c:out value="${ItemString}"/>';
	var itemArr = itemString.split(",");
	var itemArrFloat;

	
	//유저 결과, 지난 결과 객체를 담을 배열 
	var dataArr = [];
	
	var UserData = {
		name: '<c:out value="${login.name}"/>'+'_'+'<c:out value="${UserResult.stateSeq}"/>',
        data: [],
        color : '#2f7ed8'
	};
	
	for(var i=0 ; i< itemArr.length ; i++){
		UserData.data.push(parseFloat(userItemArr[i]));
	}
	dataArr.push(UserData);
	
	//클릭한 버튼의 id값을 저장 할 변수
	 var id_check;
	
	$("#button1").click( function(){
		id_check = $(this).attr("id");
		$(".box-success").removeClass('hide');
		$("#button3").removeClass('hide');
		Highcharts.chart('container', {
			//colors: ['#8bc34a','#03a9f4'],
		    chart: {
		        polar: true,
		        type: 'line',
		    },
		    credits: {
		        enabled: false
		    },

		    title: {
		        text: '방사형 결과 보기'
		       // x: -80
		    },

		    pane: {
		        size: '80%'
		    },

		    xAxis: {
		        categories: itemArr,
		        tickmarkPlacement: 'on',
		        lineWidth: 0,
		        labels: {
			        style: { color : 'black'}
			    }
		    },

		    yAxis: {
		        gridLineInterpolation: 'polygon',
		        lineWidth: 0,
		        min: 0,
		        max: 5
		    },

		    tooltip: {
		        shared: true,
		        pointFormat: '<span style="color:{series.color}">{series.name}: <b>{point.y:,.1f}</b><br/>'
		    },

		    legend: {
		        align: 'right',
		        verticalAlign: 'top',
		        y: 70,
		        layout: 'vertical'
		    },
		    plotOptions: {
		        line: {
		            dataLabels: {
		                enabled: true
		            }
		        }
		    },
		    series: dataArr
		});
	});
	
	
	$("#button2").click( function(){
		id_check = $(this).attr("id");
		$(".box-success").removeClass('hide');
		$("#button3").removeClass('hide');
		
		Highcharts.chart('container', {
		    chart: {
		        type: 'column'
		    },
		    credits: {
		        enabled: false
		    },
		    title: {
		        text: '막대형 결과 보기'
		    },
		    xAxis: {
		        categories: itemArr,
		        crosshair: true
		    },
		    yAxis: {
		        min: 0,
		        max: 5,
		        title: {
		            text: '값'
		        }
		    },
		    tooltip: {
		        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
		        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
		            '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
		        footerFormat: '</table>',
		        shared: true,
		        useHTML: true
		    },
		    plotOptions: {
		        column: {
		            pointPadding: 0.2,
		            borderWidth: 0,
		            dataLabels: {
		                enabled: true
		            }
		        }
		    },
		    series: dataArr
		});
		
		
	});
	$("#button3").click( function(){
		$(".box-danger").removeClass('hide');
		
		sendData = JSON.stringify({
            "version":	'<c:out value="${UserResult.version}"/>',
            "stateSeq": '<c:out value="${UserResult.stateSeq}"/>',
            "empno":	'<c:out value="${login.empno}"/>'
        	});
		
		$.ajax({
			url: "/personal/sameversion",
			method: "POST",
			data: sendData,
			dataType: "json",
			contentType: "application/json;charset=UTF-8",
			success: function(data){   
				if(data.length == 0){
					alert("비교 가능한 설문이 없습니다");
					return;
				}else{
					$("#button4").removeClass('hide');
					$("#selectVersion").empty();
					$.each(data, function(index, item){
						$("#selectVersion").append('<option id="'+item.stateSeq+'" value="'+item.stateSeq+'">'+item.titleNm+'</option>');
					});
				}
			},
			error: function(xhr, status, error){
				alert("전송을 실패했습니다.");
				alert(xhr);
				alert(status);
				alert(error);
	    	    	  
			}
		});//end of ajax   
	});
	
	$("#button4").click( function(){
		var stateSeq = $("#selectVersion option:selected").val();
		var sendVer = "stateSeq" + "=" + stateSeq;
		//alert(value);
		$.ajax({
			url: "/personal/compare",
			method: "GET",
			data: sendVer,
			dataType: "text",
			//contentType: "application/json;charset=UTF-8",
			success: function(data){   
				var jsonData = JSON.parse(data);
				//alert(jsonData.itemsAvg);
				var jsonItemArr = jsonData.itemsAvg.split(",");
				if(dataArr.length==1){
					var tempData = {
						name: '<c:out value="${login.name}"/>'+'_'+jsonData.stateSeq,
					    data: [],
					    color : 'red'
					};
						
					for(var i=0 ; i< itemArr.length ; i++){
						tempData.data.push(parseFloat(jsonItemArr[i]));
					}
					dataArr.push(tempData);
				}else{
					dataArr.pop();
					var tempData = {
						name: '<c:out value="${login.name}"/>'+'_'+jsonData.stateSeq,
						data: [],
					    color : 'red'
					};
					for(var i=0 ; i< itemArr.length ; i++){
						tempData.data.push(parseFloat(jsonItemArr[i]));
					}
					dataArr.push(tempData);
				}
				$("#"+id_check).trigger('click');
			},
			error: function(xhr, status, error){
				alert("전송을 실패했습니다.");
				alert(xhr);
				alert(status);
				alert(error);
	    	    	  
			}
		});//end of ajax   
	});
});
	
	</script>
</body>
</html>


