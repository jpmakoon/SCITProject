<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../basicFrame.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>検索結果</title>
</head>
<body>
	<div class="main-panel">
		<div class="content">
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-6">
						<div class="card">
								<div class="card-body">
									<c:if test="${empty list}">
										<div class="card-sub">
											<span id="searchWord">${searchWord}</span>の検索結果なし
										</div>
									</c:if>	
										
									<c:if test="${not empty list}">
										<div class="card-sub">
											<span id="searchWord">${searchWord}</span>の検索結果
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
										<c:forEach var="list" items="${list}">
											<tr>
												<td>
												<a href="userDetail?userId=${list.userId}">
													<div class="searchPhoto">
														<img src="download?userId=${list.userId}">
													</div>
												</a>
												</td>
												<td colspan="2">
													<a href="userDetail?userId=${list.userId}">
													<div id="listTd">
														${list.userName}<br>
														${list.belong}<br>
														${list.phone}
													</div>
													</a>
												</td>
												<td>
													<div id="btnDiv">
														<button class="btn btn-success" id="Freq" name="Freq">友達要請</button>
													</div>
														<input type="hidden" class="accepter" value="${list.userId}">
												</td>
											</tr>
											</c:forEach>
										</tbody>
									</table>
									</c:if>				
								</div>
							</div>
						</div>
					</div>
				</div>		
			</div>
		</div>

<script>
$(function(){
 	friendCheck();
		
	function friendCheck(){
		$('.accepter').each(function(){
			var idList = $(this).val();
			
			$.ajax({
				method : 'post'
				, url : 'friCheck'
				, data : idList
				, contentType : 'application/json; charset=UTF-8'
				, success : function(response){
					if(response == "0") {	//내가 친구 요청함
						$('#Freq').html('要請しています').prop("disabled", true).removeClass('btn-success').addClass('btn-danger');
					}
					if(response == "1") {	//친구인 사람
						$('#Freq').remove();
					}
					if(response == "2") {	//누가 나한테 친구요청함
						var acceptBtn = '<input type="button" id="acceptBtn" class="btn btn-success" value="承知">';
						var refuseBtn = '<button class="btn btn-danger" id="refuseBtn">拒絶</button>';
						$('#btnDiv').html(acceptBtn +'&nbsp;'+ refuseBtn);
					}
				}
			})
		});
	};
	
	$('tr').hover(function(){
		$(this).css("background-color","#bfc3c9");
 	}, function() {
 		$(this).css("background-color","#ffffff");
 	});
});
$(document).on("click", "#Freq", function(){
	if(!confirm("要請しますか？")){
		return false;
	}else{
		var friAccepter = $(this).parent().parent().children('.accepter').val();
		var sendData = {"friAccepter" : friAccepter}
		$.ajax({
			method : 'post'
			, url : 'friRequest'
			, data : JSON.stringify(sendData)
			, dataType : 'text'
			, contentType : 'application/json; charset=UTF-8'
			, success : function(response){
				if(response == 1){
					alert('要請完了');
					$('#btnDiv').remove();
				}else{
					alert('친구신청이 실패하였습니다.');
				}
			}
		});
	}
});

$(document).on("click", "#acceptBtn", function(){
	if(!confirm("承知？")){
		return false;
	}else{
		var friRequester = $(this).parent().parent().children('.accepter').val();
		var sendData = {"friRequester" : friRequester}
		
		$.ajax({
			method : 'post'
			, url  : 'friAccept'
			, data : JSON.stringify(sendData)
			, dataType : 'text'
			, contentType : 'application/json; charset=UTF-8'
			, success : function(response){
				if(response == 1){
					alert("登録完了");
					$('#btnDiv').remove();
				}
			}
		})
	}
});

$(document).on("click", "#refuseBtn", function(){
	if(!confirm("拒絶しますか？")){
		return false;
	}else{
		var friRequester = $(this).parent().parent().children('.accepter').val();
		var sendData = {"friRequester" : friRequester}
		
		$.ajax({
			method : 'post'
			, url  : 'friDelete'
			, data : JSON.stringify(sendData)
			, dataType : 'text'
			, contentType : 'application/json; charset=UTF-8'
			, success : function(response){
				if(response == 1){
					$('#btnDiv').html('<button class="btn btn-success" id="Freq" name="Freq">友達要請</button>');
					alert("拒絶完了");
				}
			}
		})
	}
});

</script>
</body>
</html>