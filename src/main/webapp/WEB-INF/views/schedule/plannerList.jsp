<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@include file="../basicFrame.jsp" %>
 <%
    Date nowTime=new Date();
    SimpleDateFormat sf=new SimpleDateFormat("YYYY-MM-DD");
    %>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" type="text/css" href="group/styles/bootstrap4/bootstrap.min.css">
<link href="group/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="group/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="group/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="group/plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" type="text/css" href="group/styles/courses.css">
<link rel="stylesheet" type="text/css" href="group/styles/courses_responsive.css">

<!-- 캘린더 부분 -->
<link href='resources/calendar/fullcalendar.min.css' rel='stylesheet' />
<link href='resources/calendar/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='resources/lib/moment.min.js'></script>
<script src='resources/calendar/fullcalendar.min.js'></script>

<!-- 각종 버튼들 -->
   
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



<!-- Dashboard Core -->
<link href="schduleResist/dist/assets/css/dashboard.css"
   rel="stylesheet">
<script src="schduleResist/dist/assets/js/dashboard.js"></script>


<script type="text/javascript" charset="utf-8" async=""
   data-requirecontext="_" data-requiremodule="selectize"
   src="schduleResist/dist/assets/js/vendors/selectize.min.js"></script>
<link type="text/css" rel="stylesheet" charset="UTF-8"
   href="https://translate.googleapis.com/translate_static/css/translateelement.css">
<script type="text/javascript" charset="utf-8" async=""
   data-requirecontext="_" data-requiremodule="bootstrap"
   src="schduleResist/dist/assets/js/vendors/bootstrap.bundle.min.js"></script>
<script type="text/javascript" charset="utf-8" async=""
   data-requirecontext="_" data-requiremodule="core"
   src="schduleResist/dist/assets/js/core.js"></script>
<script type="text/javascript" charset="utf-8" async=""
   data-requirecontext="_" data-requiremodule="input-mask"
   src="schduleResist/dist/assets/plugins/input-mask/js/jquery.mask.min.js"></script>
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
		   var fullDate = new Date();
		   var twoDigitMonth = ((fullDate.getMonth().length+1) === 1)?(fullDate.getMonth()+1) : '0' + (fullDate.getMonth()+1);
		   var currentDate = fullDate.getFullYear()+"-"+twoDigitMonth+ "-" +fullDate.getDate();
		  
		   
	      var plaNum=$(this).parents().parents().parents().parents().children(".card-body").attr('id');
	      var sendData={'plaNum':plaNum};
	      var inputData='';
	      inputData+='<input type="button" class="insertSchedule" data-rno="'+plaNum+'" value="스케줄 만들기">';
      		$("#"+plaNum).html(inputData);
	      
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
                        console.log("dd"+a);
                         var b=parseInt(a.substring(57,a.length-13));
                         console.log(b);
                         var sendData={
                            'schNum':b   
                         };
                         console.log(sendData);
                         //ajax 사용해서 db에서 지워주기
                         $.ajax({
                            method:'post',
                            url:'deleteSchedule',
                            data:JSON.stringify(sendData),
                            dataType:'json',
                            contentType:'application/json; charset:utf-8',
                            suceess:function(response){
								if(response == 1){
									alert('削除されました。');
								}
                            }
                         });
                         /* code here */
                         ///////////////////////
                         
                         }
                         else
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
		  var message = confirm("정말로 삭제하시겠습니까?");
		  if(message==true){
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
		  else
			  return false;
	   });
	   
	   $(document).on('click','.insertSchedule',function(){
			var plaNum=$(this).attr("data-rno");
			location.href="insertSchedule?plaNum="+plaNum;
	   });
		//schedule 클릭시 수정
		$(document).on('click','.fc-content',function(){
			
			var sch=$(this).parents('a').attr('class');
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
					inputData +='<div class="card-header"><div class="ctitle"><h3 class="card-title">스케줄 수정</h3></div> <div class="closeimg"><img alt="" src="resources/close.png" class="closeDetail"></div>	';
					inputData += '</div><div class="card-body"><div class="row"><div class="col-md-6 col-lg-4"><div class="form-group">';
					inputData += '<label class="form-label">제목</label> <input type="text" id="schTitle" class="form-control" name="schTitle" placeholder="'+sch.schTitle+'"></div>';   
					inputData +='<input type="hidden" id="plaNum" name="plaNum" value="'+sch.plaNum+'"><input type="hidden" id="schNum" name="schNum" value="'+sch.schNum+'"><br>';
					inputData +='<div class="form-group"> <label class="form-label">내용 <span class="form-label-small">56/100</span></label>';
					inputData +='<textarea class="form-control" id="schContent" name="schContent" rows="6" placeholder="'+sch.schContent+'"></textarea></div>';    
					
					inputData +='</div><div class="col-md-6 col-lg-4"> <div class="form-group"><label class="form-label">시작 날짜</label><div class="row gutters-xs"> <input type="date" class="form-control" name="schStartdate"  id="schStartdate"></div></div>';         
					inputData +='<div class="form-group"><label class="form-label">끝나는 날짜</label><div class="row gutters-xs"><input type="date" class="form-control" name="schEnddate"  id="schEnddate" value="'+sch.schEnddate+'"></div></div>';                                
					/* inputData +='<div class="form-group"><label class="form-label">카테고리</label><div class="selectgroup selectgroup-pills">';	
					var cate=['Beer','Date','Driving','Event','Exercise','Family','Friendship','Game','Healing','Meal','Movie','Promise','Reading','Shopping','Study','Traveling','Working','others'];
	 
					var inputDataCate='';
					for (var i = 0; i < cate.length; i++) {
						inputDataCate += '<label class="selectgroup-item"> <input type="radio"  value="'+cate[i]+'" name="category" class="selectgroup-input" > <span class="selectgroup-button">'+cate[i]+'</span></label>';
					}	
					inputData += inputDataCate;
					inputData +='</div></div></div>'; 
	                                               
					inputData +='<div class="col-md-6 col-lg-4"><label class="form-label">위치</label><div class="form-group"><div class="row gutters-xs"><div class="col">';
					inputData +='<input type="text" class="form-control" id="schLocation" placeholder="'+sch.schLocation+'" name="schLocation"></div>';
					inputData +='<span class="col-auto"><button class="btn btn-secondary" type="button" onclick="initMap()"><i class="fe fe-search"></i></button></span></div></div>';
					inputData +='<div id="map"></div><div id="infowindow-content"><span id="place-name" class="title"></span><br> PlaceID <span id="place-id"></span><br><span id="place-address"></span></div>';
					
				
						
					inputData +='<br><div class="form-group"><div class="form-label">공유 여부</div><div><label class="custom-control custom-checkbox custom-control-inline">';
	                inputData +='<input type="checkbox" class="custom-control-input" name="shareable" value="" checked="" id ="shareable"> <span class="custom-control-label">공유함</span>';
	         	    inputData +='</label></div></div></div></div></div><div class="card-footer text-right"><div class="d-flex"><a href="javascript:void(0)" class="btn btn-link">Cancel</a>';
	             	inputData +='';
	                inputData +='</div></div> */
	                inputData +='<input type="button" data-rno="'+allnum+'" id="updateSchedule2" class="btn btn-primary ml-auto" value="Schdule update"  /><br/>';
	                inputData += '</div></div></div></div></div><input type="button" data-rno="'+allnum+'" id="updateSchedule" class="btn btn-primary ml-auto" value="자세히 수정" /></div>';
	                
	                $('.scheduleUpdate').html(inputData);

				   
				}
			});
			
		});
});
$(function(){
	$(document).on('click','#updateSchedule',function(){
		var num=$(this).attr('data-rno');
		nums=num.split(',');
		var schNum=nums[0];		var plaNum=nums[1];
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
	
		
		var schNum=nums[0];		var plaNum=nums[1];
		
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
	     $('.fc-header-toolbar').remove();
	     $('.fc-view-container').remove();
	     //calendar 다시 실행시켜야 하는 부분
	      
	  
	        
	     
	    /*  var ass = $(".fc-content").parents('a').attr('class');
	    alert(ass);  */
 		/* var tra='<div id="calendarTrash" class="calendar-trash"><img src="resources/calendar/trash.jpg" /></div><br/>';
		   $('.fc-right').html(tra); */
		
	 	//$(rowtag).parents('.container').parents('.my-md-5').parents('.page-main').parents('.page').remove();
	 	
	}); 
 	
 	$(document).on('click','.closeDetail',function(){
 		$(this).parents('.card-header').parents('.col-12').parents('.row').parents('.container').parents('.my-md-5').parents('.page-main').parents('.page').remove();
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
/* #cal{display: flex;} */
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

div.course_mark trans_200{
	position:absolute;
	left:700px;
	top:50px;
}

</style>
</head>
<body>
         <div class="main-panel">
           <div class="content"> 
            <div class="course_mark trans_200" id="plannerInsertBtn" style="position:relative; width:100px; top:50px; left:1000px; ">
            	<a data-rno="${group.groNum}" class="#" href="insertPlanner" >planner 만들기</a>
            </div>
			<br><br>
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
            <br><br><br>
 			<div id="cal">
            	<div id="calendar">
            	</div><br/>
            <div class="scheduleUpdate">
            </div>
          </div>
        </div>
     </div>
</body>
</html>