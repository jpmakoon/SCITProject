<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../basicFrame.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="resources/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$('.btn-success').on('click',function(){
		var greqNum=$(this).parents().parents().children(".numData").children(".greqNum").attr('data-rno');
		$(this).parents().parents().parents('.requester_container').remove();
		var sendData={
			'greqNum':greqNum
		};
		$.ajax({
			method:'post',
			url:'applySuccess',
			data:JSON.stringify(sendData),
			dataType:'json',
			contentType:'application/json;charset=utf-8',
			success:function(res){
				if(res==1){
					alert('가입이 성공적으로 되었습니다.');
				}
			}
		});
	});
	$('.btn-del').on('click',function(){
		var greqNum=$(this).parents().parents().children(".numData").children(".greqNum").attr('data-rno');
		$(this).parents().parents().parents('.requester_container').remove();
		var sendData={
			'greqNum':greqNum
		};
		$.ajax({
			method:'post',
			url:'applyCancel',
			data:JSON.stringify(sendData),
			dataType:'json',
			contentType:'application/json;charset=utf-8',
			success:function(res){
				if(res==1){
					alert('가입을 취소하였습니다.');
				}
			}
		});
	});
});
</script>
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
									<span id="searchWord">${searchWord}</span>에 대한 검색결과가 없습니다.
								</div>
							</c:if>
							<c:if test="${not empty list}">
							<div class="card-sub">
								<span id="searchWord">${searchWord}</span>의 검색결과입니다.
							</div>
							<table class="table mt-3">
								<thead>
									<tr>
										<th scope="col"><i class="la la-drupal" id="buddyIcon"></i></th>
										<th>모임 명</th>
										<th scope="col" colspan="2">名前</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
								<c:forEach var="list" items="${list}">
									<tr class="requester_container">
										<td>
											<a href="userDetail?userId=${list.gRequester}">
												<div class="searchPhoto">
													<img src="download?${list.originalImage }">
												</div>
											</a>
										</td>
										<td>${list.groName }</td>
										<td >
											<a href="userDetail?userId=${list.gRequester}">
												<div id="listTd">
													${list.userName}<br>
													${list.belong}<br>
												</div>
											</a>
										</td>
										<td class="ssa">
											<div class="btnDiv">
												<button class="btn btn-success" >수락</button>
												<button class="btn btn-del" >거절</button>
											</div>
											<div class="numData">
												<input type="hidden" class="accepter" value="${list.greqAccepter}">
												<input type="hidden" class="greqNum"  data-rno="${list.greqNum}">
											</div>
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
<script src="assets/js/core/bootstrap.min.js"></script>
</body>
</html>