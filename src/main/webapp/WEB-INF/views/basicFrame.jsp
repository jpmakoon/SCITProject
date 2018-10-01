<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
.dropdown-item{text-align: right;}
</style>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<title>メインページ</title>
	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
	<link rel="stylesheet" href="assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i">
	<link rel="stylesheet" href="assets/css/ready.css">
	<link rel="stylesheet" href="assets/css/demo.css">
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<<<<<<< HEAD

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

=======
>>>>>>> e9007b27329120203c324ed923585ff29a6e92e9
<body>
	<input type="hidden" name="loginId" id="loginId" value="${sessionScope.loginId}">
		<div class="main-header">
			<div class="logo-header logoStyle">
				<a href="main"><img class="mainlogo" alt="mainlogo" src="images/mainlogo40.png"><img class="mainlogo2"alt="logo" src="images/logowhite40.png"></a>
				<button class="navbar-toggler sidenav-toggler ml-auto" type="button" data-toggle="collapse" data-target="collapse" aria-controls="sidebar" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<button class="topbar-toggler more"><i class="la la-ellipsis-v"></i></button>
			</div>
			<nav class="navbar navbar-header navbar-expand-lg navTop">
				<div class="container-fluid">
					<form class="navbar-left navbar-form nav-search mr-md-3" id="searchForm" name="searchForm" action="usersearch" method="post">
						<div class="wrap-input100  input-group" data-validate = "">
							<input type="text" placeholder="&nbsp; ユーザ検索" class="form-control input100" name="userName" id="userName">
							<span class="focus-input100"></span>
							<span class="symbol-input100">
								<span class="input-group-text">
									<button id="searchBtn" name="searchBtn"><i class="la la-search search-icon"></i></button>
								</span>
							</span>
						</div>
					</form>
					<ul class="navbar-nav topbar-nav ml-md-auto align-items-center">
					<li class="nav-item dropdown hidden-caret">	<!-------------------------------- calendar toggle ------------------------------>
							<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown1" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<img alt="" src="resources/calendar_icon.png" id="isCalendarShare">
									
							</a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdown1" id="calShareList">	<!-- 알림 구현이 끝나면 메세지도 만들기 메세지방보여주기, c:if 새로운 레코드가 추가되면 알려주기 -->
								
								
							</div>
						</li>
						<li class="nav-item dropdown hidden-caret">	<!-------------------------------- message toggle ------------------------------>
							<a class="nav-link dropdown-toggle" href="friendList" id="navbarDropdown1" role="button">
								<i class="la la-envelope"></i>
								<span class="notification messageNotify" id="msgCount"></span>		<!-- 새로운 메세지가 있으면 ! 표시-->
							</a>
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
							<img src="download?userId=${sessionScope.loginId }" alt="user-img" width="36" class="img-circle"><span>${sessionScope.loginName }</span></a>
							<ul class="dropdown-menu dropdown-user">
								<li>
									<div class="user-box">
										<div class="u-img"><img src="download?userId=${sessionScope.loginId }" alt="user-img" height="69">
										</div>
										<div class="u-text">
											<h4>${sessionScope.loginName}</h4>
											<p class="text-muted">${sessionScope.email }</p>
											<a href="userDetail?userId=${sessionScope.loginId }" class="btn btn-rounded btn-danger btn-sm">私のプロフィール</a>
										</div>
									</div>
									<div class="dropdown-divider">
									</div>
									<a class="dropdown-item" href="pwdUpdate"><i class="ti-user"></i>パスワード変更</a>
									<a class="dropdown-item" href="userDelete"><i class="ti-user"></i>アカウント削除</a>
									<a class="dropdown-item" href="logout"><i class="fa fa-power-off"></i>ログアウト</a>
								</li>
							</ul>
						</li>
					</ul>
							<!-- /.dropdown-user -->
					</div>
				</nav>
			</div>
			
			<div class="sidebar">
				<div class="scrollbar-inner sidebar-wrapper">
					<div class="user">
						<div class="photo">
							<img src="download?userId=${sessionScope.loginId }">
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
										<a href="userDetail?userId=${sessionScope.loginId }">
											<span class="link-collapse">私のプロフィール</span>
										</a>
									</li>
									<li>
										<a href="logout">
											<span class="link-collapse">ログアウト</span>
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
									<span class="user-level">個人プランナー</span>
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
							<a class="shareCal" data-toggle="collapse" href="#sp" aria-expanded="true">
									<i class="la la-chain"></i>
									<span class="user-level">共有プランナー</span>
									<div class= "caretDiv">
										<span class="caret" style=""></span>
									</div>
							</a>
							<div class="clearfix" id="calShareUserList"></div>

							<div class="collapse in"  aria-expanded="true" style="">
								
							</div>
						</div>
						</li>
						<li class="nav-item">
							<div class="info">
							<a class="groupManual" data-toggle="collapse" href="#gr" aria-expanded="true">
									<i class="la la-group"></i>
									<span class="user-level uLevel2">グループ</span>
									<div class= "caretDiv">
 										<span class="caret" style=""></span>
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
								<span class="user-level">友達</span>
							</a>
						</li>
						<li class="nav-item">
							<a href="pattern">
								<i class="la la-pie-chart"></i>
<<<<<<< HEAD
								<p>패턴 관리</p>
							</a>
						</li>
						<li class="nav-item" >
							<a href="typography.html">
								<i class="la la-gear"></i>
								<p>회원 설정</p>
=======
								<span class="user-level">パタン管理</span>
>>>>>>> e9007b27329120203c324ed923585ff29a6e92e9
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
        	 if(resp == 0 ){
        		 $('#msgCount').remove();
        	 }else{
        		 $('#msgCount').text(resp);
        	 }
         }
      });
	reqCheck();
	mainPhoto();
});
$(function(){
	$.ajax({
		method:'post',
		url:'isCalendarShare',
		success:function(r){
			var shareList='';
			shareList +='<a class="dropdown-item" href="isShareRequest">calendar 공유리스트</a>';
			for ( var i in r) {
				
				shareList +='<div class="dropdown-item" >'+r[i].requester+'</div>';
			}
			$("#calShareList").html(shareList);
		}
	});
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

function mainPhoto(){
	
}

function reqOutput(response){
	var reqSignal = '<i class="la la-bell"></i><span class="notification reqNotify">!</span>';
	$('#navbarDropdown2').html(reqSignal);
	
	var req = '<div class="dropdown-title">お知らせがあります。</div>';
	$('#reqExistence').html(req);
	
	var reqAll = '';
	for ( var i in response) {
		reqAll += '<div class="notif-center">';
		reqAll += '<div class="notif-content"><i class="la la-user-plus" id="buddyIcon"></i>';
		reqAll += '<span class="time"> &nbsp;'+response[i].userName+'様の友達要請</span>';
		reqAll += '<div id="btnDiv">';
		reqAll += '<input type="button" id="successBtn" class="btn btn-success" value="承知"> &nbsp;';
		reqAll += '<button class="btn btn-danger" id="dangerBtn">拒絶</button>';
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
		alert('自分のIDは検索できません。');
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
					alert("登録完了");
				}else{
					alert('다시 시도해주세요');
				}
			}
		})
	}
});

$(document).on("click", "#dangerBtn", function(){
	if(!confirm("拒絶しますか？")){
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
					alert("拒絶完了");
				}else{
					alert('다시 시도해주세요');
				}
			}
		})
	}
});
<<<<<<< HEAD
$(function(){
	$('.shareCal').on('click',function(){
		
		$.ajax({
			method:'post',
			url:'shareCal',
			contentType : 'application/json; charset=UTF-8',
			success:function(r){
				
				
				
				
				var inputData='';
				inputData +='<ul class="nav" >';
				for ( var i in r) {
					inputData +='<li>';
					inputData +='<a href="shareCalendar?requester='+r[i].requester+'">';
					inputData +='<span class="link-collapse">'+r[i].requester+'</span>';
					inputData +='</a></li>';
				}
				inputData +='</ul>';
				$("#calShareUserList").html(inputData);
				$("#calShareUserList").removeClass("clearfix").addClass("clearfix_open");
			}
		});
	});
=======

$(function(){
	$('.groupManual').on('click',function(){
		var isAccepted='';
		isAccepted +='<a href="groupApply">';
		isAccepted +='<span class="link-collapse">## グループ要請があります!!!##</span>';
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
	
>>>>>>> e9007b27329120203c324ed923585ff29a6e92e9
	
});
</script>

</body>
</html>