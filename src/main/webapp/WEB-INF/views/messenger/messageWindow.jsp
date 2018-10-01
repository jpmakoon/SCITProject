<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html class="no-js" lang="" style="background-color: #ffffff;">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Message</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style type="text/css">
@import url('https://fonts.googleapis.com/css?family=Poppins');
*:focus {
   outline: none;
}
* {
   box-sizing: border-box;
}
input[type=button]{
	width: 90px;
	height: 35px;
	font-size: 20px;
	padding-top: 4px;
	border-radius: 3px;
}
body {
   background: #ffffff;
   color: #000000;
   font-family: "Roboto", Arial, Helvetica, sans-serif;
   font-size: 16px;
   font-weight: 300;
   letter-spacing: 0.01em;
   line-height: 1.6em;
   margin: 0;
   padding: 10px;
   overflow-x:hidden;
}
button:focus, input:focus, textarea:focus, select:focus {
   outline: none;
}
.row{
	padding-top: 10px;
}
#wrapper {
 width: 100%;
 text-align: center;
 margin-top: 20px;
 background-color: #ffffff;
 }
 
#in {
 display: inline-block;
 }
.receiver2{
	padding-left: 100px;
	text-align: left;
}
.msgU3{
	padding-left: 100px;
	text-align: left;
}
</style>

<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="resources/css/bootstrap.css">

<script type="text/javascript" src="resources/sockjs-0.3.4.js"></script>
<script src="assets/js/core/jquery.3.2.1.min.js"></script>
<style type="assets/css/ready.css"></style>
<style type="assets/css/bootstrap.min.css"></style>
<script>
//소켓 관련 스크립트
var receiveuserid = '<c:out value="${receiveuserid}"/>';//aaa
var userId = '<c:out value="${userId}"/>'; //ccc
var msg = '<c:out value="${msg}"/>'; 
var date = '<c:out value="${date}"/>';

$(function(){
   if(date!=""){
      $('#msgU').val(msg);
      $('.msgU3').text("時間 : "+date);
   }
})
function setParentText() {
   var msgU = $('#msgU').val();
   opener.send(msgU + "-" +receiveuserid);
   window.close();
}
function setResponseText(){
   window.close();
   opener.chatOneConnect(senduserId);
}
function onClose(){
   window.close();
}
</script>

<title>쪽지보내기</title>
</head>
<body>
	<div id="wrapper">
		<img alt="mainlogo" src="images/msglogo.png">
		<c:if test="${date!=null}">
			<div class="receiver">
				<h4 class="receiver2">宛先 : ${receiveuserid}</h4>
				<h4 class="msgU3"></h4>
			</div>
		</c:if>
		<c:if test="${date==null}">
			<div class="receiver">
				<h4 class="receiver2">宛先 : ${receiveuserid}</h4>
			</div>
		</c:if>
		<div id="in">
			<textarea style="height: 230px; width: 370px; " id="msgU" class="form-control" placeholder="メッセージを入れてください。" maxlength="1000"></textarea>
		</div>
		<div>
			<c:if test="${date==null}">
				<div class="row">
					<input class="btn btn-success" type="button" onclick="setParentText()" value="送信"></input>
				</div>
			</c:if>
			<c:if test="${date!=null}">
				<div class="row">
					<input class="btn btn-success" type="button" onclick="setResponseText()"value="返事"></input>
					<input class="btn btn-success" type="button" onclick="onClose()"value="確認"></input>
				</div>
			</c:if>
		</div>
	</div>
</body>
</html>