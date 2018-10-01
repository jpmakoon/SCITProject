<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../basicFrame.jsp" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <style>
  #drag_wrap {width:500px; height:300px; border: solid 1px #333; }
  #draggable { width: 100px; height: 100px; padding: 0.5em; float: left; margin: 10px 10px 10px 0; border:solid 1px blue;}
  #droppable { width: 150px; height: 150px; padding: 0.5em; float: left; margin: 10px; border:solid 1px red;}
  </style> 
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  $(function(){
	   
	   $('.title').on('click',function(){
	      var schNum=$(this).attr('data-rno');
	      
	      var detail='<a href="scheduleDetail?schNum='+schNum+'">스케줄 자세히</a>';
	      var update='<a href="scheduleUpdate?schNum='+schNum+'">스케줄 변경</a>';
	      var schContent=$(this).parents().children(".content").val();
	      $(this).parents().children('.content').text(schContent);
	      $(this).parents().children('.content').append('<br/>'+detail+'&nbsp'+update);
	   
	   });
	   $('.content').on('click',function(){   
	      $(this).text("");   
	   });
	   
	   
	   $("#insertschedule").on('click',function(){
	      var plaNum=$('#plaNum').val();
	      location.href="insertSchedule?plaNum="+plaNum;
	   });

	////////////////////////////   
	   
	    
			   
			

	       // $(this).removeClass();   //bgi 체인지
	   /* $(".schedule_div").droppable('#garbage_dump',function(){
		  alert('aa'); 
	   }); */
	   $("#garbage_dump").droppable({
		    // the activeClass option specifies the class to add to
		    // the droppable when it is a possible candidate for
		    // a draggable element
		   activeClass: "active",

		    // here we specify the function to be run when the drop event
		    // is triggered.
		    drop: function (event, ui) {
		      alert($(this).attr('id'));
		    }
		  });
	});

 
  </script>
</head>
  <body>
     
         <div class="main-panel">
            <div class="content">
       <table id="table-1">
      <tr>
         <th>스케줄 제목</th>
      </tr>
      <!-- 스케줄 뿌리는 곳 -->
      <c:forEach var="schedule" items="${schdulelist}">
      <tr>
         <td>
            <div class="schedule_div" draggable="true"  />
               <input type="button" class="title" data-rno="${schedule.schNum}" value="${schedule.schTitle}" />
               <input type="hidden" class="content" value="${schedule.schContent}">
               
            <br/>
            <div class="content">
            
            </div>
            </div>
         </td>
      </tr>
      </c:forEach>

   </table>
   <div > 
   <br/>
      <input type="hidden" id="plaNum" value="${plaNum}" />
      <input type="button" id="insertschedule" value="스케줄 생성" /><br/>
      <a href="deletePlanner?plaNum=${plaNum}">플래너 삭제</a>
   </div>
   <img id="garbage_dump" src="resources/images/garbage_dump.png" dropzone="a" >
   </div>
   </div>
<script src="assets/js/core/bootstrap.min.js"></script>
</body>
</html>
