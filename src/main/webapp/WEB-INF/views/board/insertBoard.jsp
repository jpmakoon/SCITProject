<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../basicFrame.jsp" %>
<!DOCTYPE html>

<html>
<head>

<style>
html, body {
   height: 100px;
   margin: 0;
   padding: 0;
}
.d-flex{
	float: right;
	margin-right: 35px;
}
#cgbtn{
	margin-right: 35px;
}
</style>
</head>
<body>
	<div class="main-panel">
		<div class="content">
			<div class="page">
				<div class="page-main">
					<div class="my-3 my-md-5">
						<div class="container">
							<div class="row">
								<div class="col-12">
									<form action="insertBoard" method="post" enctype="multipart/form-data"  class="card">
										<div class="card-header">
											<h3 class="card-title">ボードポスト</h3>
										</div>
										<div class="card-body">
												<div class="col-md-6 postDiv">
													<div class="form-group">
														<input type="hidden" name="groNum" value="${groNum}">
														<label class="form-label">タイトル</label>
														<input type="text" class="form-control" name="boaTitle"　placeholder="Text..">
													</div>
													<br>
													<div class="form-group">
														<label class="form-label">内容 </label>
														<textarea class="form-control" name="boaContent"　rows="6" placeholder="Content.."></textarea>
													</div>
													<div class="form-group">
														<label class="form-label">添付ファイル</label>
														<input type="file" id="upload" name="upload">
													</div>
												</div>
										</div>
										<div class="card-footer text-right">
											<div class="d-flex">
												<input type="button" id="cgbtn" class="btn btn-danger" value="取り消し" onclick="history.back(-1);">
												<button type="submit" class="btn btn-success">登録</button>
											</div>
										</div>
									</form>
								</div>
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