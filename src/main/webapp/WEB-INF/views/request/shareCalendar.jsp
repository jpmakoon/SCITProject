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

   <link rel="stylesheet" href="resources/assets/css/bootstrap.min.css">
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
      
     $('#calendar').remove();
      $('#cal').html('<div id="calendar"></div> <div class="scheduleUpdate"></div>');
     var fullDate = new Date();
     var twoDigitMonth = ((fullDate.getMonth().length+1) === 1)?(fullDate.getMonth()+1) : '0' + (fullDate.getMonth()+1);
     var currentDate = fullDate.getFullYear()+"-"+twoDigitMonth+ "-" +fullDate.getDate();


     var friendId=$("#requester").val();


     var sendData={'userId':friendId};
       
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
                 url:'selectMixSchedule',
                 data:JSON.stringify(sendData),
                 dataType:'json',
                 contentType:'application/json;charset=utf-8',
                 success:function(doc) {
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
     
        
             
             //****************************************************************
          });
      $(function(){
         $(document).on('click','.fc-event-container',function(){
                var sch=$(this).children('a').attr('class');
                var schNum=parseInt(sch.substring(57,sch.length-13));
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
                       inputData += '</div><div class="card-body"><div class="row"><div class="col-md-6 col-lg-4"><div class="form-group">';
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
         $(document).on('click','.closeDetail',function(){
              $(this).parents('.card-header').parents('.col-12').parents('.row').parents('.container').parents('.my-md-5').parents('.page-main').parents('.page').remove();
           });
      });
 $(function(){
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
 });
 $(function(){
	  $(document).on('click','#updateSchedule',function(){
	      var num=$(this).attr('data-rno');
	      var friId=$(this).parents('.container').children('.friId').val();
	      nums=num.split(',');
	      var schNum=nums[0];      var plaNum=nums[1];
	      
	      location.href="scheduleUpdate?schNum="+schNum+"&plaNum="+plaNum+"&friId="+friId;
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
  
<style type="text/css">
.card-title{color: black;
font-size: 20px;}
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
   
         <div class="main-panel" >
            <div class="content"  >
                <!-- 선택할 친구를 불러올 수있게 -->
   
   <input type="hidden" id="requester" value="${req.requester}">


   <div id="cal">
            <div id="calendar"></div><br/>
            <div class="scheduleUpdate"></div>

  
   </div>
   </div>
</div>
<script src="assets/js/core/bootstrap.min.js"></script>
</body>
</html>