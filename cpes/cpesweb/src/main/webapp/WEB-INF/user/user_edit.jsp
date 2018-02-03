<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/doc.min.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	</style>
<title>新增用户</title>
</head>
<body>
	
	<%@include file="/WEB-INF/common/head.jsp" %>

	    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
			<div class="tree">
				<%@ include file="/WEB-INF/common/menu.jsp" %>
			</div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  <li><a href="#">首页</a></li>
				  <li><a href="#">数据列表</a></li>
				  <li class="active">新增</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
				<form role="form" id="userForm" >
					<input id="id" type="hidden" name="id" value="${user.id }">
				  <div class="form-group">
					<label for="exampleInputPassword1">登陆账户</label>
					<input id="loginacct" name="loginacct" type="text" value="${user.loginacct }" class="form-control" id="exampleInputPassword1" placeholder="Login Account">
				  </div>				
	
				  <div class="form-group">
					<label for="exampleInputPassword1">昵称</label>
					<input id="username" name="username" value="${user.username }" type="text" class="form-control" id="exampleInputPassword1" placeholder="Name">
				  </div>				  
				  <div class="form-group">
					<label for="exampleInputEmail1">邮箱地址</label>
					<input id="email" name="email" type="email" value="${user.email }" class="form-control" id="exampleInputEmail1" placeholder="Email">
					<p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
				  </div>
				  
				  <div class="form-group">
					<label for="exampleInputFile">头像</label>
					<input id="photo" name="photo" type="file" id="exampleInputFile">
				  </div>
				  <button id="insertBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 更新</button>
				  <button id="resetBtn" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
				</form>
			  </div>
			</div>
        </div>
      </div>
    </div>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-2.1.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/jquery/jquery.pagination.js"></script>
    <script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(function () {
		    $(".list-group-item").click(function(){
			    if ( $(this).find("ul") ) {
					$(this).toggleClass("tree-closed");
					if ( $(this).hasClass("tree-closed") ) {
						$("ul", this).hide("fast");
					} else {
						$("ul", this).show("fast");
					}
				}
			});
	    });
		
		$("#insertBtn").click(function () {
			var loginacct = $("#loginacct");
			if(loginacct.val() == ""){
				alert("登录账号不能为空,请输入");
				$("#loginacct").focus();
				return false;
			}
			var id = $("#id");
			var username = $("#username");
			var email = $("#email");
			var photo = $("#photo");
			
			var dataObj  = {
					"id"			:	id.val(),
					"loginacct"		:	loginacct.val(),
					"username"		:	username.val(),
					"email"			:	email.val(),
					"photo"			:	photo.val()
			}
			
			var paramObj = {
					url		:	"${pageContext.request.contextPath}/user/update.do",
					type	:	"POST",
					data	:	dataObj,
					success	:	function(result){
						if(result.success){
							window.location.href = "${pageContext.request.contextPath}/user/index.htm";
						}else{
							alert("用户信息更新失败");
						}
					}
			}
			$.ajax(paramObj);
		})
		
		$("#resetBtn").click(function(){
			$("#userForm")[0].reset();
		})
	</script>
</body>
</html>