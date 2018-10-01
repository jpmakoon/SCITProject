<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../basicFrame.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
    

    #calendar {
   		 color:black;
        max-width: 900px;
        margin-right : 5%;
        height : 700px;
        width: 50%;
    }
    #friendCalendar{
     color:black;
       max-width: 900px;
       margin-left : 5%;
       width:50%;
    }
    .allCalendar{
    
   display: flex;
   
   }
     .mixCalendar {
      color:black;
        max-width: 900px;
        margin: 0 auto;
    }
    .content{
    background-color: white;
    }
  

</style>

<!-- 캘린더 부분 -->
<link href='resources/calendar/fullcalendar.min.css' rel='stylesheet' />
<link href='resources/calendar/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='resources/lib/moment.min.js'></script>
<script src="resources/jquery-3.3.1.min.js"></script>
<script src='resources/calendar/fullcalendar.min.js'></script>

<!-- 각종 버튼들 -->
   <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
   <title>Components - Ready Bootstrap Dashboard</title>
   <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
   <link rel="stylesheet" href="resources/assets/css/bootstrap.min.css">
   <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i">
   <link rel="stylesheet" href="resources/assets/css/ready.css">
   <link rel="stylesheet" href="resources/assets/css/demo.css">
   
   <script src="resources/assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
   <script src="resources/assets/js/core/popper.min.js"></script>
   <script src="resources/assets/js/core/bootstrap.min.js"></script>

   <script src="resources/assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>
   <script src="resources/assets/js/plugin/bootstrap-toggle/bootstrap-toggle.min.js"></script>
   <script src="resources/assets/js/plugin/jquery-mapael/jquery.mapael.min.js"></script>
   <script src="resources/assets/js/plugin/jquery-mapael/maps/world_countries.min.js"></script>
   <script src="resources/assets/js/plugin/chart-circle/circles.min.js"></script>
   <script src="resources/assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>
   <script src="resources/assets/js/ready.min.js"></script>
   
      <script>
      $( function() {
         $( "#slider" ).slider({
            range: "min",
            max: 100,
            value: 40,
         });
         $( "#slider-range" ).slider({
            range: true,
            min: 0,
            max: 500,
            values: [ 75, 300 ]
         });
      } );
   </script>
   

<script>
   
 
  
  

  $(document).ready(function(){
     
     
    	  var fullDate = new Date();
   	   var twoDigitMonth = ((fullDate.getMonth().length+1) === 1)?(fullDate.getMonth()+1) : '0' + (fullDate.getMonth()+1);
   	   var currentDate = fullDate.getFullYear()+"-"+twoDigitMonth+ "-" +fullDate.getDate();
    	  
    	  
          var friendId=$("#requester").val();
       
          
         var sendData={'userId':friendId};
     
     
        
        $('.mixCalendar').fullCalendar({
            header: {
              left: 'prev,next today',
              center: 'title',
              right: '' 
            },
            defaultDate: currentDate,
            navLinks: true, // can click day/week names to navigate views
            selectable: true,
            selectHelper: true,
            select: function(start, end) {
              var title = prompt('스케줄 타이틀:');
              
               var content = prompt('스케줄 내용:'); 
              
              var eventData;
              if (title) {
                eventData = {
                 
                  title: title,
                  content: content, 
                  start: start,
                  end: end
                };
                $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
              }
              $('#calendar').fullCalendar('unselect');
            },
            editable: false,
            eventLimit: true, // allow "more" link when too many events
            
          
            
              
             //************************* 일정 입력란 *********************************
             //해당 스케줄을 모두 가져와서 for문으로 모두 입력시켜야 함  
			
            events: function(start, end ,timezone, callback) {
            	
          $.ajax({
              method:'post',
             url:'selectMixSchedule',
             data:JSON.stringify(sendData),
             dataType:'json',
             contentType:'application/json;charset=utf-8',
             success:function(doc){
               
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
       
     
 });
/*   $.ajax({
       method:'post',
       url:'selectMixSchedule',
       data:JSON.stringify(sendData),
       dataType:'json',
       contentType:'application/json;charset=utf-8',
       success:function(s){
          
       }
     }); */

</script>
  
<style>

  body {
    margin: 40px 10px;
    padding: 0;
    font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width: 900px;
    margin: 0 auto;
  }
  
   .fc-day-number.fc-sat.fc-past { color:#0000FF; }
    .fc-day-number.fc-sun.fc-past { color:#FF0000; }

</style>
   
</head>
<body>
	
			<div class="main-panel" >
				<div class="content"  >
					 <!-- 선택할 친구를 불러올 수있게 -->
	
   <input type="hidden" id="requester" value="${req.requester}">


   <div>
      <div class="mixCalendar"></div>
   </div>

  
   

<script src="assets/js/core/bootstrap.min.js"></script>
</body>
</html>