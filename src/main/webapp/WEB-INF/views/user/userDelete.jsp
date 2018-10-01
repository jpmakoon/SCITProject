<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../basicFrame.jsp" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
</head>
<body>
			<div class="container-login100" >
				<div class="wrap-signUp100" id="pwdCheckForm">
					<div class="container-fluid">
						<div class="card">
							<div class="card-body">
								<div class="form-group">
									<label for="pw">パスワード確認</label>
									<div class="wrap-input100  input-group" data-validate = "">
										<input type="password" id="pw" name="pw" placeholder="パスワード を入力してください" class="input100"/>
										<span class="focus-input100"></span>
									</div>
									<span id="pwHelp" class="form-text">""</span>
								</div>
							</div> <!-- card body  -->
						</div>
					</div>
				</div>
			</div>
		

<script>
$('#pw').on('keyup',function(){
	var userPwd = $(this).val();
	if(userPwd.length > 4 && userPwd.length < 9){
		var sendData = {"userPwd" : userPwd}
		
		$.ajax({
			method : 'post'
			, url : 'pwdCheck'
			, data : JSON.stringify(sendData)
			, dataType : 'text'
			, contentType : 'application/json; charset=UTF-8'
			, success : function(response){
				console.log(response);
				if(response != "") {
					$('#pwHelp').text("success").css('color','blue');
					$('#pwdCheckForm').fadeOut(10);
					if(!confirm("アカウントを削除しますか？")){
						location.href="main";
						return false;
					}else{
						userDelete();
					}
				}
			}
		});
	}
	$('#pwHelp').text("会わないパスワードです。").css('color','red');
	return false;
});

function userDelete(){
	$.ajax({
		method : 'post'
		, url : 'userDelete'
		, success : function(response){
			if(response == 1) {
				alert('ありがとうございました。');
				location.href="index";
			}
		}
	});
}

</script>
</body>
</html>