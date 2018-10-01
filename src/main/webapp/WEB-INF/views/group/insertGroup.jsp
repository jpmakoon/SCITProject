<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@include file="../basicFrame.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Create a Group</title>

<style>

#createGroup{
	margin-left: 25%;
	margin-right: 0;
	margin-top: 30px;
	padding: 0 auto;
	color : black;	
}
.d-flex{
	margin-left: 30%;
}
#cgbtn{
	margin-right: 35px;
}

#groIntro{
	resize : none;
}

#groupInsForm{
	margin: 0 auto;
}
</style>
<script type="text/javascript">
$(function(){
	
	$('#groName').focus();
	
	function checkGroup(){
		var groName=$('#groName').val();
		var groIntro=$('#groIntro').val();
		if(groName.length==0){
			alert("グループ名を入れてください。");
			return false;
		}
		if(groIntro.length==0){
			alert("グループ紹介を書いてください。");
			return false;
		}
	}
});

</script>
<title>Create a Group</title>
</head>
<body>
	<div class="main-panel">
		<div class="content">
			<div class="container-fluid">
				<div class="col-md-5"id="createGroup" >
					<div class="card">
						<div class="card-header">
							<div class="card-title">Create a Group</div>
						</div>
						<form action="insertGroup" method="post" enctype="multipart/form-data" onsubmit="return checkGroup()">
							<div class="card-body">
								<div class="row">
									<div class="col-md-8" id="groupInsForm">
										<div class="form-group">
											<label class="form-label">グループ名</label>
											<input type="text" id="groName" class="form-control" name="groName" placeholder="グループ名">
										</div>
										<input type="hidden" id="groName" name="groName" value="${groName}">
										<div class="form-group">
											<label class="form-label">グループイメージ</label>
											<input type="file" id="upload" name="upload">
										</div>
										<div class="form-group">
											<label class="form-label">グループ紹介 </label>
												<textarea class="form-control" id="groIntro" name="groIntro" rows="6" placeholder="グループ紹介"></textarea>
										</div>
									</div>
								</div>
							</div>
							<div class="card-footer text-right" >
								<div class="d-flex">
									<input type="button" id="cgbtn" class="btn btn-danger" value="取り消し" onclick="history.back(-1);"> 
<!-- 									<a href="javascript:void(0)" class="btn btn-link">取り消し</a> -->
									<input type="submit" class="btn btn-success" value="グループ生成" />
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>