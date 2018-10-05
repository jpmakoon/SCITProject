<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ page import="java.util.Date" %>
   <%@ page import="java.text.SimpleDateFormat" %>
<%@include file="../basicFrame.jsp" %>
 <%
    Date nowTime=new Date();
    SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
    %>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">

<!-- <link rel="stylesheet" type="text/css" href="group/styles/courses.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="group/styles/courses_responsive.css"> -->

<!-- 캘린더 부분 -->
<link href='resources/calendar/fullcalendar.min.css' rel='stylesheet' />
<link href='resources/calendar/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='resources/lib/moment.min.js'></script>
<script src='resources/calendar/fullcalendar.min.js'></script>

<!-- Dashboard Core -->
<link href="schduleResist/dist/assets/css/dashboard.css"
   rel="stylesheet">
<script src="schduleResist/dist/assets/js/dashboard.js"></script>

<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
   href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,300i,400,400i,500,500i,600,600i,700,700i&amp;subset=latin-ext">

<script type="text/javascript" charset="utf-8" async=""
   data-requirecontext="_" data-requiremodule="selectize"
   src="schduleResist/dist/assets/js/vendors/selectize.min.js"></script>
<script type="text/javascript" charset="utf-8" async=""
   data-requirecontext="_" data-requiremodule="bootstrap"
   src="schduleResist/dist/assets/js/vendors/bootstrap.bundle.min.js"></script>
<script type="text/javascript" charset="utf-8" async=""
   data-requirecontext="_" data-requiremodule="core"
   src="schduleResist/dist/assets/js/core.js"></script>
<script type="text/javascript" charset="utf-8" async=""
   data-requirecontext="_" data-requiremodule="input-mask"
   src="schduleResist/dist/assets/plugins/input-mask/js/jquery.mask.min.js"></script>
 <script>

	 var infoWindow;
     var markers = [];
     var map;
     var bermudaTriangle;
     var product;
     var marker;
     var geocoder;
     var pos;
     function initMap() {
        map = new google.maps.Map(
              document
                    .getElementById('map'),
              {
                 zoom : 15,
                 center : {
                 	
                    lat : 35.717,
                    lng : 139.731
                 },
                 mapTypeId : 'terrain'
              });
        geocoder = new google.maps.Geocoder();
     geocodeAddress(geocoder,
              map);

     }
     function geocodeAddress(
             geocoder, resultsMap) {
          var country = document
                .getElementById('schLocation').value;
          /* alert(country); */
          geocoder
                .geocode(
                      {
                         'address' : country
                      },
                      function(
                            results,
                            status) {
                         if (status === 'OK') {
                            resultsMap
                                  .setCenter(results[0].geometry.location);
                            marker = new google.maps.Marker(
                                  {
                                     zoom : 15,
                                     map : resultsMap,
                                     position : results[0].geometry.location
                                  });
                            markers
                                  .push(marker);
                         } else {
                         /*    alert('Geocode was not successful for the following reason: '
                                  + status); */
                         }
                      });
       }
     function setMapOnAll(map) {
         for (var i = 0; i < markers.length; i++) {
            markers[i].setMap(map);
         }
      }
                                    
                           

                                  
                                 </script>
<script type="text/javascript">
function schCheck() {
    var title=$("#schTitle").val();// #은 아이디, .은 클래스
    var content=$("#schContent").val();
    var startDate=$("#schStartdate").val();
    var endDate=$("#schEnddate").val();
    
    if (title.trim().length==0){
       alert("제목을 입력해주세요")
       return false;
    }
    
    if(content.trim().length==0){
       alert("내용을 입력해주세요");
       
       return false;
    }
    
    
    var startDate1=startDate.split("-");
    var startDateNum='';
    
    for(var i =0; i<startDate1.length; i++){
       startDateNum += startDate1[i];
    }
    
    var endDate1=endDate.split("-");
    var endDateNum='';
    
    for(var i=0; i<endDate1.length; i++){
       endDateNum+= endDate1[i];
    }
    
    if(parseInt(startDateNum) > parseInt(endDateNum)){   //startDate와 마감일 비교
       alert("마감일은 시작일보다 이전일 수 없습니다. ");
       return false;
    }
  
    if(startDate.trim().length==0){
       alert("시작일을 정해주세요.");
       return false;
    }
    
    if(endDate.trim().length==0){//마감일은 시작일이상으로 설정되게
    alert("마감일을 정해주세요.");
    return false;
    }
    

       
 }
$(function(){
      $('.fe-chevron-up').on('click',function(){
    	  $('#calendar').remove();
          $('#cal').html('<div id="calendar"></div> <div class="scheduleUpdate"></div>');
         var calCheck = $('#calendar').attr('class');
/*          if(calCheck.hasClass("fc") == true){
            alert(calCheck);
         } */
         var fullDate = new Date();
         var twoDigitMonth = ((fullDate.getMonth().length+1) === 1)?(fullDate.getMonth()+1) : '0' + (fullDate.getMonth()+1);
         var currentDate = fullDate.getFullYear()+"-"+twoDigitMonth+ "-" +fullDate.getDate();
        
         
         var plaNum=$(this).parents().parents().parents().parents().children(".card-body").attr('id');
         var sendData={'plaNum':plaNum};
         var inputData='';
         inputData+='<input type="button" class="insertSchedule" data-rno="'+plaNum+'" value="スケジュール登録">';
            $("#"+plaNum).html(inputData);
           /*  $.ajax({
            method:'post',
//             url:'selectUserPlannerSchedule',
            data:JSON.stringify(sendData),
            dataType:'json',
            contentType:'application/json;charset=utf-8',
            success:function(sch){  
                              
               
            }      
         });  */ 
         
         
         //$(this).removeClass('fe-chevron-up').addClass('fe-chevron-up_opened');
             $('#calendar').fullCalendar({
                 header: {
                   left: 'prev,next today',
                   center: 'title',
                   right: '' 
                 },
                 defaultDate: currentDate,
                 navLinks: true, // can click day/week names to navigate views
                 selectable: true,
                 selectHelper: true,
                 editable: true,
                 eventLimit: true, // allow "more" link when too many events
                 
                 eventDragStop: function(event,jsEvent) {

                     var trashEl = jQuery('#calendarTrash');
                     var ofs = trashEl.offset();

                     var x1 = ofs.left;
                     var x2 = ofs.left + trashEl.outerWidth(true);
                     var y1 = ofs.top;
                     var y2 = ofs.top + trashEl.outerHeight(true);

                     if (jsEvent.pageX >= x1 && jsEvent.pageX<= x2 &&
                         jsEvent.pageY >= y1 && jsEvent.pageY <= y2) {
                         var message = confirm("정말로 삭제하시겠습니까?");
                         if(message == true){
                            
                            $('#calendar').fullCalendar('removeEvents', event._id);
                         var el = $( "<div class='fc-event'>" ).appendTo( '#external-events-listing' ).text( event.title );
                         
                         el.draggable({
                            zIndex: 999,
                             revert: true,  
                             revertDuration: 0
                            
                         });
                         var a=$(this).attr('class');
                         var b=a.split(' ');
                        var schNum=parseInt(b[5].trim());
                		
                         var sendData={
                            'schNum':schNum   
                         };
                     
                  
                         //ajax 사용해서 db에서 지워주기
                         $.ajax({
                            method:'post',
                            url:'deleteSchedule',
                            data:JSON.stringify(sendData),
                            dataType:'json',
                            contentType:'application/json; charset:utf-8',
                            suceess:function(r){
                               if(r != 1){
                                  alert('삭제 실패');
                               }
                            }
                         });
                         /* code here */
                         ///////////////////////
                         
                         alert('삭제성공!');
                         }else
                            return false;
                     }
                    
                 },
                
                  
                 //************************* 일정 입력란 *********************************
                 //해당 스케줄을 모두 가져와서 for문으로 모두 입력시켜야 함  
             
                 
             
                 events: function(start, end ,timezone, callback) {
               $.ajax({
                 method:'post',
                 url: 'selectUserPlannerSchedule',
                 data:JSON.stringify(sendData),
                 dataType:'json',
                contentType:'application/json;charset=utf-8',
                 success: function(doc) {
                   var events = [];
                   var resources=[];
                   for ( var i in doc) {
                      var update='';
                    update=(doc[i].schEnddate).split('-');
                    
                    
                    //31일 일때
                    if(update[1]==1 && update[1]==3 && update[1]==5 && update[1]==7 && update[1]==8 && update[1]==10 && update[1]==12){
                       if(parseInt(update[2])==31){
                          update[1]=parseInt(update[1])+1;
                          update[2]=1;
                       }else{
                          
                       }
                    }else{
                       if(parseInt(update[0])%4==0 && update[0]==2){ //윤년
                          if(parseInt(update[2]==29)){
                             update[1]=parseInt(update[1])+1;
                             update[2]=1;
                          }else{
                             update[2]=parseInt(update[2])+1;
                          }
                       }else{
                          if(update[2]==30){   //4,6,9,11 월
                             update[1]=parseInt(update[1])+1;
                             update[2]=1;
                          }else{
                             update[2]=parseInt(update[2])+1;
                          }
                       }
                    }
                    doc[i].schEnddate=update[0]+'-'+update[1]+'-'+update[2];
                    //중요도 색상 표시
                    if(doc[i].importance==1){
                       doc[i].importance='azure';
                    }else if(doc[i].importance==2){
                       doc[i].importance='indigo';
                    }else if(doc[i].importance==3){
                       doc[i].importance='purple';
                    }else if(doc[i].importance==4){
                       doc[i].importance='pink';
                    }else if(doc[i].importance==5){
                       doc[i].importance='red';
                    }else if(doc[i].importance==6){
                       doc[i].importance='orange';
                    }else if(doc[i].importance==7){
                       doc[i].importance='yellow';
                    }else if(doc[i].importance==8){
                       doc[i].importance='lime';
                    }else if(doc[i].importance==9){
                       doc[i].importance='green';
                    }else if(doc[i].importance==10){
                       doc[i].importance='teal';
                    }
                 }
                   
                   $.each(doc,function() {
                     events.push({
                      
                       title: $(this).attr('schTitle'),
                       start: $(this).attr('schStartdate'), // will be parsed
                       end:$(this).attr('schEnddate'),  
                       
                       color: $(this).attr('importance'),
                      textColor: 'white' // an option!
                      ,className : [$(this).attr('schNum')]      
                     });        
                   });        
                   callback(events);      
                 }
               });
             }        
                  //****************************************************************
               });
            var tra='<div id="calendarTrash" class="calendar-trash"><img src="resources/calendar/trash.jpg" /></div><br/>';
            $('.fc-right').html(tra);
         
            
            
          });
       

          $(document).on('click','.fe-chevron-up_opened',function(){
             alert('aassa');
            $('.calendar').html('');
            $(this).removeClass('fe-chevron-up_opened').addClass('fe-chevron-up');
         });
          


      //플래너 삭제
      $(".fe-x").on('click',function(){
    	  if(!confirm("삭제하시겠습니까?")){
   			return false;
   		}else{
        var plaNum=$(this).parents().parents().parents().parents().children(".card-body").attr('id');
        var sendData={'plaNum':plaNum};
        
        $.ajax({
          method:'post',
          url:'deletePlanner',
          data:JSON.stringify(sendData),
          dataType:'json',
          contentType:'application/json;charset=utf-8',
          success:function(res){    
          }
        }); 
   		}
      });
      
      $(document).on('click','.insertSchedule',function(){
         var plaNum=$(this).attr("data-rno");
         location.href="insertSchedule?plaNum="+plaNum;
      });
      $(document).on('click','.fc-content',function(){
    	  var a=$(this).parents('a').attr('class');
    	  
          var b=a.split(' ');
         
         var schNum=parseInt(b[5].trim());
    	  
          var sendData={'schNum':schNum};
          var inputData = '';
          inputData += '<input type="button" class="detailBtn btn btn-success" value="자세히 보기"  data-rno="'+schNum+'"/><br><br>';
          inputData += '<input type="button" class="updateBtn btn btn-warning" value="수정하기"  data-rno="'+schNum+'"/>';
          $('.scheduleUpdate').html(inputData);
      });
      $(document).on('click','.detailBtn',function(){
    	  var schNum=$(this).attr('data-rno');
          var sendData={'schNum':schNum};
          $.ajax({
        	 method:'post',
        	 url:'scheduleDetail',
        	 data:JSON.stringify(sendData),
        	 dataType:'json',
        	 contentType:'application/json;charset=utf-8',
        	 success:function(sch){
        		var inputData='';
        		
				///
        		inputData +='<div class="page"><div class="page-main"><div class="my-3 my-md-5"><div class="container"><div class="row"><div class="col-12">';
        		inputData +='<div class="card-header" style="padding-left : 0 ! important "><h4 class="card-title">スケジュール情報</h4><div class="closeimg"><img alt="" src="resources/close.png" class="closeDetail"></div></div></div></div></div>   ';                      
        		inputData +='<table>';
        		inputData +='<tr><td>タイトル</td><th>'+sch.schTitle+'</th></tr>';
        		inputData +='<tr><td>内容</td><th>'+sch.schContent+'</th></tr>';
        		inputData +='<tr><td>スタート日</td><th>'+sch.schStartdate+'</th></tr>';   
        		inputData +='<tr><td>終わる日</td><th>'+sch.schEnddate+'</th></tr>'; 
        		inputData +='<tr><td>category</td><th>'+sch.category+'</th></tr>';  
        		inputData +='<tr><td>위치</td><th>'+sch.schLocation+'</th></tr>';  
        		inputData +='<tr><th colspan="2"><input type="hidden" class="form-control" id="schLocation" value="'+sch.schLocation+'" name="schLocation" >';
        		inputData +='</div> <span class="col-auto">  <button class="btn btn-secondary" type="button"  onclick="initMap()"><i class="fe fe-search"></i></button> ';
        		inputData +='<div id="map"></div> <div id="infowindow-content"><span id="place-name" class="title"></span> <br> Place  ID <span id="place-id"></span><br> <span id="place-address"></span>'; 
        		inputData +='</th></tr></table>';
                
        		
               
                  
            
                    
                       
                       
                  
                      
                                                         
                  
                   
             
        		              
                 $('.scheduleUpdate').html(inputData);
                 
                 
        	 }
          });
      });
      //schedule 클릭시 수정
      $(document).on('click','.updateBtn',function(){
         var schNum=$(this).attr('data-rno');
         var sendData={'schNum':schNum};
         
         $.ajax({
            method:'post',
            url:'selectContent',
            data:JSON.stringify(sendData),
            dataType:'json',
            contentType:'application/json;charset=utf-8',
            success:function(sch){
               var allnum=sch.schNum+","+sch.plaNum;
               var inputData='';
               
               inputData += '<div class="page"><div class="page-main"><div class="my-3 my-md-5"><div class="container"><div class="row"><div class="col-12">';
               inputData +='<div class="card-header" style="padding-left : 0 ! important "><h4 class="card-title">スケジュール情報</h4><div class="closeimg"><img alt="" src="resources/close.png" class="closeDetail"></div>   ';
               inputData += '</div><div class="card-body"><div class="row" ><div class="col-md-6 col-lg-4"><div class="form-group">';
               inputData += '<label class="form-label">タイトル</label> <input type="text" id="schTitle" class="form-control" name="schTitle" value="'+sch.schTitle+'"></div>';   
               inputData +='<input type="hidden" id="plaNum" name="plaNum" value="'+sch.plaNum+'"><input type="hidden" id="schNum" name="schNum" value="'+sch.schNum+'"><br>';
               inputData +='<div class="form-group"> <label class="form-label">内容 <span class="form-label-small">56/100</span></label>';
               inputData +='<textarea class="form-control" id="schContent" name="schContent" rows="6" >'+sch.schContent+'</textarea>';    
               inputData +='<input type="hidden" id="hiddenschContent" value="'+sch.schContent+'">';
               inputData +='<input type="hidden" id="hiddenschTitle" value="'+sch.schTitle+'">';
               inputData +='<input type="hidden" id="hiddenstartdate" value="'+sch.schStartdate+'">';
               inputData += '<input type="hidden" id="hiddenendDate" value="'+sch.schEnddate+'"></div>';
               inputData +='</div><div class="col-md-6 col-lg-4"> <div class="form-group"><label class="form-label">スタート日</label><div class="row gutters-xs"> <input type="date" class="form-control" name="schStartdate"  id="schStartdate" value="'+sch.schStartdate+'" /></div></div>';         
               inputData +='<div class="form-group"><label class="form-label">終わる日</label><div class="row gutters-xs"><input type="date" class="form-control" name="schEnddate"  id="schEnddate" value="'+sch.schEnddate+'"></div></div>';                                
               inputData +='<input type="button" data-rno="'+allnum+'" id="updateSchedule2" class="btn btn-info ml-auto" value="修正"  /><br/>';
               inputData += '</div></div></div></div></div><input type="button" data-rno="'+allnum+'" id="updateSchedule" class="btn btn-primary ml-auto" value="詳細修正" /></div>';
                   
                   $('.scheduleUpdate').html(inputData);
            }
         });
         
      });
});
$(function(){
   $(document).on('click','#updateSchedule',function(){
      var num=$(this).attr('data-rno');
      nums=num.split(',');
      var schNum=nums[0];      var plaNum=nums[1];
      location.href="scheduleUpdate?schNum="+schNum+"&plaNum="+plaNum;
   });
   
    $(document).on('click','#updateSchedule2',function(){
       
       var fullDate = new Date();
      var twoDigitMonth = ((fullDate.getMonth().length+1) === 1)?(fullDate.getMonth()+1) : '0' + (fullDate.getMonth()+1);
       var currentDate = fullDate.getFullYear()+"-"+twoDigitMonth+ "-" +fullDate.getDate(); 
       
      var num=$(this).attr('data-rno');
      nums=num.split(',');
      var rowtag=$(this).parents('.col-lg-4').parents('.row');
      
      var schTitle=rowtag.children('.col-lg-4').children('.form-group').children('#schTitle').val();
      var schContent=rowtag.children('.col-lg-4').children('.form-group').children('#schContent').val();
      var schStartdate=rowtag.children('.col-lg-4').children('.form-group').children('.gutters-xs').children('#schStartdate').val();
      var schEnddate=rowtag.children('.col-lg-4').children('.form-group').children('.gutters-xs').children('#schEnddate').val();
   
      
      var schNum=nums[0];      var plaNum=nums[1];
      
      var sendData={
            'schNum':schNum,
            'plaNum':plaNum,
            'schTitle':schTitle,
            'schContent':schContent,
            'schStartdate':schStartdate,
            'schEnddate':schEnddate
      };
      var date='';
      
       $.ajax({
         method:'post',
         url:'scheduleUpdate1',
         data:JSON.stringify(sendData),
         dataType:'json',
         contentType:'application/json;charset=utf-8',
         success:function(r){
            
            if(r==1){
               alert("제목을 입력해주세요.");
            }else if (r==2) {
               alert('내용을 입력해주세요.');
            }else if (r==3) {
               alert('시작일을 입력해주세요.');
            }else if (r==4) {
               alert("마감일을 입력해주세요.");
            }else {
               alert('변경되었습니다.');
            }
            
         }
      }); 

       var sendData1={
             'plaNum':plaNum
       };
       //현재 calendar 삭제
       $('#calendar').remove();
       $('#cal').html('<div id="calendar"></div> <div class="scheduleUpdate"></div>');
        //calendar 다시 실행시켜야 하는 부분
           $('#calendar').fullCalendar({
                 header: {
                   left: 'prev,next today',
                   center: 'title',
                   right: '' 
                 },
                 defaultDate: currentDate,
                 navLinks: true, // can click day/week names to navigate views
                 selectable: true,
                 selectHelper: true,
                 editable: true,
                 eventLimit: true, // allow "more" link when too many events
                 
                 eventDragStop: function(event,jsEvent) {

                     var trashEl = jQuery('#calendarTrash');
                     var ofs = trashEl.offset();

                     var x1 = ofs.left;
                     var x2 = ofs.left + trashEl.outerWidth(true);
                     var y1 = ofs.top;
                     var y2 = ofs.top + trashEl.outerHeight(true);

                     if (jsEvent.pageX >= x1 && jsEvent.pageX<= x2 &&
                         jsEvent.pageY >= y1 && jsEvent.pageY <= y2) {
                         var message = confirm("정말로 삭제하시겠습니까?");
                         if(message == true){
                            
                            $('#calendar').fullCalendar('removeEvents', event._id);
                         var el = $( "<div class='fc-event'>" ).appendTo( '#external-events-listing' ).text( event.title );
                         
                         el.draggable({
                            zIndex: 999,
                             revert: true,  
                             revertDuration: 0
                            
                         });
                         var a=$(this).attr('class');
                         var b=a.split(' ');
                        var schNum=parseInt(b[5].trim());
                
                         var sendData={
                            'schNum':schNum   
                         };
                     
                  
                         //ajax 사용해서 db에서 지워주기
                         $.ajax({
                            method:'post',
                            url:'deleteSchedule',
                            data:JSON.stringify(sendData1),
                            dataType:'json',
                            contentType:'application/json; charset:utf-8',
                            suceess:function(r){
                               if(r != 1){
                                  alert('삭제 실패');
                               }
                            }
                         });
                         /* code here */
                         ///////////////////////
                         
                         alert('삭제성공!');
                         }else
                            return false;
                     }
                    
                 },
                
                  
                 //************************* 일정 입력란 *********************************
                 //해당 스케줄을 모두 가져와서 for문으로 모두 입력시켜야 함  
             
                 
             
                 events: function(start, end ,timezone, callback) {
               $.ajax({
                 method:'post',
                 url: 'selectUserPlannerSchedule',
                 data:JSON.stringify(sendData),
                 dataType:'json',
                contentType:'application/json;charset=utf-8',
                 success: function(doc) {
                   var events = [];
                   var resources=[];
                   for ( var i in doc) {
                      var update='';
                    update=(doc[i].schEnddate).split('-');
                    
                    
                    //31일 일때
                    if(update[1]==1 && update[1]==3 && update[1]==5 && update[1]==7 && update[1]==8 && update[1]==10 && update[1]==12){
                       if(parseInt(update[2])==31){
                          update[1]=parseInt(update[1])+1;
                          update[2]=1;
                       }else{
                          
                       }
                    }else{
                       if(parseInt(update[0])%4==0 && update[0]==2){ //윤년
                          if(parseInt(update[2]==29)){
                             update[1]=parseInt(update[1])+1;
                             update[2]=1;
                          }else{
                             update[2]=parseInt(update[2])+1;
                          }
                       }else{
                          if(update[2]==30){   //4,6,9,11 월
                             update[1]=parseInt(update[1])+1;
                             update[2]=1;
                          }else{
                             update[2]=parseInt(update[2])+1;
                          }
                       }
                    }
                    doc[i].schEnddate=update[0]+'-'+update[1]+'-'+update[2];
                    //중요도 색상 표시
                    if(doc[i].importance==1){
                       doc[i].importance='azure';
                    }else if(doc[i].importance==2){
                       doc[i].importance='indigo';
                    }else if(doc[i].importance==3){
                       doc[i].importance='purple';
                    }else if(doc[i].importance==4){
                       doc[i].importance='pink';
                    }else if(doc[i].importance==5){
                       doc[i].importance='red';
                    }else if(doc[i].importance==6){
                       doc[i].importance='orange';
                    }else if(doc[i].importance==7){
                       doc[i].importance='yellow';
                    }else if(doc[i].importance==8){
                       doc[i].importance='lime';
                    }else if(doc[i].importance==9){
                       doc[i].importance='green';
                    }else if(doc[i].importance==10){
                       doc[i].importance='teal';
                    }
                 }
                   
                   $.each(doc,function() {
                     events.push({
                      
                       title: $(this).attr('schTitle'),
                       start: $(this).attr('schStartdate'), // will be parsed
                       end:$(this).attr('schEnddate'),  
                       
                       color: $(this).attr('importance'),
                      textColor: 'white' // an option!
                      ,className : [$(this).attr('schNum')]      
                     });        
                   });        
                   callback(events);      
                 }
               });
             }        
                  //****************************************************************
               });
           var tra='<div id="calendarTrash" class="calendar-trash"><img src="resources/calendar/trash.jpg" /></div><br/>';
           $('.fc-right').html(tra);
        
           
        
       /*  var ass = $(".fc-content").parents('a').attr('class');
       alert(ass);  */
       /* var tra='<div id="calendarTrash" class="calendar-trash"><img src="resources/calendar/trash.jpg" /></div><br/>';
         $('.fc-right').html(tra); */
      
       //$(rowtag).parents('.container').parents('.my-md-5').parents('.page-main').parents('.page').remove();
       
   }); 
    
    $(document).on('click','.closeDetail',function(){
       $(this).parents('.card-header').parents('.col-12').parents('.row').parents('.container').parents('.my-md-5').parents('.page-main').parents('.page').remove();
    });
   
    $(document).on('click','.caldown',function(){
         if (e.offsetX > e.target.offsetLeft) {
              alert('ccc');
          }
           else{
             alert('qqq');
         }
    })
    
    $('.caldown').click(function (e) {
        if (e.offsetX > e.target.offsetLeft) {
            alert('ccc');
        }
         else{
           alert('qqq');
       }
        alert('lawrb');
});
    
});


</script>

<style type="text/css">
 #calendar {
         color:black;
        max-width: 900px;
        margin-right : 5%;
        height : 700px;
        width: 50%;
    }
    .card-header{
    width: 200px;
    }
    .card-collapsed{
    width: 200px;
    }
    .card{
    width: 200px;
    }
    .col-xl-4{
    width: 200px;
    }
    
    #map {
   height: 300px;
}
/* Optional: Makes the sample page fill the window. */
html, body {
   height: 100px;
   margin: 0;
   padding: 0;
}

.controls {
   background-color: #fff;
   border-radius: 2px;
   border: 1px solid transparent;
   box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
   box-sizing: border-box;
   font-family: Roboto;
   font-size: 15px;
   font-weight: 2;
   height: 29px;
   margin-left: 17px;
   margin-top: 10px;
   outline: none;
   padding: 0 11px 0 13px;
   text-overflow: ellipsis;
   width: 200px;
}

.controls:focus {
   border-color: #4d90fe;
}

.title {
   font-weight: bold;
}

#infowindow-content {
   display: none;
}

#map #infowindow-content {
   display: inline;
}
#cal{display: flex;}
.col-lg-4{width: 200px; }
.card-header{padding-left:70px;}
.col-lg-4{
padding-left:90px;
width: 300px;}
.col-lg-4{padding-right: 5px; padding-left: 2px;}

.card-header
   {
   display: flex;
   justify-content: space-around;
   }
   .ctitle{align-items: flex-start;}
   .closeimg{align-items: flex-end; }
#plannerInsertBtn{
   float: left;
}
</style>
</head>
<body>
   
         <div class="main-panel">
            <div class="content">
            <div class="container-fluid"><br>
               <div class="row">
                  <div class="course_mark" id="plannerInsertBtn">
                  <a data-rno="${group.groNum}" class="btn btn-success" href="insertPlanner" >プランナー登録</a>
               </div> <br>
               
              <c:forEach var="planner" items="${plannerList }" varStatus="st">
              <div class="col-md-2">
                <div class="card card-collapsed">
                  <div class="card-status bg-blue"></div>
                  <div class="card-header">
                    <h3 class="card-title">${planner.plaTitle}</h3>
                    <div class="card-options">
                      <a href="#" class="card-options-collapse" data-toggle="card-collapse"><i class="fe fe-chevron-up" ></i></a>
                      <a href="#" class="card-options-remove" data-toggle="card-remove"><i class="fe fe-x" ></i></a>
                    </div>
                  </div>
                  <div class="card-body" id="${planner.plaNum}">
                  </div>
                </div>
               </div>
              
             </c:forEach>
         </div>
            </div>
                 
          <div id="cal">
            <div id="calendar" ></div><br/>
            <div class="scheduleUpdate"></div>
             </div>
               </div>
             
                  </div>
      
      
<script src="assets/js/core/bootstrap.min.js"></script>

</body>
 <script  src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAMznx2aLBJ_JHzvyCml6LMwP_yHkigeqc&libraries=places&callback=initMap"
                                    async defer></script>
</html>