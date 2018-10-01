<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../basicFrame.jsp" %>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->

<link rel="stylesheet" type="text/css" href="group/styles/bootstrap4/bootstrap.min.css">
<link href="group/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="group/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="group/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="group/plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" type="text/css" href="group/styles/courses.css">
<link rel="stylesheet" type="text/css" href="group/styles/courses_responsive.css">


<script type="text/javascript">
function checkPlanner() {
	var title = document.getElementById("plaTitle").value;
	if(title==''){
		alert('title을 입력해주세요.');
		return false;
	}
}
</script>
</head>
<body>
	 <div class="main-panel">
            <div class="content">
	<form action="insertPlanner" onsubmit="return checkPlanner()" method="post">
		
		<table>
			<tr>
				<td>プランナー名前 </td>
				<td><input class="input100" id="plaTitle" type="text" name="plaTitle" ></td>
			</tr>
		
			<tr>
				<td colspan="2">
				<input type="submit" value="create"/>
				</td>
			</tr>
		</table>
		 
	</form>
	<script src="assets/js/core/bootstrap.min.js"></script>
	</div>
	</div>
</body>
</html>