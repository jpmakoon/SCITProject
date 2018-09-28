﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<title>ticks ticks main</title>
	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
	<link rel="stylesheet" href="assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i">
	<link rel="stylesheet" href="assets/css/ready.css">
	<link rel="stylesheet" href="assets/css/demo.css">
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<script type="text/javascript" src="resources/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$('.groupManual').on('click',function(){
		var isAccepted='';
		isAccepted +='<a href="groupApply">';
		isAccepted +='<span class="link-collapse">## 그룹 신청이 왔습니다!!!##</span>';
		isAccepted +='</a>';
		 $.ajax({
			method:'post',
			url:'isAccepted',
			contentType:'application/json;charset=json',
			success:function(r){
				if(r==1){
					$("#a").html(isAccepted);
				}
			}
		}); 
	});
	////
	
	
});
</script>
<body>
		<input type="hidden" name="loginId" id="loginId" value="${sessionScope.loginId}">
		<div class="main-header">
			<div class="logo-header logoStyle">
				<a href="main"><img class="mainlogo" alt="mainlogo" src="images/mainlogo40.png"><img alt="logo" src="images/logowhite40.png"></a>
				<button class="navbar-toggler sidenav-toggler ml-auto" type="button" data-toggle="collapse" data-target="collapse" aria-controls="sidebar" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<button class="topbar-toggler more"><i class="la la-ellipsis-v"></i></button>
			</div>
			<nav class="navbar navbar-header navbar-expand-lg navTop">
				<div class="container-fluid">
					
					<form class="navbar-left navbar-form nav-search mr-md-3" id="searchForm" name="searchForm" action="usersearch" method="post">
						<div class="wrap-input100  input-group" data-validate = "">
							<input type="text" placeholder="&nbsp; 유저검색" class="form-control input100" name="userName" id="userName">
							<span class="focus-input100"></span>
							<span class="symbol-input100">
								<span class="input-group-text">
									<button id="searchBtn" name="searchBtn"><i class="la la-search search-icon"></i></button>
								</span>
							</span>
						</div>
					</form>
					<ul class="navbar-nav topbar-nav ml-md-auto align-items-center">
						<li class="nav-item dropdown hidden-caret">	<!-------------------------------- message toggle ------------------------------>
							<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown1" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<i class="la la-envelope"></i>
								<span class="notification messageNotify" id="msgCount"></span>		<!-- 새로운 메세지가 있으면 ! 표시-->
							</a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdown1">	<!-- 알림 구현이 끝나면 메세지도 만들기 메세지방보여주기, c:if 새로운 레코드가 추가되면 알려주기 -->
								<a class="dropdown-item" href="friendList">메세지리스트</a>
								<a class="dropdown-item" href="#">b</a>
							</div>
						</li>
						<li class="nav-item dropdown hidden-caret">	<!-------------------------------- request toggle ------------------------------>
							<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown2" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<i class="la la-bell"></i>
							</a>
							<ul class="dropdown-menu notif-box reqDropdown" aria-labelledby="navbarDropdown2">
								<li id="reqExistence">
								</li>
								<li id="reqList">
								</li>
							</ul>
						</li>
						<li class="nav-item dropdown">
							<a class="dropdown-toggle profile-pic" data-toggle="dropdown" href="#" aria-expanded="false">
							<img src="download?${user.originalImage }" alt="user-img" width="36" class="img-circle"><span >${sessionScope.loginName }</span> </a>
							<ul class="dropdown-menu dropdown-user">
									<li>
									<div class="user-box">
										<div class="u-img"><img src="assets/img/profile.jpg" alt="user"></div>
										<div class="u-text">
											<h4>${sessionScope.loginName}</h4>
											<p class="text-muted">${sessionScope.email }</p>
											<a href="userDetail" class="btn btn-rounded btn-danger btn-sm">내 프로필 보기</a></div>
										</div>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item" href="pwdUpdate"><i class="ti-user"></i>비밀번호 변경</a>
									<a class="dropdown-item" href="userDelete"><i class="ti-user"></i>회원탈퇴</a>
									<a class="dropdown-item" href="logout"><i class="fa fa-power-off"></i>로그아웃</a>
									</li>
								</ul>
								<!-- /.dropdown-user -->
							</li>
						</ul>
					</div>
				</nav>
			</div>
			
			<div class="sidebar">
				<div class="scrollbar-inner sidebar-wrapper">
					<div class="user">
						<div class="photo">
							<img src="download?${user.originalImage }">
						</div>
						<div class="info">
							<a class="" data-toggle="collapse" href="#navcoll" aria-expanded="true">
								<span>
									${sessionScope.loginName }
									<span class="user-level">${sessionScope.loginId }</span>
									<span class="caret"></span>
								</span>
							</a>
							<div class="clearfix"></div>

							<div class="collapse in" id="navcoll" aria-expanded="true" style="">
								<ul class="nav">
									<li>
										<a href="userDetail">
											<span class="link-collapse">내 프로필</span>
										</a>
									</li>
									<li>
										<a href="logout">
											<span class="link-collapse">로그아웃</span>
										</a>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<ul class="nav">
						<li class="nav-item">
							<div class="info">
							<a class="" data-toggle="collapse" href="#pp" aria-expanded="true">
									<i class="la la-calendar-o"></i>
									<span class="user-level">개인 플래너</span>
									<div class= "caretDiv">
										<span class="caret" style=""></span>
									</div>
							</a>
							<div class="clearfix"></div>

							<div class="collapse in" id="pp" aria-expanded="true" style="">
								<ul class="nav">
									<li>
										<a href="plannerList">
											<span class="link-collapse">1. Schedule</span>
										</a>
									</li>
									<li>
										<a href="calendar">
											<span class="link-collapse">2. Calendar</span>
										</a>
									</li>
								</ul>
							</div>
						</div>
						</li>
						<li class="nav-item">
							<div class="info">
							<a class="" data-toggle="collapse" href="#sp" aria-expanded="true">
									<i class="la la-chain"></i>
									<span class="user-level">공유 플래너</span>
									<div class= "caretDiv">
										<span class="caret" style=""></span>
									</div>
							</a>
							<div class="clearfix"></div>

							<div class="collapse in" id="sp" aria-expanded="true" style="">
								<ul class="nav">
									<li>
										<a href="#profile">
											<span class="link-collapse">1</span>
										</a>
									</li>
									<li>
										<a href="#edit">
											<span class="link-collapse">2</span>
										</a>
									</li>
								</ul>
							</div>
						</div>
						</li>
						<li class="nav-item">
							<div class="info">
							<a class="groupManual" data-toggle="collapse" href="#gr" aria-expanded="true">
									<i class="la la-group"></i>
									<span class="user-level">그룹</span>
									<div class= "caretDiv">
<!-- 										<span class="caret" style=""></span> -->
									</div>
							</a>
							<div class="clearfix"></div>

							<div class="collapse in" id="gr" aria-expanded="true" style="">
								<ul class="nav">
									<li>
										<a href="insertGroup">
											<span class="link-collapse">1. insertGroup</span>
										</a>
									</li>
									<li>
										<a href="groupList">
											<span class="link-collapse">2. groupList</span>
										</a>
									</li>
									<li >
										<a href="myGroupList">
											<span class="link-collapse">3. myGroup</span>
										</a>
									</li>
										<li id="a"><!-- ##group 신청## --></li>
								</ul>
							</div>
						</div>
						</li>
						<li class="nav-item">
							<a href="friendList">
								<i class="la la-drupal"></i>
								<p>친구</p>
							</a>
						</li>
						<li class="nav-item">
							<a href="pattern">
								<i class="la la-pie-chart"></i>
								<p>패턴 관리</p>
							</a>
						</li>
						<li class="nav-item">
							<a href="typography.html">
								<i class="la la-gear"></i>
								<p>회원 설정</p>
							</a>
						</li>
					</ul>
				</div>
			</div>

<!--===============================================================================================-->	
<script src="assets/js/core/jquery.3.2.1.min.js"></script>
<!--===============================================================================================-->	
<script src="assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<!--===============================================================================================-->	
<script src="assets/js/core/popper.min.js"></script>
<!--===============================================================================================-->	
<script src="assets/js/core/bootstrap.min.js"></script>
<!--===============================================================================================-->	
<script src="assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>
<!--===============================================================================================-->	
<script src="assets/js/plugin/bootstrap-toggle/bootstrap-toggle.min.js"></script>
<!--===============================================================================================-->	
<script src="assets/js/plugin/jquery-mapael/jquery.mapael.min.js"></script>
<!--===============================================================================================-->	
<script src="assets/js/plugin/jquery-mapael/maps/world_countries.min.js"></script>
<!--===============================================================================================-->	
<script src="assets/js/plugin/chart-circle/circles.min.js"></script>
<!--===============================================================================================-->	
<script src="assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>
<!--===============================================================================================-->	
<script src="assets/js/ready.min.js"></script>
<!--===============================================================================================-->
<script>
 $(function(){

	 $.ajax({
         method  : 'post'
         , url   : 'msgCount'
         , success : function(resp){
        	 $('#msgCount').text(resp);
         }
      });
	reqCheck();
});

function reqCheck(){
	$.ajax({
		method : 'post'
		,  url : 'reqCheck'
		,  success : function(response){
			if(response.length > 0) {
				reqOutput(response);
			}else {
				var noReq = '<div class="dropdown-title">お知らせなし</div>';
				$('#reqExistence').html(noReq);
			}
		}
	})
}

function reqOutput(response){
	var reqSignal = '<i class="la la-bell"></i><span class="notification reqNotify">!</span>';
	$('#navbarDropdown2').html(reqSignal);
	
	var req = '<div class="dropdown-title">お知らせがあります。</div>';
	$('#reqExistence').html(req);
	
	var reqAll = '';
	for ( var i in response) {
		reqAll += '<div class="notif-center">';
		reqAll += '<div class="notif-icon notif-primary"> <i class="la la-user-plus"></i> </div>';
		reqAll += '<div class="notif-content">';
		reqAll += '<span class="time">'+response[i].userName+'님의 친구 요청</span>';
		reqAll += '<div id="btnDiv">';
		reqAll += '<input type="button" id="successBtn" class="btn btn-success" value="수락"> &nbsp;';
		reqAll += '<button class="btn btn-danger" id="dangerBtn">거절</button>';
		reqAll += '</div>';
		reqAll += '<input type="hidden" class="accepter" value="'+response[i].userId+'">';
		reqAll += '</div>';
		reqAll += '</div>';
	}
	
	$('#reqList').html(reqAll);
}

$(document).on("click", '#searchBtn', function(){
	var word = $('#userName').val();
	var userId = $('#loginId').val();
	var userName = $('#loginName').val();
	
	if(word == userId){
		alert('자신의 ID는 검색할 수 없습니다.');
		return false;
	}
});


$(document).on("click", "#successBtn", function(){
	if(!confirm("수락하시겠습니까?")){
		return false;
	}else{
		var friRequester = $(this).parent().parent().children('.accepter').val();
		var sendData = {"friRequester" : friRequester}
		
		console.log($(this).parent().parent().parent().parent());
		$(this).parent().parent().parent().parent().remove();
		
		if($('.notif-center').length == 0){
			
			$('#reqSignal').parent().remove();
		}
		
		$.ajax({
			method : 'post'
			, url  : 'friAccept'
			, data : JSON.stringify(sendData)
			, dataType : 'text'
			, contentType : 'application/json; charset=UTF-8'
			, success : function(response){
				if(response == 1){
					alert("친구등록이 완료되었습니다.");
				}else{
					alert('다시 시도해주세요');
				}
			}
		})
	}
});

$(document).on("click", "#dangerBtn", function(){
	if(!confirm("삭제하시겠습니까?")){
		return false;
	}else{
		var friRequester = $(this).parent().parent().children('.accepter').val();
		var sendData = {"friRequester" : friRequester}
		
		console.log($(this).parent().parent().parent().parent());
		$(this).parent().parent().parent().parent().remove();
		
		if($('.notif-center').length == 0){
			$('#reqSignal').parent().remove();
		}
		
		$.ajax({
			method : 'post'
			, url  : 'friDelete'
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