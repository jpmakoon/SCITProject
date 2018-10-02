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
<script src='resources/calendar/fullcalendar.min.js'></script>

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
 });
 
  $(document).ready(function() {
     
	  var fullDate = new Date();
	   var twoDigitMonth = ((fullDate.getMonth().length+1) === 1)?(fullDate.getMonth()+1) : '0' + (fullDate.getMonth()+1);
	   var currentDate = fullDate.getFullYear()+"-"+twoDigitMonth+ "-" +fullDate.getDate();
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
               var b=parseInt(a.substring(57,a.length-13));
               var sendData={
                  'schNum':b   
               };
               //ajax 사용해서 db에서 지워주기
               $.ajax({
                  method:'post',
                  url:'deleteSchedule',
                  data:JSON.stringify(sendData),
                  dataType:'json',
                  contentType:'application/json; charset:utf-8',
                  suceess:function(r){
                     
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
      url: 'selectUserAllSchedule',
      
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
  }); 
  
  
  $(document).ready(function() {
     $('#friendCalendarBtn').on('click',function(){
       var friendIds=$('.friendId');
       var friendId='';
 	  var fullDate = new Date();
	   var twoDigitMonth = ((fullDate.getMonth().length+1) === 1)?(fullDate.getMonth()+1) : '0' + (fullDate.getMonth()+1);
	   var currentDate = fullDate.getFullYear()+"-"+twoDigitMonth+ "-" +fullDate.getDate();
       for (var i = 0; i < friendIds.length; i++) {
		if(friendIds[i].selected==true){
			friendId=friendIds[i].value;
		}
	}
      
     	  
       // 친구의 정보를 가져와서 ajax로 calendar를 가져오게 함.
         var requsetData={'reqAccepter':friendId};
         $.ajax({
       	  method:'post',
       	  url:'calendarShare',
       	  data:JSON.stringify(requsetData),
       	  dataType:'json',
       	  contentType:'application/json; charset=utf-8',
       	  success:function(r){
       		  if(r==1){
       			  alert(friendId+'님에게 공유여부를 보냈습니다.');
       		  }else if (r==0) {
				alert('이미 요청하였습니다.');
			}
       	  }
         });
       
         var sendData={'userId': friendId};
          $('#friendCalendar').fullCalendar({
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
            
          
            
         
            events: function(start, end ,timezone, callback) {
          $.ajax({
            method:'post',
            url: 'selectFriendAllSchedule',
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
        
     });
  });
  $(document).ready(function(){
     
     $('#friendCalendar').on('dragenter',function(){
    	  var fullDate = new Date();
   	   var twoDigitMonth = ((fullDate.getMonth().length+1) === 1)?(fullDate.getMonth()+1) : '0' + (fullDate.getMonth()+1);
   	   var currentDate = fullDate.getFullYear()+"-"+twoDigitMonth+ "-" +fullDate.getDate();
    	  var friendIds=$('.friendId');
    	  
          var friendId='';
          for (var i = 0; i < friendIds.length; i++) {
   		if(friendIds[i].selected==true){
   			friendId=friendIds[i].value;
   		}
   		}
          
         var sendData={'userId':friendId};
         
       $('.allCalendar').remove();
     
        
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
	 <select>
   <c:forEach var="fList" items="${fList }">
      <option class="friendId" value="${fList.friRequester}">${fList.friRequester}</option>
      </c:forEach>
   </select> 
   
   <input type="button" id="friendCalendarBtn" value="calendar 공유">
   <!-- 휴지통 사진 부분 -->
   <div id="calendarTrash" class="calendar-trash"><img src="resources/calendar/trash.jpg" /></div><br/>
   <div class="allCalendar">
   
   <!-- 캘린더 부분 -->
   <!-- login user 캘린더 -->
   <div id='calendar' draggable="true"></div> 
   
   <!-- 친구 캘린더  -->
   <div id="friendCalendar" ></div>
   </div>
   <div>
      <div class="mixCalendar"></div>
   </div>

  </div>
</div>
</body>
</html>