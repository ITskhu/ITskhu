<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서별 통계</title>
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
					부서별 통계 <small>부서를 선택합니다.</small>
				</h1>
			</section>
			<!-- Main content -->
			<section class="content">
			
				<div class="row">
					<div class="col-md-12">
						<div class="box">
						
							<div class="box-header with-border">
								<h3 class="box-title">해당 설문에 참여한 부서</h3>
							</div>

							<div class="box-body">
								<div class="row">
									<div class="col-md-3">
										<label>부서</label>
										<select id="selectDepart" class="form-control">
											<c:forEach var="targetDepart" items="${TargetDepart }" varStatus="status">
												<option id="${targetDepart.departCode}" value="${targetDepart.departCode}">${targetDepart.name}</option>
											</c:forEach>
					                  	</select>
									</div>
									<div class="col-md-2">
										<label>분류</label>
										<select id="selectCate" class="form-control">
											<option id="items" value="1">항목별</option>
											<option id="sentences" value="2">문항별</option>
					                  	</select>
									</div>
									<div class="col-md-2">
										<button type="button" id="button1" class="btn btn-default" style="margin-top: 25px">결과보기</button>
									</div>
									<div class="col-md-3 hide" id="compare1">
										<label>비교할 부서</label>
										<select id="compareDepart" class="form-control">
					                  	</select>
									</div>
									<div class="col-md-2 hide" id="compare2">
										<button type="button" id="button2" class="btn btn-default" style="margin-top: 25px">비교하기</button>
									</div>
								</div>
							</div>						
						</div>
					</div>
				</div>
				
				<div class="row" >
					<div class="col-md-8">
						<div id="box1" class="box hide" >
							<div class="row">
								<div class="col-md-12">
									<button type="button" id="button3" class="btn btn-default" style="margin: 5px">방사형 그래프</button>
									<button type="button" id="button4" class="btn btn-default" style="margin: 5px">막대 그래프</button>
									<button type="button" id="button5" class="btn btn-default" style="margin: 5px">선 그래프</button>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div id="container1" style="min-width: 400px; max-width: 600px; height: 400px"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div id="box2" class="box hide" >
							<div class="row">
								<div class="col-md-12">
									<button type="button" id="button6" class="btn btn-default" style="margin: 5px">가로 막대 비율 그래프</button>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div id="container2" style="min-width: 400px; height: 1500px; margin: 0 auto"></div>
								</div>
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
		var stateSeq = '<c:out value="${stateSeq}"/>';
		var version = '<c:out value="${version}"/>';
		var itemString = '<c:out value="${ItemString}"/>';
		var itemArr = itemString.split(",");

		var departCode;
		var departName;
		//결과 객체를 담을 배열 
		var dataArr = []; //방사, 막대, 선형
		var dataArr2 = []; // 가로 막대 비율
		var dataArr3 = []; //문항 파이
		
		var tempData = { //방사, 막대, 선형
			name: "",
			data: [],
			color : '#9962ff'
		};
		var senCate = [];
		var answerCount;
		
		$("#button1").click( function(){
			departCode = $("#selectDepart option:selected").val();
			departName = $("#selectDepart option:selected").text();
			console.log(departCode);
			console.log(departName);
			var cate = $("#selectCate option:selected").val();
			var sendData;
			
			if(cate==1){ //항목별 선택시 부서 비교 가능
				
				$("#box2").removeClass('hide');
				$("#box2").addClass('hide');
				sendData = "stateSeq="+stateSeq+"&departCode="+departCode+"&cate="+cate+"&version="+version;
				$.ajax({
					url: "/manager/selectdepart",
					method: "GET",
					data: sendData,
					dataType: "text",
					success: function(data){  
						
						var jsonData = JSON.parse(data);
						
						//비교 가능한 부서가 있다면 보여주기
						if(jsonData.OtherDepart.length != 0){
							$("#compare1").removeClass('hide');
							$("#compare2").removeClass('hide'); 
							$("#compareDepart").empty();
							$.each(jsonData.OtherDepart, function(index, item){
								$("#compareDepart").append('<option id="'+item.departCode+'" value="'+item.departCode+'">'+item.name+'</option>');
							});
						}
						
						//그래프 출력
						var jsonItemArr = jsonData.ItemAvgStr.split(",");
						
						if(dataArr.length==1){
							dataArr.pop();
						}
						if(dataArr.length==2){
							dataArr.pop();
							dataArr.pop();
						}
						
						var tempData2 = {
							name: departName,
							data: [],
							color : '#9962ff'
						};
						for(var i=0 ; i< itemArr.length ; i++){
							tempData2.data.push(parseFloat(jsonItemArr[i]));
						}
						dataArr.push(tempData2);
						
						
						$("#box1").removeClass('hide');
						$("#button3").trigger('click');
					},
					error: function(xhr, status, error){
						alert("전송을 실패했습니다.");
						alert(xhr);
						alert(status);
						alert(error);
			    	    	  
					}
				});//end of ajax 
				
			}else{ //문항별 선택시
				$("#compare2").removeClass('hide');
				$("#compare2").addClass('hide');
				$("#compare1").removeClass('hide');
				$("#compare1").addClass('hide');
				
				$("#box1").removeClass('hide');
				$("#box1").addClass('hide');
				
				sendData = "stateSeq="+stateSeq+"&departCode="+departCode+"&cate="+cate+"&version="+version;
				$.ajax({
					url: "/manager/sentencedpart",
					method: "GET",
					data: sendData,
					dataType: "text",
					success: function(data){  
						var jsonData = JSON.parse(data);
						var slen = jsonData.SentenceLength;
						var sCount = jsonData.SentenceCount;
						answerCount = jsonData.answerCount;
						
						if(dataArr2.length == 0){
							for(var i=0 ; i< sCount ; i++){
								senCate.push( (i+1)+"번"  );
							}
						}

						for(var i=0 ; i<slen ; i++){
							dataArr2.pop();
						}
						
						for(var j=slen ; j>0 ; j--){
							var staticData = {
								name: (j)+"",
							    data: []
							};
							var temp = new Array();
							temp.push(jsonData.answerList[j-1].split(","));
							for(var i=0 ; i< temp[0].length ; i++){
								staticData.data.push(parseInt(temp[0][i]));
							}
							dataArr2.push(staticData);
						}
						$("#box2").removeClass('hide');
						$("#button6").trigger('click');
					},
					error: function(xhr, status, error){
						alert("전송을 실패했습니다.");
						alert(xhr);
						alert(status);
						alert(error);
					}
				});//end of ajax 
			}
		});
		
		//비교할 부서 선택시
		$("#button2").click( function(){
			selectCode = $("#compareDepart option:selected").val();
			selectName = $("#compareDepart option:selected").text();
			
			sendData = "stateSeq="+stateSeq+"&selectCode="+selectCode+"&version="+version;
			$.ajax({
				url: "/manager/selectcomparedepart",
				method: "GET",
				data: sendData,
				dataType: "text",
				success: function(data){  
					console.log(data);

					//그래프 출력
					var selectItemArr = data.split(",");
					if(dataArr.length == 2)
						dataArr.pop();
					
					var tempData3 = {
						name: selectName,
						data: [],
						color : '#03a9f4'
					};
					for(var i=0 ; i< itemArr.length ; i++){
						tempData3.data.push(parseFloat(selectItemArr[i]));
					}
					dataArr.push(tempData3);
					
					$("#box2").removeClass('hide');
					$("#box2").addClass('hide');
					$("#box1").removeClass('hide');
					$("#button3").trigger('click');
					
					
				},
				error: function(xhr, status, error){
					alert("전송을 실패했습니다.");
					alert(xhr);
					alert(status);
					alert(error);
		    	    	  
				}
			});//end of ajax 
		});
		
		function SpiderGraph(){ //방사 그래프
			Highcharts.chart('container1', {
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
		}
		function BasicGraph(){ //막대 그래프
			Highcharts.chart('container1', {
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
			            pointPadding: 0.1,
			            borderWidth: 0,
			            dataLabels: {
			                enabled: true
			            }
			        }
			    },
			    series: dataArr
			});
			
		}
		function LineGraph(){ //선형 그래프
			Highcharts.chart('container1', {
			    chart: {
			        type: 'line'
			    },
			    title: {
			        text: '선형 결과 보기'
			    },
			    credits: {
			        enabled: false
			    },
			    xAxis: {
			        categories: itemArr
			    },
			    yAxis: {
			        title: {
			            text: '값'
			        }
			    },
			    plotOptions: {
			        line: {
			            dataLabels: {
			                enabled: true
			            },
			            enableMouseTracking: false
			        }
			    },
			    series: dataArr
			});
		}
		function PercentageGraph(){ //가로 막대 비율 그래프
			Highcharts.chart('container2', {
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

			    series: dataArr2
			});
			
		}

		$("#button3").click( function(){
			SpiderGraph();
		});
		$("#button4").click( function(){
			BasicGraph();
		});
		$("#button5").click( function(){
			LineGraph();
		});
		$("#button6").click( function(){
			PercentageGraph();
		});
	});
	
	
	</script>
</body>


</html>


