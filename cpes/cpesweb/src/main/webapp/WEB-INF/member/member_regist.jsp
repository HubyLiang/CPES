<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
	<style>
	</style>
<title>会员注册</title>
</head>
<body>
	  <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <div><img src="img/logo.png" width="100" style="float:left;margin-top:5px;"><a class="navbar-brand" style="font-size:32px;" href="#">认证流程审批系统</a></div>
        </div>
      </div>
    </nav>

    <div class="container">

      <form id="login_form" class="form-signin" role="form">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-user"></i> 用户注册</h2>
		  <div class="form-group has-success has-feedback">
			<input  type="text" class="form-control" id="loginacct" name="loginacct" placeholder="请输入登录账号" autofocus>
			<span class="glyphicon glyphicon-ok form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="userpswd" name="userpswd" placeholder="请输入登录密码" autofocus>
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>		  
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="reuserpswd" name="reuserpswd" placeholder="请重新输入登录密码" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="username" name="username" placeholder="请输入账户名称" style="margin-top:10px;">
			<span class="glyphicon glyphicon-ok form-control-feedback"></span>
		  </div>		  
         <a id="registBtn" class="btn btn-lg btn-success btn-block" href="javascript:;" ><i class="glyphicon glyphicon-log-in"></i> 注册</a>
      </form>
    </div>
	
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-2.1.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript">
	
		$("#loginacct").change(function(){
			var loginacct = $("#loginacct");
			if(loginacct.val() != ""){
				dataObj = {"loginacct" : loginacct.val()};
				var paramObj = {
						url		:	"${pageContext.request.contextPath}/member/checkLoginAcct.do",
						type	:	"POST",
						data	:	dataObj,
						success	:	function(result){
							if(!result.success){
								alert("用户名已被使用");
								return;
							}
						}
				}
				$.ajax(paramObj);
			}
		})
	
		$("#registBtn").click(function(){
			var loginacct = $("#loginacct");
			if(loginacct.val() == ""){
				alert("用户名不能为空");
				return false;
			}
			
			var userpswd = $("#userpswd");
			if(userpswd.val() == ""){
				alert("密码不能为空");
				return false;
			}
			var reuserpswd = $("#reuserpswd");
			if(reuserpswd.val() == ""){
				alert("请确认密码");
				return false;
			}
			if(userpswd.val() != reuserpswd.val()){
				alert("两次输入的密码不一致");
				return false;
			}
			
			var username = $("#username");
			if(username.val() == ""){
				alert("会员名称不能为空");
				return false;
			}
			
			dataObj = {"loginacct" : loginacct.val() , "userpswd" : userpswd.val(),"username":username.val()}
			
			var paramObj = {
					url		:	"${pageContext.request.contextPath}/member/regist.do",
					type	:	"POST",
					data	:	dataObj,
					success	:	function(result){
						if(result.success){
								window.location.href="${pageContext.request.contextPath}/memberindex.htm";
								
						}else{
							alert("注册失败");
							/* window.location.href="${pageContext.request.contextPath }/toregist.htm"; */
						}
					}
			}
			$.ajax(paramObj);
		})
	</script>
	
	
</body>
</html>