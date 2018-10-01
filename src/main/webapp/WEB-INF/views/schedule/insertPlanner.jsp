<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@include file="../basicFrame.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Create a Group</title>
<style type="text/css">

#createPlanner{
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

#plannerInsForm{
   margin: 0 auto;
}
</style>
<title>Insert title here</title>
<script type="text/javascript">
function checkPlanner() {
   var title = document.getElementById("plaTitle").value;
   if(title==''){
      alert('titleを入れてください。');
      return false;
   }
}
</script>
</head>
<body>
   <div class="main-panel">
      <div class="content">
         <div class="container-fluid">
            <div class="col-md-5" id="createPlanner" >
               <div class="card">
                  <div class="card-header">
                     <div class="card-title">Create a Planner</div>
                  </div>
                  <form action="insertPlanner" method="post" enctype="multipart/form-data" onsubmit="return checkPlanner()">
                     <div class="card-body" >
                        <div class="row">
                           <div class="col-md-8" id="plannerInsForm">
                              <div class="form-group">
                                 <label class="form-label">プランナー名</label>
                                    <input type="text" id="plaTitle" class="form-control" name="plaTitle" placeholder="Plannar name">
                              </div>
                           </div>
                        </div>
                     </div>
                     <div class="card-footer text-right" >
                        <div class="d-flex">
                           <input type="button" id="cgbtn" class="btn btn-danger" value="CANCEL" onclick="history.back(-1);">
                           <input type="submit" class="btn btn-success" value="CREATE" />
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