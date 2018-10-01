<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
   <title>회원가입 폼</title>
   <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
   <link rel="stylesheet" href="assets/css/bootstrap.min.css">
   <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i">
   <link rel="stylesheet" href="assets/css/ready.css">
   <link rel="stylesheet" href="assets/css/demo.css">
   <link rel="stylesheet" type="text/css" href="css/util.css">
   <link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>
<div class="limiter">
<div class="container-login100">
<div class="wrap-signUp100">
   <div class="container-fluid">
      <div class="card">
         <div class="card-header">
            <div class="card-title">新規取得</div>
         </div>
         <form id="signUpForm" name="signUpForm" action="signUp" method="post" enctype="multipart/form-data">            
         <div class="card-body">
            
            <div class="form-group">
               <label for="userID">ID</label>
               <div class="wrap-input100  input-group" data-validate = "">
                  <input type="text" id="userId" name="userId" placeholder="英語、数字３~１０以内" class="input100">
                  <span class="focus-input100"></span>
               </div>
               <span id="userIdHelp" class="form-text"></span>
            </div>
            
            <div class="form-group">
               <label for="userPwd">パスワード</label>
               <div class="wrap-input100  input-group" data-validate = "">
                  <input type="password" id="userPwd" name="userPwd" placeholder="パスワード 入力してください" class="input100">
                  <span class="focus-input100"></span>
               </div>
                  <span id="userPwdHelp" class="form-text"></span>
                  <br>
               
               <label for="userPwdCheck">パスワード確認</label>
               <div class="wrap-input100  input-group" data-validate = "">
                  <input type="password" id="pwdCheck" name="pwdCheck" placeholder="上のパスワードをもう一回入力してください" class="input100">
                  <span class="focus-input100"></span>
               </div>
                  <span id="userPwdCheck" class="form-text"></span>
            </div>
            
            <div class="form-group">
               <label for="userName">名前</label>
               <div class="wrap-input100  input-group" data-validate = "">
                  <input type="text" id="userName" name="userName" placeholder="名前を入力してください" class="input100">
                  <span class="focus-input100"></span>
               </div>
               <span id="userNameCheck" class="form-text"></span>
            </div>

            <div class="form-group">
               <label for="email">E-MAIL</label>
               <div class="wrap-input100  input-group" data-validate = "">
                  <input type="text" id="email" name="email" placeholder="例) &nbsp; ticksticks@gmail.com" class="input100">
                  <span class="focus-input100"></span>
               </div>
               <span id="emailHelp" class="form-text"></span>
            </div>
            
            <div class="form-group">
               <label for="birth">生年月日</label>
               <div class="wrap-input100  input-group" data-validate = "">
                  <input type="date" id="birth" name="birth" class="input100">
                  <span class="focus-input100"></span>
               </div>
            </div>
            
            <div class="form-group">
                  <label for="exampleFormControlSelect2">電話番号</label>
                  <select class="form-control" id="phone1" name="phone">
                     <option value="+82" selected>Korea +82</option>
                     <option value="+81">Japan +81</option>
                     <option value="+1">USA +1</option>
                     <option value="+84">Vietnam +84</option>
                     <option value="+86">China +86</option>
                     <option value="+852">Hong Kong +852</option>
                     <option value="+61">Australia +61</option>
                  </select>
               <br>
               <div class="wrap-input100  input-group" data-validate = "">
                  <input type="text" id="phone2" name="phone" placeholder="'ー' なしで入力してください" class="input100">
                  <span class="focus-input100"></span>
               </div>
               <span id="phoneHelp" class="form-text"></span>
            </div>
            
            <div class="form-group">
               <label for="belong">所属</label>
               <div class="wrap-input100  input-group" data-validate = "">
                  <input type="text" id="belong" name="belong" placeholder="学校、職場などの所属を入力してください" class="input100">
                  <span class="focus-input100"></span>
               </div>
            </div>
            
            <div class="form-group">
               <label for="exampleFormControlFile1">プロフィール写真</label>
                  <div class="img_wrap">
                     <img id="img" />
                  </div>
               <input type="file" class="form-control-file" id="input_img" name="upload">
            </div>
            
            <div class="form-group">
                  <label for="comment">自己紹介</label>
                  <textarea class="form-control" id="introduce" name="introduce" rows="5">
                  </textarea>
            </div>
            </div> <!-- card body  -->
            <div class="card-action">
               <button class="btn btn-success" type="submit">登録完了</button>
               <input class="btn btn-danger" type="reset" value="削除" />
	     	   <input class="btn btn-danger" type="button" value="戻る" id="modoru"/>
            </div>
            </form>   <!-- signUpForm -->      
         </div>
      </div>
   </div>
</div>
</div>
<!-- ================================================================================ -->
<script src="assets/js/core/jquery.3.2.1.min.js"></script>
<!-- ================================================================================ -->
<script src="assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<!-- ================================================================================ -->
<script src="assets/js/core/popper.min.js"></script>
<!-- ================================================================================ -->
<script src="assets/js/core/bootstrap.min.js"></script>
<!-- ================================================================================ -->
<script src="assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>
<!-- ================================================================================ -->
<script src="assets/js/plugin/bootstrap-toggle/bootstrap-toggle.min.js"></script>
<!-- ================================================================================ -->
<script src="assets/js/plugin/jquery-mapael/jquery.mapael.min.js"></script>
<!-- ================================================================================ -->
<script src="assets/js/plugin/jquery-mapael/maps/world_countries.min.js"></script>
<!-- ================================================================================ -->
<script src="assets/js/plugin/chart-circle/circles.min.js"></script>
<!-- ================================================================================ -->
<script src="assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>
<!-- ================================================================================ -->
<script src="assets/js/ready.min.js"></script>
<!-- ================================================================================ -->
<script type="text/javascript">

var message = "${not empty message ? message : ''}";
//아이디
function checkPasswordPattern(str) { 
   var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/;   // 특수문자 
   if((!pattern3.test(str)) && str.length > 0) {
      return true;
      } 
   else{ 
      return false;
      } 
   }
   
function checknNamePattern(str) { 
   var namepattern = /[0-9]/;   // 특수문자 
   if((!namepattern.test(str)) && str.length > 0) {
      return true;
      } 
   else{ 
      return false;
      } 
   }
   
//이메일   
function checkEmail(str) { 
   var email = /@/;   
   if(email.test(str) && str.length > 0) {
      return true;
      } 
   else{ 
      return false;
      } 
   }
//전화번호
function autoHypenPhone(str){
     str = str.replace(/[^0-9]/g, '');
     var tmp = '';
     if( str.length < 4){
       return str;
     }else if(str.length < 7){
       tmp += str.substr(0, 3);
       tmp += '-';
       tmp += str.substr(3);
       return tmp;
     }else if(str.length < 11){
       tmp += str.substr(0, 3);
       tmp += '-';
       tmp += str.substr(3, 3);
       tmp += '-';
       tmp += str.substr(6);
       return tmp;
     }else{        
       tmp += str.substr(0, 3);
       tmp += '-';
       tmp += str.substr(3, 4);
       tmp += '-';
       tmp += str.substr(7);
       return tmp;
     }
     return str;
   }
   
var Phone2 = document.getElementById('phone2');
Phone2.onkeyup = function(event){
        event = event || window.event;
        var _val = this.value.trim();
        this.value = autoHypenPhone(_val) ;
}
$(function(){
   if(message != ''){
      alert(message);
      location.href="${pageContext.request.contextPath}/"
   }   
   
   $("#signUpForm").submit(function(){
       //아이디
      var userid = $('#userId').val().length;
      var checkSpace = $('#userId').val().length;
      if(userid < 3 || userid > 10){
         alert("IDを3から10文字以内で記入してください。");
         return false;
      }
      if(!(checkPasswordPattern($('#userId').val()))){
         alert("特殊文字は使えません。");
         return false;
       }
      
      //비밀번호
      var userpwd = $('#userPwd').val().length;
      if(userpwd < 6 || userpwd > 10){
         alert("パスワードを6から10以内で記入してください。");
         return false;
      }
      
      //이름
      var username = $('#userName').val().length;
      if(username == 0){
         alert("名前入力してください。.");
         return false;
      }
      if(!(checknNamePattern($('#userName').val()))){
         alert("数字入力できません。");
         return false;
       } 
      
      //생년월일
      var birth = $('#birth').val().length;
      if(birth == 0){
         alert("生年月日を入力してください。");
         return false;
      }
      
      //전화번호
      var phone1 = $('#phone1 option:selected').text();
      var phone2 = $('#phone2').val();
      if(phone2.length == 0){
         alert("電話番号を入力してください.")
         return false;
      }
      
      //메일
      var email = $('#email').val().length;
      if(email == 0){
         alert("Eメールを入力してください.");
         return false;
      }if(checkEmail(email)){
         alert("メールアドレスを入力してください。");
         return false;
      } 
      
   });
   
   
   //아이디
    $('#userId').on('keyup',function(){
       var userId = $(this).val();
       if(userId.length < 3||userId.length > 10){
         $('#userIdHelp').text("IDは３~１０以内です。").css('color','red');
         return false;
      }
       if(!(checkPasswordPattern(userId))){
          $('#userIdHelp').text("特殊文字は使えません。").css('color','red');
         return false;
       }
       
       $.ajax({
          method : 'post',
          url : 'duplicateCheck',
          data : {"userId" : userId},
          success : function(rep){
             if(rep == 1){
                $('#userIdHelp').text("使えないIDです。").css('color','red');
                return false;
             }if(rep == 0){
                $('#userIdHelp').text("使えるIDです。").css('color','blue');
                return true;
             }      
          }
          
       });
    });
   
    //비밀번호
    $('#userPwd').on('keyup',function(){
       var userPwd = $(this).val();
       
       if(userPwd.length < 6 || userPwd.length > 10){
          $('#userPwdHelp').text("パスワードは6~10以内です。").css('color','red');
          return false;
      }else{
         $('#userPwdHelp').text("");
         return false;
      }
       
    });
    
   //비밀번호 확인
   $('#pwdCheck').on('keyup',function(){
      var pwdCheck = $(this).val();
   
         if(pwdCheck!=$('#userPwd').val()){
            $('#userPwdCheck').text("パスワードが違います。確かめてください。").css('color','red');
            return false;
         }else{
            $('#userPwdCheck').text("確認成功").css('color','blue');
            return true;
      }
   });
   
   //이름
   $('#userName').on('keyup',function(){
      var name = $(this).val();
      if(!(checknNamePattern(name))){
         $('#userNameCheck').text("数字は入力しないでください。").css('color','red');
         return false;
      }else{
          $('#userNameCheck').text("名前入力成功。").css('color','blue');
          return true;
　　　　}
   });
   
   //이메일 확인 
   $('#email').on('keyup', function(){
     var email = $(this).val();
          if(!(checkEmail(email))){
             $('#emailHelp').text("メールアドレスを入力してください。").css('color','red');
            return false;
          }else{
             $('#emailHelp').text("メールアドレス入力成功。").css('color','blue');
             return true;
          }
   });
   
   //전화번호
   $('#phone2').on('keyup', function(){
     var phn2 = $(this).val();
     
       if(phn2.length < 12 || phn2.length > 13){
            $('#phoneHelp').text("電話番号がじがいます。").css('color','red');
            $('#phone2').addClass('has-error');
        　　return false;
      }else{
         $('#phoneHelp').text("電話番号入力成功。。").css('color','blue');
         $('#phone2').addClass('has-success');
         return true;
      }
   });
   
   //이미지
   var selfile;
   $(function() {
      $("#input_img").on("change", imgFile);
   });

   function imgFile(e) {
      var files = e.target.files;
      var filesArr = Array.prototype.slice.call(files);
      
      filesArr.forEach(function(f) {
         if(!f.type.match("image.*")){
            alert("확장자는 이미지 확장자만 가능");
            return;
         }
         
         selfile = f;
         
         var reader = new FileReader();
         reader.onload = function(e) {
            $("#img").attr("src",e.target.result);
         }
         reader.readAsDataURL(f);
      });
   }
   
}); 

$('#modoru').on('click',function(){
	location.href="index";
})
</script>
</body>
</html>