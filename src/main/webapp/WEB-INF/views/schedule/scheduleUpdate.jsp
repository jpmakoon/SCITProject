<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page import="java.util.Date" %>
    <%@ page import="java.text.SimpleDateFormat" %>
    <%
    Date nowTime=new Date();
    SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
    %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- Dashboard Core -->
<link href="schduleResist/dist/assets/css/dashboard.css"
   rel="stylesheet">
<script src="schduleResist/dist/assets/js/dashboard.js"></script>

<script type="text/javascript" src="resources/jquery-3.3.1.min.js"></script>
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


<style>
/* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
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
</style>




<script type="text/javascript">

   function checkSchedule() {
      var title=$("#schTitle").val();// #은 아이디, .은 클래스
      var content=$("#schContent").val();
      var startDate=$("#schStartdate").val();
      var endDate=$("#schEnddate").val();
      var importance=$(".colorinput-input");
      /* var shareable=$("#shareable"); */
      var category=$(".selectgroup-input");
      var location=$("#schLocation").val();
      
      if ($("#shareable").is(":checked")){
         $("#shareable").val("1");
         
      }
      else{
         $("#shareable").val("0");
      }
   
      
      if (title.trim().length==0){
         alert("제목을 입력해주세요")
         return false;
      }
      
      if(content.trim().length==0){
         alert("내용을 입력해주세요");
         
         return false;
      }
      
       /* for(var i=0; i<importance.length; i++){
         if(importance[i].checked==true){
            $("#importance").val(importance[i].value);   
            
         }
      }  */
       
      /* var importancecheck = $('input[name="importance"]:checked').val();
      alert(importancecheck);
      
      var categorycheck = $('input[name="category"]:checked').val();
      alert(categorycheck); */
      
      /* for(var i=0; i<category.length; i++){
         if(category[i].checked==true){
            $("#category").val(category[i].value);
         }
      } */
      
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
      
      if($(':radio[name="importance"]:checked').length < 1){
          alert('중요도를 선택해주세요');
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
      
      if($(':radio[name="category"]:checked').length < 1){
          alert('카테고리를 선택해주세요');
          return false;
      }
      
      
      /* if(shareable.checked==true){
         shareable.value="1";
      }
      
      if(shareable.checked!=true){
         shareable.value="0";
      }
       */
      if(location.trim().length==0){
         alert('지역를 입력해주세요.');
         return false;
      }
         
   }
   
   

</script>
<script type="text/javascript">
$(function(){
   var title=$("#hiddenschTitle").val();

    $('#schTitle').val(title);
   
   //document.getElementById("schTitle").innerHTML = title;
   var con=$("#hiddenschContent").val();
   
   document.getElementById("schContent").innerHTML = con;
   var startdate=$("#hiddenstartdate").val();
   var endDate=$("#hiddenendDate").val();
   $('#schStartdate').val(startdate);
   $('#schEnddate').val(endDate);
   
});
   

</script>
<title>スケジュール修正</title>
</head>
<body>
   <div class="page">
      <div class="page-main">

         <div class="my-3 my-md-5">
            <div class="container">
               <div class="row">
                  <div class="col-12">
                     <form action="scheduleUpdate" method="post" onsubmit="return checkSchedule()">
                        <div class="card-header">
                           <h3 class="card-title">タイトル</h3>
                        </div>
                        <div class="card-body">
                           <div class="row">
                              <div class="col-md-6 col-lg-4">

                                 <div class="form-group">
                                    <label class="form-label">タイトル</label> 
                                    <input type="text" id="schTitle" class="form-control" name="schTitle" value="" />                                       
                                 </div>
                                 <input type="hidden" id="plaNum" name="plaNum" value="${schedule.plaNum}">
                                 <input type="hidden" id="schNum" name="schNum" value="${schedule.schNum}">

                                 <br>
                                 <div class="form-group">
                                    <label class="form-label">内容 <span
                                       class="form-label-small"> </span></label>
                                    <textarea class="form-control" id="schContent" name="schContent" rows="6"  ></textarea>
                                       <input type="hidden" id="hiddenschContent" value="${schedule.schContent}">
                                      <input type="hidden" id="hiddenschTitle" value="${schedule.schTitle}">
                                      <input type="hidden" id="hiddenstartdate" value="${schedule.schStartdate}">
                                      <input type="hidden" id="hiddenendDate" value="${schedule.schEnddate}">
                                 </div>
                                 
                                  

                                 <div class="form-group">
                                    <label class="form-label">重要度</label>
             
                                    <div class="row gutters-xs">    
                                    <c:if test="${schedule.importance!=1 }">                           
                                       <div class="col-auto">
                                          <label class="colorinput"> <input name="importance"
                                             type="radio" value="1" class="colorinput-input"  >
                                             <span class="colorinput-color bg-azure">1</span>
                                          </label>
                                       </div>
                                       </c:if>
                                         <c:if test="${schedule.importance==1 }">
                                       <div class="col-auto">
                                          <label class="colorinput"> <input name="importance"
                                             type="radio" value="1" class="colorinput-input" checked="checked"  >
                                             <span class="colorinput-color bg-azure">1</span>
                                          </label>
                                       </div>
                                       </c:if>
                                       <c:if test="${schedule.importance==2}">
                                       <div class="col-auto">
                                          <label class="colorinput"> <input name="importance"
                                             type="radio" value="2" class="colorinput-input"> 
                                             <span
                                             class="colorinput-color bg-indigo">2</span>
                                          </label>
                                       </div>
                                       </c:if>
                                          <c:if test="${schedule.importance==2 }">
                                       <div class="col-auto">
                                          <label class="colorinput"> <input name="importance"
                                             type="radio" value="2" class="colorinput-input" checked="checked"> 
                                             <span
                                             class="colorinput-color bg-indigo">2</span>
                                          </label>
                                       </div>
                                       </c:if>
                                       <c:if test="${schedule.importance!=3}">   
                                       <div class="col-auto">
                                          <label class="colorinput"> <input name="importance"
                                             type="radio" value="3" class="colorinput-input">
                                             <span class="colorinput-color bg-purple">3</span>
                                          </label>
                                       </div>
                                       </c:if>
                                          <c:if test="${schedule.importance==3 }">
                                       <div class="col-auto">
                                          <label class="colorinput"> <input name="importance"
                                             type="radio" value="3" class="colorinput-input" checked="checked">
                                             <span class="colorinput-color bg-purple">3</span>
                                          </label>
                                       </div>
                                       </c:if>
                                       <c:if test="${schedule.importance!=4 }">   
                                       <div class="col-auto">
                                          <label class="colorinput"> <input name="importance"
                                             type="radio" value="4" class="colorinput-input">
                                             <span class="colorinput-color bg-pink">4</span>
                                          </label>
                                       </div>
                                       </c:if>
                                         <c:if test="${schedule.importance==4 }">
                                       <div class="col-auto">
                                          <label class="colorinput"> <input name="importance"
                                             type="radio" value="4" class="colorinput-input" checked="checked">
                                             <span class="colorinput-color bg-pink">4</span>
                                          </label>
                                       </div>
                                       </c:if>
                                       <c:if test="${schedule.importance!=5 }">   
                                       <div class="col-auto">
                                          <label class="colorinput"> <input name="importance"
                                             type="radio" value="5" class="colorinput-input">
                                             <span class="colorinput-color bg-red">5</span>
                                          </label>
                                       </div>
                                       </c:if>
                                            <c:if test="${schedule.importance==5 }">
                                       <div class="col-auto">
                                          <label class="colorinput"> <input name="importance"
                                             type="radio" value="5" class="colorinput-input" checked="checked">
                                             <span class="colorinput-color bg-red">5</span>
                                          </label>
                                       </div>
                                       </c:if>
                                       <c:if test="${schedule.importance!=6 }">   
                                       <div class="col-auto">
                                          <label class="colorinput"> <input name="importance"
                                             type="radio" value="6" class="colorinput-input">
                                             <span class="colorinput-color bg-orange">6</span>
                                          </label>
                                       </div>
                                       </c:if>
                                        <c:if test="${schedule.importance==6 }">
                                       <div class="col-auto">
                                          <label class="colorinput"> <input name="importance"
                                             type="radio" value="6" class="colorinput-input" checked="checked">
                                             <span class="colorinput-color bg-orange">6</span>
                                          </label>
                                       </div>
                                       </c:if>
                                       <c:if test="${schedule.importance!=7 }">   
                                       <div class="col-auto">
                                          <label class="colorinput"> <input name="importance"
                                             type="radio" value="7" class="colorinput-input">
                                             <span class="colorinput-color bg-yellow">7</span>
                                          </label>
                                       </div>
                                       </c:if>
                                        <c:if test="${schedule.importance==7 }">
                                       <div class="col-auto">
                                          <label class="colorinput"> <input name="importance"
                                             type="radio" value="7" class="colorinput-input" checked="checked">
                                             <span class="colorinput-color bg-yellow">7</span>
                                          </label>
                                       </div>
                                       </c:if>
                                       <c:if test="${schedule.importance!=8}">   
                                       <div class="col-auto">
                                          <label class="colorinput"> <input name="importance"
                                             type="radio" value="8" class="colorinput-input">
                                             <span class="colorinput-color bg-lime">8</span>
                                          </label>
                                       </div>
                                       </c:if>
                                         <c:if test="${schedule.importance==8 }">
                                       <div class="col-auto">
                                          <label class="colorinput"> <input name="importance"
                                             type="radio" value="8" class="colorinput-input" checked="checked"> 
                                             <span class="colorinput-color bg-lime">8</span>
                                          </label>
                                       </div>
                                       </c:if>
                                       <c:if test="${schedule.importance!=9 }">   
                                       <div class="col-auto">
                                          <label class="colorinput"> <input name="importance"
                                             type="radio" value="9" class="colorinput-input">
                                             <span class="colorinput-color bg-green">9</span>
                                          </label>
                                       </div>
                                       </c:if>
                                       <c:if test="${schedule.importance==9 }">
                                       <div class="col-auto">
                                          <label class="colorinput"> <input name="importance"
                                             type="radio" value="9" class="colorinput-input" checked="checked">
                                             <span class="colorinput-color bg-green">9</span>
                                          </label>
                                       </div>
                                       </c:if>
                                       <c:if test="${schedule.importance!=10 }">   
                                       <div class="col-auto">
                                          <label class="colorinput"> <input name="importance"
                                             type="radio" value="10" class="colorinput-input">
                                             <span class="colorinput-color bg-teal">10</span>
                                          </label>
                                       </div>
                                       </c:if>
                                          <c:if test="${schedule.importance==10 }">
                                       <div class="col-auto">
                                          <label class="colorinput"> <input name="importance"
                                             type="radio" value="10" class="colorinput-input" checked="checked">
                                             <span class="colorinput-color bg-teal">10</span>
                                          </label>
                                          
                                       </div>
                                       </c:if>
                                     
                                      
                                       <!-- <input type="hidden"  id="importance" name="importance" value=""> -->
                                    </div>
                                 </div>
                              




                              </div>
                        
                              <div class="col-md-6 col-lg-4">

                                 <div class="form-group">
                                    <label class="form-label">시작 날짜</label>
                                    <div class="row gutters-xs">
                                      <input type="date" class="form-control" name="schStartdate"  id="schStartdate" />
                                 
                                    </div>
                                 </div>

                                 <div class="form-group">
                                    <label class="form-label">끝나는 날짜</label>
                                    <div class="row gutters-xs">
                                      <input type="date" class="form-control" name="schEnddate"  id="schEnddate" />
                                    </div>
                                 </div>

                                 <div class="form-group">
                                    <label class="form-label">카테고리</label>
                                    <div class="selectgroup selectgroup-pills">
                                    <c:if test="${schedule.category eq 'Beer'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Beer" name="category"
                                          class="selectgroup-input" checked="checked"> <span
                                          class="selectgroup-button">Beer</span>
                                       </label> 
                                    </c:if>
                                    <c:if test="${schedule.category ne 'Beer'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Beer" name="category"
                                          class="selectgroup-input" > <span
                                          class="selectgroup-button">Beer</span>
                                       </label> 
                                       </c:if>
                                       <c:if test="${schedule.category eq 'Date'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio" value="Date" name="category"
                                          class="selectgroup-input" checked="checked"> <span
                                          class="selectgroup-button">Date</span>
                                       </label> 
                                       </c:if>
                                       <c:if test="${schedule.category ne 'Date'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio" value="Date" name="category"
                                          class="selectgroup-input" > <span
                                          class="selectgroup-button">Date</span>
                                       </label> 
                                       </c:if>
                                         <c:if test="${schedule.category eq 'Driving'}">
                                     <label class="selectgroup-item"> <input
                                          type="radio"  value="Driving" name="category"
                                          class="selectgroup-input" checked="checked"> <span
                                          class="selectgroup-button">Driving</span>
                                       </label> 
                                       </c:if>
                                       <c:if test="${schedule.category ne 'Driving'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Driving" name="category"
                                          class="selectgroup-input" > <span
                                          class="selectgroup-button">Driving</span>
                                       </label> 
                                       </c:if>
                                       <c:if test="${schedule.category eq 'Event'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Event" name="category"
                                          class="selectgroup-input" checked="checked"> <span
                                          class="selectgroup-button">Event</span>
                                       </label> 
                                       </c:if>
                                        <c:if test="${schedule.category ne 'Event'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Event" name="category"
                                          class="selectgroup-input" > <span
                                          class="selectgroup-button">Event</span>
                                       </label> 
                                       </c:if>
                                       <c:if test="${schedule.category eq 'Exercise'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Exercise" name="category"
                                          class="selectgroup-input" checked="checked"> <span
                                          class="selectgroup-button">Exercise</span>
                                       </label> 
                                       </c:if>
                                       <c:if test="${schedule.category ne 'Exercise'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Exercise" name="category"
                                          class="selectgroup-input" > <span
                                          class="selectgroup-button">Exercise</span>
                                       </label> 
                                       </c:if>
                                        <c:if test="${schedule.category eq 'Family'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Family" name="category"
                                          class="selectgroup-input" checked="checked"> <span
                                          class="selectgroup-button">Family</span>
                                       </label> 
                                       </c:if>
                                       <c:if test="${schedule.category ne 'Family'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Family" name="category"
                                          class="selectgroup-input" > <span
                                          class="selectgroup-button">Family</span>
                                       </label> 
                                       </c:if>
                                        <c:if test="${schedule.category eq 'Friendship'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Friendship" name="category"
                                          class="selectgroup-input" checked="checked"> <span
                                          class="selectgroup-button">Friendship</span>
                                       </label> 
                                       </c:if>
                                       <c:if test="${schedule.category ne 'Friendship'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Friendship" name="category"
                                          class="selectgroup-input" > <span
                                          class="selectgroup-button">Friendship</span>
                                       </label> 
                                       </c:if>
                                        <c:if test="${schedule.category eq 'Game'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Game" name="category"
                                          class="selectgroup-input" checked="checked"> <span
                                          class="selectgroup-button">Game</span>
                                       </label> 
                                       </c:if>
                                       <c:if test="${schedule.category ne 'Game'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Game" name="category"
                                          class="selectgroup-input" > <span
                                          class="selectgroup-button">Game</span>
                                       </label> 
                                       </c:if>
                                       <c:if test="${schedule.category eq 'Healing'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio" value="Healing" name="category"
                                          class="selectgroup-input" checked="checked"> <span
                                          class="selectgroup-button">Healing</span>
                                       </label> 
                                       </c:if>
                                       <c:if test="${schedule.category ne 'Healing'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio" value="Healing" name="category"
                                          class="selectgroup-input" > <span
                                          class="selectgroup-button">Healing</span>
                                       </label> 
                                       </c:if>
                                          <c:if test="${schedule.category eq 'Meal'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Meal" name="category"
                                          class="selectgroup-input" checked="checked"> <span
                                          class="selectgroup-button">Meal</span>
                                       </label> 
                                       </c:if>
                                       <c:if test="${schedule.category ne 'Meal'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Meal" name="category"
                                          class="selectgroup-input" > <span
                                          class="selectgroup-button">Meal</span>
                                       </label> 
                                       </c:if>
                                         <c:if test="${schedule.category eq 'Movie'}">
										<label class="selectgroup-item"> <input
                                          type="radio"  value="Movie" name="category"
                                          class="selectgroup-input" checked="checked"> <span
                                          class="selectgroup-button">Movie</span>
                                       </label> 
                                       </c:if>
                                       <c:if test="${schedule.category ne 'Movie'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Movie" name="category"
                                          class="selectgroup-input" > <span
                                          class="selectgroup-button">Movie</span>
                                       </label> 
                                       </c:if>
                                        <c:if test="${schedule.category eq 'Promise'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio" value="Promise" name="category"
                                          class="selectgroup-input" checked="checked"> <span
                                          class="selectgroup-button">Promise</span>
                                       </label> 
                                       </c:if>
                                         <c:if test="${schedule.category ne 'Promise'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio" value="Promise" name="category"
                                          class="selectgroup-input" > <span
                                          class="selectgroup-button">Promise</span>
                                       </label> 
                                       </c:if>
                                        <c:if test="${schedule.category eq 'Reading'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Reading" name="category"
                                          class="selectgroup-input"  checked="checked"> <span
                                          class="selectgroup-button">Reading</span>
                                       </label> 
                                       </c:if>
                                       <c:if test="${schedule.category ne 'Reading'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Reading" name="category"
                                          class="selectgroup-input" > <span
                                          class="selectgroup-button">Reading</span>
                                       </label> 
                                       </c:if>
                                        <c:if test="${schedule.category eq 'Shopping'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Shopping" name="category"
                                          class="selectgroup-input" checked="checked"> <span
                                          class="selectgroup-button">Shopping</span>
                                       </label> 
                                       </c:if>
                                       <c:if test="${schedule.category ne 'Shopping'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Shopping" name="category"
                                          class="selectgroup-input" > <span
                                          class="selectgroup-button">Shopping</span>
                                       </label> 
                                       </c:if>
                                        <c:if test="${schedule.category eq 'Study'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Study" name="category"
                                          class="selectgroup-input" checked="checked"> <span
                                          class="selectgroup-button">Study</span>
                                       </label> 
                                       </c:if>
                                       <c:if test="${schedule.category ne 'Study'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Study" name="category"
                                          class="selectgroup-input" > <span
                                          class="selectgroup-button">Study</span>
                                       </label> 
                                       </c:if>
                                        <c:if test="${schedule.category eq 'Traveling'}">
                                        <label class="selectgroup-item"> <input
                                          type="radio"  value="Traveling" name="category"
                                          class="selectgroup-input" checked="checked"> <span
                                          class="selectgroup-button">Traveling</span>
                                       </label> 
                                       </c:if>
                                       <c:if test="${schedule.category ne 'Traveling'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Traveling" name="category"
                                          class="selectgroup-input" > <span
                                          class="selectgroup-button">Traveling</span>
                                       </label> 
                                       </c:if>
                                        <c:if test="${schedule.category eq 'Working'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Working" name="category"
                                          class="selectgroup-input" value="Beer" checked="checked"> <span
                                          class="selectgroup-button">Working</span>
                                       </label> 
                                       </c:if>
                                       <c:if test="${schedule.category ne 'Working'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio"  value="Working" name="category"
                                          class="selectgroup-input" value="Beer"> <span
                                          class="selectgroup-button">Working</span>
                                       </label> 
                                       </c:if>
                                        <c:if test="${schedule.category eq 'others'}">
                                        <label class="selectgroup-item"> <input
                                          type="radio" value="others" name="category"
                                          class="selectgroup-input" checked="checked" > <span
                                          class="selectgroup-button">others</span>
                                       </label>
                                       </c:if>
                                        <c:if test="${schedule.category ne 'others'}">
                                       <label class="selectgroup-item"> <input
                                          type="radio" value="others" name="category"
                                          class="selectgroup-input" > <span
                                          class="selectgroup-button">others</span>
                                       </label>
                                       </c:if>
                                    <!--    <input type="hidden"  id="category" name="category" value=""> -->
                                    </div>
                                 </div>





                              </div>
                              <div class="col-md-6 col-lg-4">
                                 <label class="form-label">위치</label>
                                 <div class="form-group">
                                    <div class="row gutters-xs">
                                       <div class="col">
                                       <input type="text" class="form-control"
                                        id="schLocation" placeholder="${schedule.schLocation}" name="schLocation" value="${schedule.schLocation }">
                                           </div>
                                            <span class="col-auto">
                                       <button class="btn btn-secondary" type="button"
                                          onclick="initMap()">
                                          <i class="fe fe-search"></i>                                       
                                       </button>
                                        </span>

                                    </div>
                                 </div>

               
                                 <div id="map"></div>
                                 <div id="infowindow-content">
                                    <span id="place-name" class="title"></span> <br> Place
                                    ID <span id="place-id"></span><br> <span
                                       id="place-address"></span>
                                 </div>

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
                                 <script
                                    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAMznx2aLBJ_JHzvyCml6LMwP_yHkigeqc&libraries=places&callback=initMap"
                                    async defer></script>



                                 <br>
                                 <div class="form-group">
                                    <div class="form-label">공유 여부</div>
                                    <c:if test="${schedule.shareable==0}">
                                    <div>
                                       <label
                                          class="custom-control custom-checkbox custom-control-inline">
                                          <input type="checkbox" class="custom-control-input"
                                          name="shareable" value=""  id ="shareable">
                                          <span class="custom-control-label">공유함</span>
                                          
                                       </label>

                                    </div>
                                    </c:if>
                                    <c:if test="${schedule.shareable==1}">
                                    <div>
                                       <label
                                          class="custom-control custom-checkbox custom-control-inline">
                                          <input type="checkbox" class="custom-control-input"
                                          name="shareable" value="" checked="checked" id ="shareable">
                                          <span class="custom-control-label">공유함</span>
                                          
                                       </label>

                                    </div>
                                    </c:if>
                                 </div>


                              </div>
                           </div>
                        </div>
                        <div class="card-footer text-right">
                           <div class="d-flex">
                              <a href="javascript:void(0)" class="btn btn-link">Cancel</a>
                              <input type="submit" class="btn btn-primary ml-auto" value="Schdule update" />
                           </div>
                        </div>
                     </form>

                  </div>



               </div>
            </div>
         </div>
      </div>


   </div>
   
</body>
</html>