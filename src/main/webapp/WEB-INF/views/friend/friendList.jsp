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
											友達要請なし
										</div>
									</c:if>
									<c:if test="${not empty requestList}">
										<div class="card-sub">
											友達要請リスト
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
													<a href="userDetail?userId=${requestList.userId}">
													<div id="listTd">
														${requestList.userName}<br>
														${requestList.belong}<br>
														${requestList.phone}
													</div>
													</a>
												</td>
												<td>
													<div id="btnDiv">
														<input type="button" id="acceptBtn" class="btn btn-success" value="承知">
														<button class="btn btn-danger" id="refuseBtn">拒絶</button>
													</div>
														<input type="hidden" class="accepter" value="${requestList.userId}">
												</td>
											</tr>
											</c:forEach>
										</tbody>
									</table>
									</c:if>
								</div> <!-- requestList body -->
								
								<div class="card-body">
									<c:if test="${empty friList}">
										<div class="card-sub">
											友達なし
										</div>
									</c:if>
									
 									<c:if test="${not empty friList}">
										<div class="card-sub">
											友達リスト
										</div>
										<table class="table mt-3">
										<thead>
											<tr>
												<th scope="col"><i class="la la-drupal" id="buddyIcon"></i></th>
												<th scope="col" colspan="2">名前</th>
												<th></th>
											</tr>
										</thead>
										<tbody>
										<c:forEach var="friList" items="${friList}">
											<tr>
												<td>
													<div class="searchPhoto">
<<<<<<< HEAD
														<img src="download?${friList.originalImage}">
=======
														<img src="download?userId=${friList.userId}">
>>>>>>> dev
													</div>
												</td>
												<td colspan="2">
													<a href="userDetail?userId=${friList.userId}">
													<div id="listTd">
														${friList.userName}<br>
														${friList.belong}<br>
														${friList.phone}
													</div>
													</a>
												</td>
												<td>
													<div id="btnDiv">
														<button class="btn btn-danger" id="refuseBtn">友達削除</button>
														<button class="btn btn-warning" id="messageBtn">メッセージ</button>
													</div>
														<input type="hidden" class="accepter" value="${friList.userId}">
												</td>
											</tr>
											</c:forEach>
										</tbody>
									</table>
									</c:if> 
								</div> <!-- friList body -->
							</div> 
						</div>
						<div class="col-md-6">
							<div class="card">
								<div class="card-body">
									<c:if test="${empty msgList}">
										<div class="card-sub">
											メッセージなし
										</div>
									</c:if>
									<c:if test="${not empty msgList}">
										<div class="card-sub">
											メッセージリスト
										</div>
										<div class="msgitem">
											<c:forEach var="msgList" items="${msgList}">
											<div class="item">
												<div class="msgdetails">
													<div class="msgname">${msgList.userA}</div>
													<div class="msgtime">${msgList.mesRegdate}</div>
													<div class="msgdescription">${msgList.mesContext}</div>
													<div id="btnDiv">
														<button class="btn btn-danger" id="deleteBtn">削除</button>
													</div>
													<input type="hidden" class="accepter" value="${msgList.mesNum}">
												</div>
											</div>
											</c:forEach>
										</div>
									</c:if>
								</div>
						</div>
					</div>
				</div>		
			</div>
		</div>
	</div>
<script type="text/javascript" src="resources/sockjs-0.3.4.js"></script>
<script type="text/javascript">
var userId = '<c:out value="${sessionScope.loginId}"/>';

$(function() {
	connect();
});
//소켓 스크립트
function connect() {
	sock = new SockJS("<c:url value="/echo"/>");
	sock.onopen = function() {
		
		sock.send(":::"+userId);
		console.log('open');
	};
	sock.onmessage = function(evt) {
		var data = evt.data;
		var strArray  = data.split('-');
		var message = strArray[0];
		var receiveuserid   = strArray[1];
		var senduserid   = strArray[2];
		var date      = strArray[3];
		chatOneAppend(message, senduserid, receiveuserid, date);
	};
	sock.onclose = function() {
		console.log('close');
	};
}
$(document).on('click', '#messageBtn', function(){
 	var receiveuserid = $(this).parents().parents().children('.accepter').val();
	chatOneConnect(receiveuserid);	
});
function chatOneConnect(receiveuserid){
	var url = 'messageList?receiveuserid='+receiveuserid;
	var openWin = window.open(url, 'testWindow', 'width=450, height=350, scrollbars=no');
}
function chatOneAppend(msg, senduserId, receiveuserid, date){
	var url = 'messageList?senduserId='+senduserId+'&receiveuserid='+receiveuserid+'&msg='+msg+'&date='+date;
	var openWin = window.open(url, 'testWindow', 'width=450, height=380, scrollbars=no');
}
function send(msg) {
	sock.send(msg + "-" + userId);
}
/* ================================================================================================== */
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
	var friRequester = $(this).parent().parent().children('.accepter').val();
	var sendData = {"friRequester" : friRequester}
	$(this).parent().parent().parent().fadeOut(1500);
	
	$.ajax({
		method : 'post'
		, url  : 'friAccept'
		, data : JSON.stringify(sendData)
		, dataType : 'text'
		, contentType : 'application/json; charset=UTF-8'
		, success : function(response){
			if(response == 1){
				alert("登録完了");
				location.href="friendList";
			}else{
				alert('다시 시도해주세요');
			}
		}
	})
}
});

$(document).on("click", "#refuseBtn", function(){
	if(!confirm("拒絶しますか?")){
		return false;
	}else{
		var friRequester = $(this).parent().parent().children('.accepter').val();
		var sendData = {"friRequester" : friRequester}
		
		$(this).parent().parent().parent().fadeOut(1500);
		
		$.ajax({
			method : 'post'
			, url  : 'friDelete'
			, data : JSON.stringify(sendData)
			, dataType : 'text'
			, contentType : 'application/json; charset=UTF-8'
			, success : function(response){
				if(response == 1){
					alert("拒絶完了");
				}else{
					alert('다시 시도해주세요');
				}
			}
		})
	}
});
$(document).on("click", "#deleteBtn", function(){
	if(!confirm("削除しますか")){
		return false;
	}else{
		var messageNum = $(this).parent().parent().children('.accepter').val();
		var sendData = {"messageNum" : messageNum}
		
 		$(this).parent().parent().parent().fadeOut(1500);
		
		$.ajax({
			method : 'post'
			, url  : 'msgDelete'
			, data : messageNum
			, dataType : 'text'
			, contentType : 'application/json; charset=UTF-8'
			, success : function(response){
				if(response == 1){
					alert("削除完了");
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