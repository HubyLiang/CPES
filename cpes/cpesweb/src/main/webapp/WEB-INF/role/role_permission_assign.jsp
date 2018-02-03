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
	<link rel="stylesheet" href="${pageContext.request.contextPath }/ztree/zTreeStyle.css">
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
			    <%@include file="/WEB-INF/common/menu.jsp" %>
			</div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  <li><a href="#">首页</a></li>
				  <li><a href="#">数据列表</a></li>
				  <li class="active">分配权限</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">系统菜单树<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
			      <a id="assignBtn" class="btn btn-success" href="javascript:assignPermission();">分配权限</a>
			      <br><br>
				  <ul id="permissionTree" class="ztree"></ul>
			  </div>
			</div>
        </div>
      </div>
    </div>

	<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-2.1.1.min.js"></script>
	<script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath }/ztree/jquery.ztree.all-3.5.min.js"></script>	
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
		
		var setting = {
				check: {
			        enable: true // 复选框
			    },
				view: {
					selectedMulti: false,
					addDiyDom: function(treeId, treeNode){
						var icoObj = $("#" + treeNode.tId + "_ico");
						if ( treeNode.icon ) {
							icoObj.removeClass("button ico_docu ico_open").addClass("fa fa-fw " + treeNode.icon).css("background","");
						}
					}
				},
			    async: {
			        enable: true,
			        url:"${pageContext.request.contextPath }/permission/loadAssign.do?roleid=${role.id}",
			        autoParam:["id", "name=n", "level=lv"]
			    }
			};
			
			$.fn.zTree.init($("#permissionTree"), setting);
			
			function assignPermission(){
				var treeObj = $.fn.zTree.getZTreeObj("permissionTree");
				
		    	var nodes = treeObj.getCheckedNodes(true); // 获取被选中的节点
		    	if (nodes.length == 0 ) {
		    		alert("请选择需要分配的许可信息");
		    		return false;
		    	} else {
		    		var dataObj = {"roleid":"${role.id}"};
		    		$.each(nodes, function(i, n){
		    			dataObj["ids["+i+"]"] = n.id;
		    		});
		    		var paramObj = {
		    				type	:	"POST",
		    				url		:	"${pageContext.request.contextPath }/role/assignPermission.do",
		    				data : dataObj,
			    			success : function( result ) {
			    				if ( result.success ) {
	    				    		alert("许可信息分配成功");
			    				} else {
			    					alert("许可信息分配失败");
			    				}
			    			}
		    		}
		    		$.ajax(paramObj);
		    	}
			}
	</script>
</body>
</html>