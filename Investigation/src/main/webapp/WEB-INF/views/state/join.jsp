<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
<!-- bootstrap datepicker -->
<link rel="stylesheet" href="/resources/plugins/datepicker/bootstrap-datepicker.css">
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

<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>

<body class="skin-blue sidebar-mini">
	<div class="wrapper">
		<%@include file="../include/menu.jsp"%>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					설문 참여 <small>설문에 참여합니다...</small>
				</h1>
			</section>
			<section class="content">
				<div class="row">
					<div class="col-md-12">
						<div class="box box-success">
							<div class="box-header">
								<h3 class="box-title">등록된 설문</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<div id="example2_wrapper"
									class="dataTables_wrapper form-inline dt-bootstrap">
									<div class="row">
										<div class="col-sm-12">
										</div>
									</div>
									<div class="row">
										<div class="col-sm-12">
										
											 
<c:forEach var="cvI" items="${items }" varStatus="status1">
	<div id="tab<c:out value='${cvI.itemSeq}'/>" class="tab-pane" itemNm="<c:out value='${cvI.itemNm}'/>" itemCd="<c:out value='${cvI.itemSeq}'/>">
		<c:choose>	
			<c:when test="${status1.count ==1 }">
			  <c:set var="pageCount"  value="${status1.count}"/>
				<table class="table table-bordered" id="t_${status1.count}">
					<thead>
	                <tr>
	                    <th class="text-center" width="46px">순번</th>
	                    <th  width="150px">항목</th>
	                    <th >문항</th>
	                    <th class="text-center" width="46px">전혀</th>
						<th class="text-center" width="46px">아님</th>
						<th class="text-center" width="46px">보통</th>
						<th class="text-center" width="46px">그럼</th>
						<th class="text-center" width="46px">매우</th>
	                </tr>
	            </thead>
				<tbody>
					<c:forEach var="cvS" items="${sentences }" varStatus="status">
						<c:if test="${cvS.itemNm == cvI.itemNm }">				
							<tr>
								<td  class="text-center" name="${cvI.itemSeq }">${cvS.sentenceSeq }</td>
								<td>${cvS.itemNm }</td>
								<td>${cvS.sentence }</td>
								<td class="text-center"><input type="radio" class="${cvI.itemSeq }" name="${cvI.itemSeq }_${cvS.sentenceSeq }"  value="1"></td>
								<td class="text-center"><input type="radio" class="${cvI.itemSeq }" name="${cvI.itemSeq }_${cvS.sentenceSeq }"  value="2"></td>
								<td class="text-center"><input type="radio" class="${cvI.itemSeq }" name="${cvI.itemSeq }_${cvS.sentenceSeq }"  value="3"></td>
								<td class="text-center"><input type="radio" class="${cvI.itemSeq }" name="${cvI.itemSeq }_${cvS.sentenceSeq }"  value="4"></td>
								<td class="text-center"><input type="radio" class="${cvI.itemSeq }" name="${cvI.itemSeq }_${cvS.sentenceSeq }"  value="5"></td>
							</tr>
						</c:if>
					</c:forEach>
			
				</tbody>
			</table>
			</c:when>
			<c:otherwise>
				<table class="table table-bordered hide" id="t_${status1.count}">
					<thead>
	                <tr>
	                    <th class="text-center" width="46px">순번</th>
	                    <th width="150px">항목</th>
	                    <th >문항</th>
	                    <th class="text-center" width="46px">전혀</th>
						<th class="text-center" width="46px">아님</th>
						<th class="text-center" width="46px">보통</th>
						<th class="text-center" width="46px">그럼</th>
						<th class="text-center" width="46px">매우</th>
	                </tr>
	           		</thead>
					<tbody>
						<c:forEach var="cvS" items="${sentences }" varStatus="status">
							<c:if test="${cvS.itemNm == cvI.itemNm }">				
								<tr>
									<td  class="text-center" name="${cvI.itemSeq }">${cvS.sentenceSeq }</td>
									<td>${cvS.itemNm }</td>
									<td >${cvS.sentence }</td>
									<td class="text-center"><input type="radio" class="${cvI.itemSeq }" name="${cvI.itemSeq }_${cvS.sentenceSeq }"  value="1"></td>
									<td class="text-center"><input type="radio" class="${cvI.itemSeq }" name="${cvI.itemSeq }_${cvS.sentenceSeq }"  value="2"></td>
									<td class="text-center"><input type="radio" class="${cvI.itemSeq }" name="${cvI.itemSeq }_${cvS.sentenceSeq }" value="3"></td>
									<td class="text-center"><input type="radio" class="${cvI.itemSeq }" name="${cvI.itemSeq }_${cvS.sentenceSeq }"  value="4"></td>
									<td class="text-center"><input type="radio" class="${cvI.itemSeq }" name="${cvI.itemSeq }_${cvS.sentenceSeq }"  value="5"></td>
								</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
			</c:otherwise>
		</c:choose>
	</div>
</c:forEach>
											 
											 
											 
											<nav>
											
													<ul class="pager">
												  	  <li><a href="#" onclick="Previous()">Previous</a></li>
												   	  <li><a href="#" onclick="Next()">Next</a></li>
												  	</ul>
												  	
												</nav>
										</div>
									</div>
									<button class="btn btn-warning pull-right hide" id="submit"><i class="fa fa-upload"></i>제출</button>
								</div>
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
	<!-- bootstrap datepicker -->
	<script src="/resources/plugins/datepicker/bootstrap-datepicker_2.js"></script>
	<script type="text/javascript">
var itemCount = '<c:out value="${itemCount}"/>';
var sentenceCount = '<c:out value="${sentenceCount}"/>';
$(function() {
	
	
	$('#submit').bind({
		click: function(e){
    		e.preventDefault();
			
    		//라디오 채크 안된거 검사하는거 넣어야함
			
    		alert("제출");
  			var ex = $('.tab-pane');
  	    	var answersValArray = [];
  	    	var itemsAvgArray = [];
  	    	var sendData = null;
  	    	var allTotal = 0;
  	    	        
  	        for(var cnt=0; cnt<ex.length; cnt++)
  	        {  
  	        	var tid = $(ex[cnt]).attr("itemCd");
  	        	var itemNm = $(ex[cnt]).attr("itemNm");			

  	        	var itemTotal = 0;
  	        	var ic = 0;
  	        	for(ic=1; ic<= $('td[name='+tid+']').length; ic++)
  	        	{
  	        		
  	        		var chkValue = $('input[name="'+tid+'_'+ic+'"]:checked').val();
  	        		if(chkValue==null){
  	        			alert("선택되지 않은 문항이 있습니다.");
  	        			return false;
  	        		}
  	        		itemTotal += parseInt(chkValue);
  	        		allTotal += parseInt(chkValue);
  	        		answersValArray.push(chkValue); 
  	        		    	
  	        	}
  	        	//alert("전체 :" +allTotal);     
  	        	//평균
  	        	var itemAvg = itemTotal/(ic-1);
  	        	itemsAvgArray.push(Math.round(itemAvg*100)/100);    
  	        }
  	        var totalAvg = Math.round( (allTotal/answersValArray.length) * 100 ) / 100;
  	        
  	        var totalAvgStr = totalAvg.toString();  	        
			var answersValStr = answersValArray.join(",");
			var itemsAvgStr = itemsAvgArray.join(",");

  	        //totalAvgStr  	       
  	        var inputDtStr = new Date().toISOString().slice(0,10).replace(/-/g,"");
			var inputDtStr = new Date().toISOString();

  	      	sendData = JSON.stringify({
              "version":	'<c:out value="${version}"/>',
              "stateSeq": 	'<c:out value="${stateSeq}"/>',
              "empno":		'<c:out value="${login.empno}"/>',
              "answersVal":	answersValStr,
              "totalAvg":	totalAvgStr,
              "itemsAvg":	itemsAvgStr,
              "inputDt":	inputDtStr
          	});
          	
          	var upLoadingDialog = bootbox.dialog({
        		title: '입력 전송창',
    	        message: '<p class="text-center"> 입력값을 전송 중입니다. 잠시만 기다려주세요. </p>',
    	        closeButton: true
    	    });
          	
          	//전송
          	$.ajax({
    			url: "/join/input",
    			method: "POST",
    			data: sendData,
    			dataType: "json",
    			contentType: "application/json;charset=UTF-8",
    			beforeSend: function(xhr){
    				/*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/    				
    				//xhr.setRequestHeader('${_csrf.headerName}','${_csrf.token}');
    				/*모달창*/
    				upLoadingDialog.modal('show');
    			},
    			success: function(data){   
    				upLoadingDialog.modal('hide');
    				alert("참여하였습니다.");   				
    				location.href="/main";
    			},
    			error: function(xhr, status, error){
    				alert("전송을 실패했습니다.");
    				alert(xhr);
    				alert(status);
    				alert(error);
        			upLoadingDialog.modal('hide');		    	    	  
    			}
    		});//end of ajax   
		}//end of click
	});
	

});

var pageCount = '<c:out value="${pageCount}"/>';
function Previous(){
	if(pageCount==itemCount){
		$("#submit").addClass('hide');
	}
	if(pageCount<=1){
		pageCount = 1
	}else{
		$('#t_'+pageCount).addClass('hide');
		pageCount--;
		$('#t_'+pageCount).removeClass('hide');
	}

};
function Next(){
	
	if( (pageCount==itemCount+1) || pageCount>=itemCount ){
		$("#submit").removeClass('hide');
		pageCount = itemCount
	}else{
		$('#t_'+pageCount).addClass('hide');
		pageCount++;
		$('#t_'+pageCount).removeClass('hide');
	}
};



	</script>
</body>
</html>


