<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../basicFrame.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>パターン管理</title>
</head>
<body>
<div class="main-panel">
   <input type="hidden" id="sessionId" name="sessionId" value="${sessionScope.loginId}">
   <input type="hidden" id="sessionName" name="sessionName" value="${sessionScope.loginName}"> 
   <div class="content">
      <div class="container-fluid">
         <div class="row">
            <div class="col-md-4">
               <div class="card card-stats">
                  <div class="card-body" id="one">
                     <div class="row">
                        <div class="col-5">
                           <div class="icon-big text-center icon-warning">
                              <i class="la la-pie-chart text-warning"></i>
                           </div>
                        </div>
                        <div class="col-7 d-flex align-items-center">
                           <div class="numbers">
                              <p class="card-category">Monthly Schedule</p>
                              <c:if test="${not empty cateList}">
                              <c:forEach var="list" items="${cateList}" varStatus="status">
                              <h4 class="card-title" id="firstCard">${list}</h4>
                              </c:forEach>
                              </c:if>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <div class="col-md-4">
               <div class="card card-stats">
                  <div class="card-body " id="two">
                     <div class="row">
                        <div class="col-5">
                           <div class="icon-big text-center">
                              <i class="la la-check-circle"></i>
                           </div>
                        </div>
                        <div class="col-7 d-flex align-items-center">
                           <div class="numbers">
                              <p class="card-category">Total Schedule</p>
                              <c:if test="${not empty cateList}">
                              <c:forEach var="list" items="${cateList}" varStatus="status">
                              <h4 class="card-title" id="firstCard">${list}</h4>
                              </c:forEach>
                              </c:if>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <div class="col-md-4">
               <div class="card card-stats">
                  <div class="card-body" id="three">
                     <div class="row">
                        <div class="col-5">
                           <div class="icon-big text-center">
                              <i class="la la-bar-chart text-success" ></i>
                           </div>
                        </div>
                        <div class="col-7 d-flex align-items-center">
                           <div class="numbers">
                              <p class="card-category">Unchecked</p>
                              <c:if test="${not empty unCheckedlist}">
                              <c:forEach var="unCheckedlist" items="${unCheckedlist}" varStatus="status">
                              <h4 class="card-title" id="firstCard">${unCheckedlist}</h4>
                              </c:forEach>
                              </c:if>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>      
         <div class="row">
            <div class="col-md-6" id="firstDiv">
               
            </div>
                  
            <div class="col-md-5" id="secondDiv">
               
            </div>
         </div>
      </div>
   </div>
</div>


<script src="resources/circle-progress.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.js"></script>
<c:set value="${sessionScope.loginId}" var="userId" />

<script type="text/javascript">
$(document).ready(function() {
   graph();
   $('#one').on('click', graph);
   $("#two").on('click', secondGraph);
   $("#three").on('click', table);
   
   var checkedCount = 0;
   var chartDataCount = 0;
   var chartLabels = [];
   var chartData = [];
   var chartData2 = [];
   var changeMonth = "";
   var checked="";
   var month="";
   var categoryCount = [];
   var categoryCount2 = [];
   var userId = '<c:out value="${userId}"/>';
   var sessionId = $('.sessionId').val();
   
   /* ===============createChart============================== */
   function createChart() {
      var ctx = document.getElementById("canvas").getContext("2d");
      LineChartDemo = Chart.Bar(ctx, {
         data : lineChartData,
         options : {
            responsive: false,
            maintainAspectRatio: false,
            scales : {
               yAxes : [ {
                  stacked : true,
                  ticks : {
                     beginAtZero : true,
                     stepSize: 1
                  }
               } ],
               xAxes : [ {
                  stacked : true,
                  ticks : {
                     beginAtZero : true
                  }
               } ]
            }
         }
      });
   }

   function createChart3() {
      var ctx = document.getElementById("canvas").getContext("2d");
      LineChartDemo = Chart.Bar(ctx, {
         data : lineChartData,
         options : {
            responsive: false,
            maintainAspectRatio: false,
            scales : {
               yAxes : [{
                  ticks : {
                     beginAtZero : true
                  }
               }]
            }
         }
      });
   }
   /* ===============================select====================== */
   $('#selectCheck').change(function() {
       var changeChecked = $('#selectCheck option:selected').val();
       checked = changeChecked;
    });
   
   $('#selectMonth').change(function() {
       changeMonth = $('#selectMonth option:selected').val();
    });
   /* ================button============================== */
   $(document).on('click','#btn',function(){
      chartLabels = [];
      chartData=[];
      chartData2=[];
      month = changeMonth;
      chartDataCount = 0;
      $('#graph').html('');
      $('#graph').html('<div id="graph" style="width: 80%; margin: 30px;"><div><canvas id="canvas" height="350" width="600"></canvas></div></div>');
   
      //getJson으로 데이터
      $.getJSON("./getCategory", {
         userId    : userId,
         checked : checked
      }, function(data) {
    	  console.log("ddddd"+data);
         var i = 0;
         var temp = [];
            $.each(data, function(key, value) {
            if(value.MONTH == month){
               chartDataCount ++;
            }
            if(value.MONTH == month && value.CHECKED == 1){
               if(chartLabels.length == 0){
                   chartLabels.push(value.CATEGORY);
                  i = chartLabels.indexOf(value.CATEGORY);
                  if(chartData[i]==null){
                     chartData[i]=0;
                  }
                  chartData[i] ++;
               }else {
                  if(chartLabels.includes(value.CATEGORY)){
                     i = chartLabels.indexOf(value.CATEGORY);
                     if(chartData[i]==null){
                        chartData[i]=0;
                     }
                     chartData[i] ++;
                  }else {
                      chartLabels.push(value.CATEGORY);
                     i = chartLabels.indexOf(value.CATEGORY);
                     if(chartData[i]==null){
                        chartData[i]=0;
                     }
                     chartData[i] ++;
                  }
               }
            }if(value.MONTH == month && value.CHECKED == 0){
               if(chartLabels.length == 0){
                   chartLabels.push(value.CATEGORY);
                  i = chartLabels.indexOf(value.CATEGORY);
                  if(chartData2[i]==null){
                     chartData2[i]=0;
                  }
                  chartData2[i] ++;
               }else {
                  if(chartLabels.includes(value.CATEGORY)){
                     i = chartLabels.indexOf(value.CATEGORY);
                     if(chartData2[i]==null){
                        chartData2[i]=0;
                     }
                     chartData2[i] ++;
                  }else {
                      chartLabels.push(value.CATEGORY);
                     i = chartLabels.indexOf(value.CATEGORY);
                     if(chartData2[i]==null){
                        chartData2[i]=0;
                     }
                     chartData2[i] ++;
                  }
               }
            }
         });
         lineChartData = {
               labels : chartLabels,
               datasets : [ {
                  label : "実行✘",
                  backgroundColor:'rgba(255,99,132,1)',
                  borderColor: 'rgba(255,99,132,1)',
                  pointBorderColor: "#80b6f4",
                  pointBackgroundColor: "#80b6f4",
                  pointHoverBackgroundColor: 'rgba(75, 192, 192, 0.2)',
                  pointHoverBorderColor: 'rgba(75, 192, 192, 1)',
                  fill: false,
                  borderWidth: 1,
                  maxBarThickness: 2,                  
                  data : chartData2
                  }, 
                  {
                     label : "実行",
                     backgroundColor: 'rgb(255, 205, 86)',
                     borderColor: 'rgb(255, 205, 86)',
                     pointBorderColor: "#80b6f4",
                     pointBackgroundColor: "#80b6f4",
                     pointHoverBackgroundColor: 'rgba(75, 192, 192, 0.2)',
                     pointHoverBorderColor: 'rgba(75, 192, 192, 1)',
                     fill: false,
                     borderWidth: 1,
                     maxBarThickness: 2,                  
                     data : chartData
                  }]
         }
         createChart();
         secondDiv();
         console.log("확인"+chartLabels);
      });
   })
   $(document).on('click','#btn2', function(){
      var dataSize = 0;
      checked = $('#selectCheck option:selected').val();
      $('.tr').html('');
      
      $.ajax({
         data: checked,
         url: 'scheduleList',
         type: 'POST',
         dataType : 'json',
         contentType : 'application/json; charset:utf-8',
         success : function(data){
            var str ='';
            var i = 0;
            $.each(data, function(i){
               str += '<tr>';
               str += '<td>'+data[i].schNum+'</td>';
               str += '<td>'+data[i].schTitle+'</td>';
               str += '<td>'+data[i].schContent+'</td>';
               str += '<td>'+data[i].schStartdate+'</td>';
               str += '<td>'+data[i].schEnddate+'</td>';
               str += '<td>'+data[i].category+'</td>';
               str += '</tr>';
               
               if(categoryCount.length == 0){
                  categoryCount.push(data[i].category);
                  i = categoryCount.indexOf(data[i].category);
                  if(categoryCount2[i]==null){
                     categoryCount2[i]=0;
                  }
                  categoryCount2[i] ++;
               }else {
                  if(categoryCount.includes(data[i].category)){
                     i = categoryCount.indexOf(data[i].category);
                     if(categoryCount2[i]==null){
                        categoryCount2[i]=0;
                     }
                     categoryCount2[i] ++;
                  }else {
                     categoryCount.push(data[i].category);
                     i = categoryCount.indexOf(data[i].category);
                     if(categoryCount2[i]==null){
                        categoryCount2[i]=0;
                     }
                     categoryCount2[i] ++;
                  }
               }
               
            });
            $('.tr').append(str);
            dataSize = data.size;
            secondTable();
         },
         error: function(){
            alert("error");
         }
      });
   });
      
   /* ===========================firstDiv================================= */
   function graph(){
      var str = '';
      str += '<div class="row">';
      str += '<div class="col-lg-3 col-md-3 col-sm-3" style="margin-top:20px; margin-left:80px">';
      str += '<select class="form-control input-full" name="selectMonth" id="selectMonth">';
      str += '<option value="">月</option>';
      str += '<option value="01">1月</option>';
      str += '<option value="02">2月</option>';
      str += '<option value="03">3月</option>';
      str += '<option value="04">4月</option>';
      str += '<option value="05">5月</option>';
      str += '<option value="06">6月</option>';
      str += '<option value="07">7月</option>';
      str += '<option value="08">8月</option>';
      str += '<option value="09">9月</option>';
      str += '<option value="10">10月</option>';
      str += '<option value="11">11月</option>';
      str += '<option value="12">12月</option>';
      str += '</select>';
      str += '</div>';
      str += '<div class="col-lg-3 col-md-1 col-sm-1" style="margin-top:20px; margin-left:10px">';
      str += '<select class="form-control input-full" name="selectCheck" id="selectCheck">';
      str += '<option value="">実行可否</option>';
      str += '<option value="0">実行✘</option>';
      str += '<option value="1">実行</option>';
      str += '</select>';
      str += '</div>';
      str += '<div class="col-lg-3 col-md-1 col-sm-1" style="margin-top:20px; margin-left:10px">';
      str += '<button class="btn btn-success" id="btn">見る</button>';
      str += '</div>';
      str += '</div>';
      str += '<div id="graph" style="width: 80%; margin: 30px;">';
      str += '<div>';
      str += '<canvas id="canvas" height="350" width="600"></canvas>';
      str += '</div>';
      str += '</div>';
      $('#firstDiv').html(str);
   }   
   function secondGraph(){
      $('#secondDiv').html('');
      var str = '';
      str += '<div class="row">';
      str += '</div>';
      str += '<div id="graph" style="width: 80%; margin: 30px;">';
      str += '<div>';
      str += '<canvas id="canvas" height="350" width="600"></canvas>';
      str += '</div>';
      str += '</div>';
      $('#firstDiv').html(str);
      chartData=[];
      chartLabels = ["01","02","03","04","05","06","07","08","09","10","11","12"];
      chartLabel = ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"];
      
      $('#graph').html('');
      $('#graph').html('<div id="graph" style="width: 80%; margin: 30px;"><div><canvas id="canvas" height="350" width="600"></canvas></div></div>');
      //getJson으로 데이터
      $.getJSON("./getMonth", {
         userId : userId
         , contentType : 'application/json; charset:utf-8'
      }, function(data) {
         var i = 0;
         var temp = [];
         $.each(data, function(key, value) {
            if(chartLabels.includes(value.MONTH)){
               i = chartLabels.indexOf(value.MONTH);
               if(chartData[i]==null){
                  chartData[i]=0;
               }
               chartData[i] ++;
            }else {
               i = chartLabels.indexOf(value.MONTH);
               if(chartData[i]==null){
                  chartData[i]=0;
               }
               chartData[i] ++;
            }
         });
         lineChartData = {
            labels : chartLabel,
            datasets : [ {
               label : "スケジュール数",
               backgroundColor: 'rgb(255, 205, 86)',
               borderColor: 'rgb(255, 205, 86)',
               pointBorderColor: "#80b6f4",
               pointBackgroundColor: "#80b6f4",
               pointHoverBackgroundColor: 'rgba(75, 192, 192, 0.2)',
               pointHoverBorderColor: 'rgba(75, 192, 192, 1)',
               fill: false,
               borderWidth: 1,
               maxBarThickness: 2,
               data : chartData
            } ]
         }
         createChart3();
         secondDiv2();
      });
   }
   function table(){
      $('#secondDiv').html('');
      var str='';
      str += '<div class="row" style="padding: 10px">';
      str += '<div class="col-lg-3 col-md-3 col-sm-3" style="margin-top:20px; margin-left:80px">';
      str += '<select class="form-control input-full" name="selectCheck" id="selectCheck">';
      str += '<option value="">実行可否</option>';
      str += '<option value="0">実行✘</option>';
      str += '<option value="1">実行</option>';
      str += '</select>';
      str += '</div>';
      str += '<div class="col-lg-3 col-md-1 col-sm-1" style="margin-top:20px; margin-left:10px">';
      str += '<button class="btn btn-success" id="btn2">見る</button>';
      str += '</div>';
      str += '</div>';
      str += '<div class="card">';
      str += '<div class="card-header">';
      str += '<div class="card-title">Unchecked Schedule List</div>';
      str += '</div>';
      str += '<div class="card-body">';
      str += '<table class="table table-hover">';
      str += '<thead>';
      str += '<tr>';
      str += '<th scope="col">#</th>';
      str += '<th scope="col">Schedule Title</th>';
      str += '<th scope="col">Schedule Content</th>';
      str += '<th scope="col">startDate</th>';
      str += '<th scope="col">EndDate</th>';
      str += '<th scope="col">category</th>';
      str += '</tr>';
      str += '</thead>';
      str += '<tbody class="tr">';
      str += '</tbody>';
      str += '</table>';
      str += '</div>';
      str += '</div>';
      
      $('#firstDiv').html(str);
   }
    function secondTable(){
		
    	var temp = 0;
        var category = '';
        for(var i = 0; i<categoryCount2.length; i++){
           if(temp<categoryCount2[i]){
              temp = categoryCount2[i];
              category = categoryCount[i];
           }
        }
        console.log(category);
        
        if (cateory.equals(date)) {
			category = "데이트";
			alert('변환완료!!!!');
		}
        
		$('#secondDiv').html('');
		var sessionName = $('#sessionName').val();
		var sendData = {"category" : category};
		
		var str = '<br>';
		str += '<div class="card card-stats">';
		str += '<div class="card-header" >';
		str += '<h4 class="card-title">'+ sessionName +' 様におすすめします！</h4>';
		str += '<h4 class="card-title">これはいかがでしょうか？</h4>';
		str += '</div>';
		str += '<div class="card-body recommendDiv">';

		$.ajax({
			method : 'get'
			, url  : 'recPerCategory'
			, data : sendData
			, contentType : 'application/json; charset=UTF-8'
			, success : function(response){
				/* console.log(response[0][0]); */
 				$.each(response, function(index, item){
					console.log(response[index][index]);
					str += '<a href="' + response[index][0] +'" target="_blank">' + response[index][1] + '</a>'
					str += '<p>電話番号 : ' + response[index][2] +'</p>';
					str += '<p>アドレス : ' + response[index][3] + '</p>';
					str += '<hr>';
				}) 
					str += '</div>';
					str += '</div>';
					$('#secondDiv').html(str);
			}
		})   	
    	
       console.log("가장많은 카테고리가 뭔가"+categoryCount);
       console.log("가장많은 카테고리가 수가 얼마가"+categoryCount2);
   }
   /* ====================================secondDiv====================== */
   function secondDiv(){
      checkedCount = 0;
      var str = '';
       var newData = [];
       var maxCate = 0;
      var firstCard=$('#firstCard').text();
       var unFinished = 0;
       
       for(var i = 0; i < chartData.length; i++){
          checkedCount += parseInt(chartData[i]);
       }
       
       if(checked == '1'){
          for(var i = 0; i < chartData.length; i++){
             if(maxCate < parseInt(chartData[i])){
                maxCate = parseInt(chartData[i]);
                newData = chartLabels[i];
             }else if(maxCate == parseInt(chartData[i])){
                newData += chartLabels[i];
             }       
          }
       }if(checked == 0){
          for(var i = 0; i < chartData2.length; i++){
             if(maxCate < parseInt(chartData2[i])){
                maxCate = parseInt(chartData2[i]);
                newData = chartLabels[i];
             }else if(maxCate == parseInt(chartData2[i])){
                newData += chartLabels[i];
             }       
          }
        }
       console.log(chartLabels);
       var first = chartLabels[0];
       var second= chartLabels[1];
       var third = chartLabels[2];
       console.log(first);
       console.log(second);
       console.log(third);
       
       unFinished = chartDataCount - checkedCount
      str += '<div class="card card-stats">';
      str += '<div class="card-header" >';
      str += '<h4 class="card-title">' +month +'月スケジュール分析' +'</h4>';
      str += '</div>';
      str += '<div class="card-body">' ;
      str += '<div class="ptitem">';
      str += '<div class="item">';
      
      if(checked=='1'){
         str += '<div class="pt"><i class="la la-check"></i>' + chartDataCount + '個の中で'+'<div class="ptpt"> '+checkedCount+'</div> 個チェックしました！</div>';
         str += '<div class="pt"><i class="la la-check"></i>一番多かったのは'+ '<div class="ptpt">' + newData + '</div>です！！</div>';
      }else{
         str += '<div class="pt"><i class="la la-check"></i>' + chartDataCount + '個の中で'+'<div class="ptpt"> '+unFinished+'</div> 個できませんでした。</div>';
         str += '<div class="pt"><i class="la la-check"></i>一番多かったのは'+'<div class="ptpt">'+newData+'</div> です。</div>';
      }
      
      str += '</div>';
      str += '</div>';
      str += '</div>';
      str += '</div>';
      str += '<div class="card card-stats">';
      str += '<div class="card-header">結果';
      str += '<h4 class="card-title">結果</h4>';
      str += '</div>';
      str += '<div class="card-body">';
      str += '<div id="circle" class="chart-circle mt-4 mb-3">';
      str += '<strong class="circle_strong"></strong> ';
      str += '</div>';
      str += '</div>';
      str += '</div>';
      str += '';
      $('#secondDiv').html(str);
      
      var temp = checkedCount/chartDataCount;
      var temp2 = unFinished/chartDataCount;
      
      if(checked == '1'){
         $('#circle').circleProgress({      //들어갈 div class명을 넣어주세요
            value: temp,   //진행된 수를 넣어주세요. 1이 100기준입니다.
            size: 80, //도넛의 크기를 결정해줍니다.
            fill: {
               gradient: ['red','orange']    //도넛의 색을 결정해줍니다.
            }
         }).on('circle-animation-progress', function(event, progress) {    //라벨을 넣어줍니다.
               $(this).find('strong').html(parseInt(100 * temp) + '<i>%</i>');
            });
      }else{
         $('#circle').circleProgress({
            value: temp2,
            size: 80,
            fill: {
               gradient: ['red','orange'] 
            }
         }).on('circle-animation-progress', function(event, progress) {
               $(this).find('strong').html(parseInt(100 * temp2) + '<i>%</i>');
            });         
      }
   }
   function secondDiv2(){
      var str = '';
       var max = 0;
       var maxMonth = '';
       
       for(var i = 0; i < chartLabel.length; i++){
          if(max < parseInt(chartData[i])){
             max = parseInt(chartData[i]);
             maxMonth = chartLabel[i];
          }   
       }
      str += '<div class="card card-stats">';
      str += '<div class="card-header" >';
      str += '<h4 class="card-title">今年のスケジュール分析' +'</h4>';
      str += '</div>';
      str += '<div class="card-body cb">' ;
      str += '<div class="pt"><i class="la la-check"></i>今年 ' + '<div class="ptpt">'+ maxMonth + '</div> が一番忙しかったですね。</div>';
      str += '<div class="pt"><i class="la la-check"></i>登録されたスケジュールは総 '+'<div class="ptpt">'+ max +'</div> 個です。</div>';
      str += '</div>';
      str += '</div>';
      $('#secondDiv').html(str);
   }
})

</script>
</body>


</html>