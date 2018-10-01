<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../basicFrame.jsp" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Lingua project">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="group/styles/bootstrap4/bootstrap.min.css">
<link href="group/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="group/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="group/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="group/plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" type="text/css" href="group/styles/courses.css">
<link rel="stylesheet" type="text/css" href="group/styles/courses_responsive.css">
<script type="text/javascript">
$(function(){
	$('.applyUser').on('click',function(){
		var groNum=$(this).attr('data-rno'); //모임장의 userId
		var sendData={'groNum':groNum};
		
		//이미 가입된 모임일때 경고창 표시, 이미 가입신청을 눌렀을 때 경고창 표시,컨트롤러에서 유효성 검사가 끝나면 T_GREQUEST 테이블을 생성시킴.(groNum으로 불러오고 생성시키도록.)
		$.ajax({
			method:'post',
			url:'checkGrequest',
// 			data:JSON.stringify(sendData),
			dataType:'json',
			contentType:'application/json;charset=utf-8',
			success:function(r){
				if(r==0){
					alert('해당 그룹에 방장입니다..');
				}else if(r==2){
					alert('이미 가입신청을 눌렀습니다.');
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
							if(res==1){
								alert('가입신청이 되었습니다.');
							}	
						}
					});//ajax_insertGrequest
				}//else if(r==1)
			}//function
		});//ajax_checkGrequest
	});//on Click
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
                     <div class="course_title"><a href="groupDetail?groNum=${group.groNum}">${group.groName}</a></div>
                     <div class="course_info">
                        <ul>
                       
                           <li><a href="instructors.html">그룹 장 : ${group.userId}</a></li>
                         
                        </ul>
                     </div>
                     <div class="course_text">
                        <p>${group.groIntro}</p>
                     </div>
                  </div>
                  <div class="course_footer d-flex flex-row align-items-center justify-content-start">
                     <div class="course_students"><i class="fa fa-user" aria-hidden="true"></i><span>${group.userCount}</span></div>
                
                     
                     <c:forEach var="applyList" items="${applyList}" varStatus="st">
                     
                     <c:if test="${group.groNum != applyList}">
                     
                     <div class="course_mark trans_200"><a data-rno="${group.groNum}" class="applyUser" href="#" >가입신청</a></div>
                  	</c:if>
                  	</c:forEach>
                  	
                  	<c:forEach var="applyList" items="${applyList}" varStatus="st">
                  	
                  	
                     <c:if test="${group.groNum == applyList}">
                     <div class="course_mark trans_200"><a data-rno="${group.groNum}" class="#" href="#" >가입 됨</a></div>
                  	</c:if>
                  	</c:forEach>
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