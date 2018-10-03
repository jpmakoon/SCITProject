<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../basicFrame.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <div class="main-panel">
      <div class="content">
         <div class="container-fluid">
            <div class="row">
               <div class="col-md-6">
                  <div class="card">
                        <div class="card-body">
                           <c:if test="${empty requestList}">
                              <div class="card-sub">
                                 공유 요청이 없습니다.
                              </div>
                           </c:if>
                           <c:if test="${not empty requestList}">
                              <div class="card-sub">
                                 공유 요청 리스트입니다.
                              </div>
                              <table class="table mt-3">
                              <thead>
                              </thead>
                              <tbody>
                              <c:forEach var="requestList" items="${requestList}">
                                 <tr>
                                    <td>
                                       <div class="searchPhoto">
                                          <img src="download?originalImage=${requestList.originalImage}+savedImage=${requestList.savedImage}">
                                       </div>
                                    </td>
                                    <td colspan="2">
                                       <div id="listTd">
                                          ${requestList.userName}<br>
                                          ${requestList.belong}<br>
                                          ${requestList.phone}
                                       </div>
                                    </td>
                                    <td>
                                       <div id="btnDiv">
                                          <input type="button" id="acceptBtn"  class="btn btn-success" value="수락">
                                          <button class="btn btn-danger" id="refuseBtn">거절</button>
                                       </div>
                                          <input type="hidden" class="accepter" value="${requestList.userId}">
                                    </td>
                                 </tr>
                                 </c:forEach>
                              </tbody>
                           </table>
                           </c:if>
                        </div> <!-- requestList body -->
                        
                        
                     </div> 
                  </div>
                  
            </div>      
         </div>
      </div>
<script type="text/javascript" src="resources/sockjs-0.3.4.js"></script>
<script type="text/javascript">
var userId = '<c:out value="${sessionScope.loginId}"/>';


$(function(){
   $('tr').hover(function(){
      $(this).css("background-color","#bfc3c9");
      }, function() {
         $(this).css("background-color","#ffffff");
      });
});

$(document).on("click", "#acceptBtn", function(){
if(!confirm("수락하시겠습니까?")){
   return false;
}else{
   var requester = $(this).parent().parent().children('.accepter').val();
   var sendData = {"requester" : requester}
   $(this).parent().parent().parent().fadeOut(1500);
   
   $.ajax({
      method : 'post'
      , url  : 'calendarAccept'
      , data : JSON.stringify(sendData)
      , dataType : 'text'
      , contentType : 'application/json; charset=UTF-8'
      , success : function(response){
         if(response == 1){
            alert(requester+"님과 공유됩니다.");
            $.ajax({
               method : 'post'
                  , url  : 'insertShareShedule'
                  , data : JSON.stringify(sendData)
                  , dataType : 'text'
                  , contentType : 'application/json; charset=UTF-8'
                  , success:function(r){
                     if(r==1){
                        alert('공유스케줄이 생성되었습니다.');
                     }
                  }
            });
         }else{
            alert('다시 시도해주세요');
         }
      }
   })
}
});

$(document).on("click", "#refuseBtn", function(){
   if(!confirm("삭제하시겠습니까?")){
      return false;
   }else{
      var requester = $(this).parent().parent().children('.accepter').val();
      var sendData = {"requester" : requester}
      
      $(this).parent().parent().parent().fadeOut(1500);
      
      $.ajax({
         method : 'post'
         , url  : 'delShareCal'
         , data : JSON.stringify(sendData)
         , dataType : 'text'
         , contentType : 'application/json; charset=UTF-8'
         , success : function(response){
            if(response == 1){
               alert("완료되었습니다.");
            }else{
               alert('다시 시도해주세요');
            }
         }
      })
   }
});

</script>
</body>
</html>