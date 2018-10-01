<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../basicFrame.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
</head>
<style type="assets/css/ready.css"></style>

<body>
	<div class="main-panel">
			<div class="content">
				<div class="container-fluid">
					<h4 class="page-title">Profile</h4>
					<div class="row">
						
						<div class="col-md-5" id="userUD">
							<div class="card">
								<div class="card-header">
									<div class="card-title">${user.userName }様のプロフィール</div>
								</div>
								<form id="updateForm" name="updateForm" action="userUpdate" method="post" enctype="multipart/form-data"> <!-- submit form -->
								<div class="card-body">
									<div class="user-update-box">
										<div class="u">
										<c:if test="${empty mime}">
											<img class="image" src="assets/img/profile.jpg" alt="user">
										</c:if>
										<c:if test="${not empty mime}">
											<img class="image" src="download?userId=${user.userId }" alt="user">
										</c:if>									
										</div>
									</div>
									
									<input type="file" class="form-control-file" id="upload" name="upload" disabled>
										<div class="form-group form-inline">
											<label for="inlineinput" class="col-md-3 col-form-label">ID</label>
											<div class="col-md-8 p-0">
												<input type="text" class="form-control input-full" id="userId" value="${user.userId }" name="userId" disabled>
											</div>
										</div>
										
										<div class="form-group form-inline">
											<label for="inlineinput" class="col-md-3 col-form-label">Email</label>
											<div class="col-md-8 p-0">
												<input type="email" class="form-control input-full" id="email" value="${user.email}" name="email" disabled>
											</div>
										</div>
										<div class="form-group form-inline">
											<label for="inlineinput" class="col-md-3 col-form-label">Birth</label>
											<div class="col-md-8 p-0">
												<input type="date" class="form-control input-full" id="birth" value="${user.birth }" name="birth" disabled>
											</div>
										</div>
										<div class="form-group form-inline">
											<label for="inlineinput" class="col-md-3 col-form-label">Phone</label>
 												<div class="form-inline" id="phone">
													<div class="col-md-4 p-0"> 
														<select class="form-control input-full" id="phone1" name="phone" disabled style='width: 80px;'>
														    <option value="1" ${phone1 == '+81' ? 'selected' : ''}>Korea +82</option>
														    <option value="2" ${phone1 == '+81' ? 'selected' : ''}>Japan +81</option>
														    <option value="5" ${phone1 == '+1' ? 'selected' : ''}>USA +1</option>
														    <option value="5" ${phone1 == '+84' ? 'selected' : ''}>Vietnam +84</option>
														    <option value="5" ${phone1 == '+86' ? 'selected' : ''}>China +86</option>
														    <option value="5" ${phone1 == '+852' ? 'selected' : ''}>Hong Kong +852</option>
														    <option value="5" ${phone1 == '+61' ? 'selected' : ''}>Australia +61</option>
														</select>
													</div>
													&nbsp;&nbsp;
													<div class="col-md-7 p-0">
														<input type="text" class="form-control input-full" id="phone2" name="phone" value="${phone2}" style="width: 265px;" disabled>
													</div>
												</div>
										</div>
										<div class="form-group form-inline">
											<label for="inlineinput" class="col-md-3 col-form-label">Belong</label>
											<div class="col-md-8 p-0">
												<input type="text" class="form-control input-full" id="belong" value="${user.belong }" name="belong" disabled>
											</div>
										</div>
										<div class="form-group form-inline">
											<label for="inlineinput" class="col-md-3 col-form-label">Introduce</label>
											<div class="col-md-8 p-0">
												<textarea class="form-control input-full" id="introduce" name="introduce" rows="5"  disabled>${user.introduce }</textarea>
												</div>
										</div>
								</div>
							</form>
										<div id="button" class="card-action">
											<input type="button" id="edit" class="btn btn-success" value="Edit" onclick="edit()" />
										</div>
									</div>
								</div>
					</div>
				</div>
			</div>
		</div>
<script type="text/javascript">

function edit(){
	$('#introduce').removeAttr('disabled');
	$('.form-control-file').removeAttr('disabled');
	$('#belong').removeAttr('disabled');
	$('#birth').removeAttr('disabled');
	$('#phone1').removeAttr('disabled');
	$('#phone2').removeAttr('disabled');
 	var newId = '<input type="submit" id="update" class="btn btn-success" value="Update" onclick="update()" />';
	$('#button').html(newId);
}
function update(){
	var userId = $('#userId').val();
	var introduce = $('#introduce').val();
	var belong = $('#belong').val();
	var birth = $('#birth').val();
	var phone1 = $('#phone1').val();
	var phone2 = $('#phone2').val();
	var phone = phone1 + ',' + phone2;
	var upload = $('#upload').val();
	var form = $('#updateForm')
	if(birth == ''){
		alert("生年月日を入力してください。");
		return false;
	}if(phone1 == '' || phone2 == ''){
		alert("電話番号を入力してください。");
		return false;
	}
	form.submit();
}	
var selfile;
$(function() {
	$("#upload").on("change", imgFile);
});

function imgFile(e) {
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	filesArr.forEach(function(f) {
		if(!f.type.match("image.*")){
		alert("확장자는 이미지 확장자만 가능");
			return false;
		}
		selfile = f;
		var reader = new FileReader();
		reader.onload = function(e) {
			$(".image").attr("src",e.target.result);
		}
		reader.readAsDataURL(f);
	});
} 
</script>
</body>
</html>