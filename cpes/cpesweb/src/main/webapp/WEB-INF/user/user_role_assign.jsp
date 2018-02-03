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
<title>用户角色分配</title>
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
				  <li class="active">分配角色</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
				<form class="form-inline">
				  <div class="form-group">
				      <h4>未分配角色列表</h4>
				  
				      <select id="leftDataList" multiple="multiple" size="10" style="width:150px;overflow-y: auto;" class="form-control">
				          <c:forEach items="${unassignRoles}" var="role">
				        	  <option value="${role.id}">${role.name}</option>
				          </c:forEach>
				      </select>
				  </div>
				  <div class="form-group">
				      <ul id="operationBtns">
				          <li id="left2rightBtn" class="btn btn-default"><i class="glyphicon glyphicon-arrow-right"></i></li>
				          <br><br>
				          <li id="right2leftBtn" class="btn btn-default"><i class="glyphicon glyphicon-arrow-left"></i></li>
				      </ul>
				  </div>
				  <div class="form-group">
				      <h4>已分配角色列表</h4>
				      <select id="rightDataList" multiple="multiple" size="10" style="width:150px;overflow-y: auto;" class="form-control">
				          <c:forEach items="${assignRoles}" var="role">
				       		   <option value="${role.id}">${role.name}</option>
				          </c:forEach>
				      </select>
				  </div>
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
	   		 
	   		$("#left2rightBtn").click(function(){
	   			var list = $("#leftDataList :selected");
	   			if(list.length == 0){
	   				alert("请选择需要分配的角色信息");
	   				return false;
	   			}else{
	   				var dataObj = {userid:"${user.id}"}
	   				$.each(list,function(i,n){
	   					dataObj["ids["+i+"]"] = n.value;
	   				})
	   				
	   				paramObj = {
	   					type	:	"POST",
	   					url		:	"${pageContext.request.contextPath }/user/assignRole.do",
	   					data	:	dataObj,
	   					success	:	function(result){
	   						if(result.success){
	   							$("#rightDataList").append(list);
	   						}else{
	   							alert("分配角色信息失败");
	   						}
	   					}
	   				}
	   				
	   				$.ajax(paramObj);
	   			}
	   		}) 
	   		
	   		$("#right2leftBtn").click(function(){
	   			var list = $("#rightDataList :selected");
	   			if(list.length == 0){
	   				alert("请选择需要取消分配的角色信息");
	   				return false;
	   			}else{
	   				var dataObj = {userid:"${user.id}"}
	   				$.each(list,function(i,n){
	   					dataObj["ids["+i+"]"] = n.value;
	   				})
	   				
	   				paramObj = {
	   					type	:	"POST",
	   					url		:	"${pageContext.request.contextPath }/user/unassignRole.do",
	   					data	:	dataObj,
	   					success	:	function(result){
	   						if(result.success){
	   							$("#leftDataList").append(list);
	   						}else{
	   							alert("取消分配角色信息失败");
	   						}
	   					}
	   				}
	   				
	   				$.ajax(paramObj);
	   			}
	   		}) 
		});
	</script>
</body>
</html>