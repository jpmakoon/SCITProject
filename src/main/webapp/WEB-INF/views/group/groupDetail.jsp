<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../basicFrame.jsp" %>
<!DOCTYPE html>

<html>
<head>
			<link rel="stylesheet" href="groupDetail/css/magnific-popup.css">
			<link rel="stylesheet" href="groupDetail/css/nice-select.css">					
			<link rel="stylesheet" href="groupDetail/css/owl.carousel.css">
			<link rel="stylesheet" href="groupDetail/css/main.css">
		
<link rel="stylesheet" type="text/css" href="group/styles/courses.css">
<link rel="stylesheet" type="text/css" href="group/styles/courses_responsive.css">
		

<script type="text/javascript">
$(function(){
   $(document).on('click','#friendGroupInvite',function(){
      
      var groNum=$(this).attr('data-rno');
      $.ajax({
      method:'post',
      url:'myFriendList',
      contentType:'application/json;charset=utf-8',
      success:function(r){
         var selectData='';
         selectData += '<table style="margin : 0 auto;">';
         selectData += '<tr>';
         selectData += '<td>';
         selectData += '<select style="width: 120px;">';
         for ( var i in r) {
            selectData += '<option class="selectInvite" value="'+r[i]+'" >'+r[i]+'</option>';
         }
         selectData += '</select>';
         selectData += '</td>';
          selectData += '<td><input type="button" id="friendInvite" value="グループ招待"  class="btn btn-info groupBtn" data-rno="'+groNum+'"  ></td>';
         selectData += '</tr>';
         selectData += '</table>';
         
         $(".category-widget1").html(selectData);
      }
   });
   });   
   $(document).on('click','#friendInvite',function(){
      var friends=$(".selectInvite");
      var groNum=$(this).attr('data-rno');
      
      var friend='';
      var inputData='<input type="button" value="グループ招待" id="friendGroupInvite" class="btn btn-info groupBtn" data-rno="'+groNum+'">';
      for (var i = 0; i < friends.length; i++) {
          if(friends[i].selected==true){    
             friend=friends[i].value;
             break;
         } 
      }
   
      var sendData={'gRequester':friend,
                 'groNum':groNum};
      $.ajax({
         method:'post',
         url:'inviteFriend',
         data:JSON.stringify(sendData),
         dataType:'json',
         contentType:'application/json;charset=utf-8',
         success:function(r){
            if(r==1){
               alert('申請されます.');
               
            }else{
               alert('申請されています。');
               
            }
         }
      });
      $(this).parents('.category-widget1').html(inputData);
   });
    $("#boardInsert").on('click',function(){
      var groNum=$('#groNum').val();
      location.href="insertBoard?groNum="+groNum;
   }); 
    $(document).on('click','.boardDetail',function(){
       var boaNum=$(this).children(".boaNum").attr("data-rno");
       var groNum=$(this).children(".groNum").attr("data-rno");
       var boardUserId = $(this).children(".boardUserId").val();
       var originalFile=$(this).children(".originalFile").val();
       var File='<a href="boardDownload?boaNum='+boaNum+'">'+originalFile+'</a>';
       var content=$(this).children(".content").val();
       
       var boardContent='';
       boardContent += '<img alt="" src="resources/close.png" class="deleteBoard" style="float: right;" ><input type="hidden" class="delboaNum" data-rno="'+boaNum+'">';
       boardContent += '<table><tr>';
       boardContent += '<td>作成者</td>';
       boardContent += '<td>'+boardUserId+'</td></tr>';
       boardContent += '<tr><td>内容</td>';
       boardContent += '<td>'+content+'</td></tr>';
       
       
       boardContent += '</tr></table>';
       var sendData={'boaNum':boaNum};
       
       $('.boaNum'+boaNum).html(boardContent);//첨부파일도 올리기...

       $.ajax({
          method:'post',
          url:'selectBoardReply',
          data:JSON.stringify(sendData),
          dataType:'json',
          contentType:'application/json;charset=utf-8',
          success:function(r){
             var replyData='';
             replyData+='<input type="text" class="replyText"><input type="button" class="insertReply" data-rno="'+boaNum+'" value="댓글 달기">';
              replyData+='<table class="replyArea">';
             for (var i in r){
             replyData+='<tr class="'+r[i].repNum+'">';
              replyData+='<td>';
              replyData+=r[i].userId;
              replyData+='</td>';
              replyData+='<td>';
              replyData+=r[i].repText;
              replyData+='</td>';
              replyData+='<td>';
              replyData+=r[i].repRegdate;
              replyData+='</td>';
              replyData+='<td>';
              replyData+='<img src="resources/replyDel.png" class="replyDelete"><input type="hidden" class="delreply" data-rno="'+r[i].repNum+'"/>';
              replyData+='</td>';
              replyData+='</tr>';
             }
             replyData+='</table>';
             
             $('.reply'+boaNum).html(replyData); 
          }
       });
       $(this).removeClass( "boardDetail" ).addClass( "boardDetailOpen" );
    });
    $(document).on('click','.deleteBoard',function(){
       if(!confirm("削除しますか？?")){
          return false;
       }else{
       var boaNum=$(this).parents("p").children('.delboaNum').attr('data-rno');
       var sendData={
             'boaNum':boaNum
       };
       $.ajax({
          method:'post',
          url:'deleteBoard',
          data:JSON.stringify(sendData),
          dataType:'json',
          contentType:'application/json;charset=utf-8',
          success:function(r){
             if(r==1){
                alert('削除されました。.');
                $(".single-post"+boaNum).remove();
             }else{
               alert('삭제 실패');
            }
          }
       });
       }
    });
    $(document).on('click','.replyDelete',function(){
       if(!confirm("削除しますか?")){
          return false;
       }else{
       var repNum=$(this).parents('td').children('.delreply').attr('data-rno');
       var sendData={
             'repNum':repNum
       };
       $.ajax({
          method:'post',
          url:'deleteReply',
          data:JSON.stringify(sendData),
          dataType:'json',
          contentType:'application/json;charset=utf-8',
          success:function(r){
             if(r==1){
                alert('削除されました。');
                $('.'+repNum).remove();
             }
          }
          
       });
       }
    });
    
    $(document).on('click','.boardDetailOpen',function(){
       var boaNum=$(this).children(".boaNum").attr("data-rno");
       
       $('.boaNum'+boaNum).html("");
       $('.reply'+boaNum).html(""); 
       $(this).removeClass( "boardDetailOpen" ).addClass( "boardDetail" );
    });
    
    
    //댓글 출력
    $(document).on('click',".insertReply",function(){
       var boaNum=$(this).attr("data-rno");
       var repText=$(this).parents().children(".replyText").val();
       var replyData='';
       var sendData={
          'repText':repText,
          'boaNum':boaNum
       };
       if(repText.trim().length!=0){
       $.ajax({
          method:'post',
          url:'insertReply',
          data:JSON.stringify(sendData),
          dataType:'json',
          contentType:'application/json;charset=utf-8',
          success:function(r){
             replyData+='<tr class="'+r.repNum+'">';
              replyData+='<td>';
              replyData+=r.userId;
              replyData+='</td>';
              replyData+='<td>';
              replyData+=r.repText;
              replyData+='</td>';
              replyData+='<td>';
              replyData+=r.repRegdate;
              replyData+='</td>';
              replyData+='<td>';
              replyData+='<img src="resources/replyDel.png" class="replyDelete"><input type="hidden" class="delreply" data-rno="'+r.repNum+'"/>';
              replyData+='</td>';
              replyData+='</tr>';
              $(".replyArea").prepend(replyData);
             }
          
       });
       }else {
         alert("댓글을 입력해주세요.");
      }
       var repText=$(this).parents().children(".replyText").val("");
    });
    
    /////////////////
    $(document).on('click','#groupMemberDelete',function(){
       var groNum=$(this).attr("data-rno");
       var sendData={'groNum':groNum};
       $.ajax({
          method:'post',
          url:'groupMemberDelete',
          data:JSON.stringify(sendData),
          dataType:'json',
          contentType:'application/json;charset=utf-8',
          success:function(r){
             if(r==1){
                alert('脱退されました。');
                location.href="groupList";
             }else {
               alert("탈퇴 실패");
            }
          }
       });
    });
    $(document).on('click','#groupDelete',function(){
       if(!confirm("削除しますか?")){
          return false;
       }else{
       var groNum=$(this).attr("data-rno");
       location.href="groupDelete?groNum="+groNum;
       }
    });
    
    //그룹 스케줄 만듦.
   $(document).on('click','#insertGroupSchedule',function(){
       var groNum=$(this).attr("data-rno");
       location.href="insertGroSchedule?groNum="+groNum;
    });
    
    


});

function groupList() {
	location.href="groupList";
}
</script>
</head>
<body>
         <div class="main-panel ">
            <div class="content">
            <div id="groupDiv">
  				<div id="group1Div">
					<div class="col-lg-8 post-list blog-post-list">

						<c:forEach var="board" items="${bList}">
							<div class="single-post${board.boaNum }">
								<c:if test="${board.originalFile == null }">
                        			<img class="img-fluid" src="groupDetail/img/blog/p1.jpg" alt="">
                     			</c:if>
                    			<c:if test="${board.originalFile != null }">
                       				<img src="boardDownload?originalFile=${board.originalFile}&boaNum=${board.boaNum}"alt="" style="width: 450px; height: 200px;" >
                     			</c:if>
								<div>
									<h1 class="boardDetail">
									<input type="hidden" class="originalFile" value="${board.originalFile}">
									<input type="hidden" class="boardUserId" value="${board.userId }"/>
									<input type="hidden" class="groNum" data-rno="${board.groNum}">
									<input type="hidden" class="boaNum" data-rno="${board.boaNum}">
									<input type="hidden" class="content" value="${board.boaContent}">
										${board.boaTitle}
									</h1>
									<div class="conbox">
										<p class="boaNum${board.boaNum}"></p>
										<div class="reply${board.boaNum}">
										</div> 
										<!-- REPLY -->
									</div>
								 </div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div id="group2Div">
					<div class="single-widget protfolio-widget">
						<c:if test="${group.savedImage!=null }">
                 			<div class="course_image"><img src="groupDownload?originalImage=${group.originalImage}&groNum=${group.groNum}"alt="" style="width: 300px;height: 200px;"></div>
                		</c:if>
            			<c:if test="${group.savedImage==null }">
              				<div class="course_image"><img src="assets/img/profile.jpg"alt=""  style="width: 300px;height: 200px;"></div>
             			</c:if>
						<h4>${group.groName}</h4>
						<p style="color: black;">${group.groIntro }	</p>
								  <input type="hidden" id="groNum" value="${group.groNum}"/><br>
								  <input type="button" value="ボードポスト" id="boardInsert" class="btn btn-primary">&nbsp;
								  <div class="category-widget1">
								  <input type="button" value="グループ招待" id="friendGroupInvite" data-rno="${group.groNum}" class="btn btn-info groupBtn">&nbsp;
								  </div>
								  <c:if test="${loginId!=group.userId }">
								 	<input type="button" value="グループ脱退" data-rno="${group.groNum}" id="groupMemberDelete" class="btn btn-danger groupBtn"/>&nbsp;
								  </c:if>
								  <c:if test="${loginId==group.userId }">
								 	<input type="button" value="グループ解散" data-rno="${group.groNum}" id="groupDelete" class="btn btn-warning groupBtn"/>&nbsp;
								  </c:if>
					 </div>
 							<div class="single-widget category-widget">
								<h4 class="title">ユーザーリスト</h4>
								<ul>
									<li><a href="userDetail?userId=${group.userId}" class="justify-content-between align-items-center d-flex"><h6>グループ長　-- ${group.userId}</h6> </a></li>
								<c:forEach var="userList" items="${userList}">
									<li><a href="userDetail?userId=${group.userId}" class="justify-content-between align-items-center d-flex"><h6>${userList.gRequester}</h6> </a></li>
								</c:forEach>								
								</ul>
							</div>			
						</div>				
					</div>
               </div>
            </div>
</body>
</html>