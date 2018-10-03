<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../basicFrame.jsp" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" type="text/css" href="group/styles/courses.css">
<link rel="stylesheet" type="text/css" href="group/styles/courses_responsive.css">
<script type="text/javascript">
$(function(){
      $(document).on('click','.applyUser',function(){
         if(!confirm("申請しますか?")){
             return false;
          }else{
         var groNum=$(this).attr('data-rno'); //모임장의 userId
         var sendData={'groNum':groNum};
         //이미 가입된 모임일때 경고창 표시, 이미 가입신청을 눌렀을 때 경고창 표시,컨트롤러에서 유효성 검사가 끝나면 T_GREQUEST 테이블을 생성시킴.(groNum으로 불러오고 생성시키도록.)
         $.ajax({
            method:'post',
            url:'checkGrequest',
             data:JSON.stringify(sendData),
            dataType:'json',
            contentType:'application/json;charset=utf-8',
            success:function(r){
               if(r==0){
                  alert('해당 그룹에 방장입니다..');
               }else if(r==2){
                  alert('申請されています。');
               }else if(r==3){
                  alert('이미 회원이라 신청할 수 없습니다.');
               }else if(r==1){
                  $.ajax({
                     method:'post',
                     url:'insertGrequest',
                     data:JSON.stringify(sendData),
                     dataType:'json',
                     contentType:'application/json;charset=utf-8',
                     success:function(res){
                           alert('申請されました。');
                     }
                  });//ajax_insertGrequest
               }//else if(r==1)
            }//function
         });//ajax_checkGrequest
      }
      });//on Click
   });
</script>
<script type="text/javascript">
$(function(){
   var a=$("#applyList").val();
   var groNums=$("#groupNum").val();
   
   a=a.substring(1,a.length-1);
   var applyList=a.split(', ');
   
   groNums=groNums.substring(1,groNums.length-1);
   var groNum=groNums.split(', ');
   
   
     for (var i = 0; i < groNum.length; i++) {
      $('.group'+parseInt(groNum[i])).html('<a data-rno="'+parseInt(groNum[i])+'" class="applyUser"  href="#" >申請</a>');
      for (var j = 0; j < applyList.length; j++) {
         if(parseInt(groNum[i])==parseInt(applyList[j])){
            $('.group'+parseInt(groNum[i])).html('<a data-rno="'+parseInt(groNum[i])+'" href="groupDetail?groNum='+parseInt(groNum[i])+'" >入場</a>');
            break;
         }       
      }
      
   }   
   
});
</script>
</head>
<body>
   
         <div class="main-panel">
            <div class="content">
            <div class="super_container">

   <!-- Courses -->

   <div class="courses">
      <div class="container">
         <div class="row courses_row">
            <!-- Course -->
            <c:forEach var="group" items="${group}">
            <div class="col-lg-4 course_col">
               <div class="course">
               
               <c:if test="${group.savedImage!=null }">
                  <div class="course_image"><img src="groupDownload?originalImage=${group.originalImage}&groNum=${group.groNum}"alt="" style="width: 358px; height: 240px;" ></div>
                  </c:if>
               <c:if test="${group.savedImage==null }">
               <div class="course_image"><img src="assets/img/profile.jpg"alt="" style="width: 358px; height: 240px;" ></div>
               </c:if>
                   
                  <div class="course_body">
                     <div class="course_title"><h3>${group.groName}</h3></div>
                     <div class="course_info">
                        <ul>
                       
                           <li><a href="#">グループリーダー : ${group.userId}</a></li>
                         
                        </ul>
                     </div>
                     <div class="course_text">
                        <p>${group.groIntro}</p>
                     </div>
                  </div>
                 
                  <div class="course_footer d-flex flex-row align-items-center justify-content-start">
                     <div class="course_students">
                        <i class="fa fa-user" aria-hidden="true"></i><span>${group.userCount}</span>
                     </div>
                    <div class="course_mark"><div class="group${group.groNum}">
                     <input type="hidden" id="applyList" value="${applyList }">
                     <input type="hidden" id="groupNum" value="${groNums}">
                  
                       </div>
                   </div>
                 </div>
               </div>
            </div>
          </c:forEach>
         </div>

         <div class="row">
            <div class="col">
                <div class="load_more_button"><a href="insertGroup">NEW グループ</a></div> 
            </div>
         </div>
      </div>
   </div>

   
</div>

<script src="group/styles/bootstrap4/popper.js"></script>
<script src="group/styles/bootstrap4/bootstrap.min.js"></script>
<script src="group/plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="group/plugins/easing/easing.js"></script>
<script src="group/js/courses.js"></script>
               </div>
            </div>

<script src="assets/js/core/bootstrap.min.js"></script>

</body>
</html>