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

	<link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/font-awesome.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/main.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/pagination.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
	</style>
<title>Insert title here</title>
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
				<form action="${pageContext.request.contextPath}/cert/insertCert.do" method="post" id="certForm" cert="form">
				  <div class="form-group">
					<label for="exampleInputEmail1">资质名称</label>
					<input type="text" class="form-control" id="name" name="name" placeholder="请输入资质名称">
				  </div>
				  <button id="saveBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 新增</button>
				  <button type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
				</form>
			  </div>
			</div>
        </div>
      </div>
    </div>

	<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-2.1.1.min.js"></script>
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
		
		$("#saveBtn").click(function () {
			var name = $("#name");
			if(name.val() == ""){
				alert("登录账号不能为空,请输入");
				$("#name").focus();
				return false;
			}
			
			var dataObj  = {
					"name"		:	name.val()
			}
			
			var paramObj = {
					url		:	"${pageContext.request.contextPath}/cert/addCert.do",
					type	:	"POST",
					data	:	dataObj,
					success	:	function(result){
						if(result.success){
							window.location.href = "${pageContext.request.contextPath}/cert/index.htm";
						}else{
							alert("资质信息添加失败");
						}
					}
			}
			$.ajax(paramObj);
		})
	</script>
</body>
</html>