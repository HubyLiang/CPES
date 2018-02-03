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
			    <%@ include file="/WEB-INF/common/menu.jsp" %>
			</div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
			  </div>
			  <div class="panel-body">
                  <ul id="permissionTree" class="ztree"></ul>
			  </div>
			</div>
        </div>
      </div>
    </div>
    
    
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
		<div class="modal-content">
		</div>
	  </div>
	</div>    

	<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-2.1.1.min.js"></script>
	<script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath }/script/docs.min.js"></script>
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
	    
/* 	    var setting = {
		    	async	:	{
		    		url		:	"${pageContext.request.contextPath }/permission/load.do",
		    		enable	:	true,
		    		autoParam	:	["id","name=n","level=lv"]
		    	}
		    };
	    $.fn.zTree.init($("#permissionTree"), setting);
 */
 
		var setting = {
			view: {
				selectedMulti: false,
				addDiyDom: function(treeId, treeNode){
					var icoObj = $("#" + treeNode.tId + "_ico");
					if ( treeNode.icon ) {
						icoObj.removeClass("button ico_docu ico_open").addClass("fa fa-fw " + treeNode.icon).css("background","");
					}
				},
				addHoverDom: function(treeId, treeNode){
					var aObj = $("#" + treeNode.tId + "_a"); // $("#xxx_a")
					aObj.attr("href", "javascript:;");
					if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
					var s = '<span id="btnGroup'+treeNode.tId+'">';
					if ( treeNode.level == 0 ) {
						s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="${pageContext.request.contextPath }/permission/add.htm?id='+treeNode.id+'" data-toggle="modal" data-target="#myModal" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
					} else if ( treeNode.level == 1 ) {
						s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="${pageContext.request.contextPath }/permission/edit.htm?id='+treeNode.id+'" data-toggle="modal" data-target="#myModal" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
						if (treeNode.children.length == 0) {
							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteNode('+treeNode.id+', \''+treeNode.name+'\')" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
						}
						s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="${pageContext.request.contextPath }/permission/add.htm?id='+treeNode.id+'" data-toggle="modal" data-target="#myModal" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
					} else if ( treeNode.level == 2 ) {
						s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="${pageContext.request.contextPath }/permission/edit.htm?id='+treeNode.id+'" title="修改权限信息" data-toggle="modal" data-target="#myModal">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
						s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteNode('+treeNode.id+', \''+treeNode.name+'\')">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
					}
	
					s += '</span>';
					aObj.after(s);
				},
				removeHoverDom: function(treeId, treeNode){
					$("#btnGroup"+treeNode.tId).remove();
				}
			},
		    async: {
		        enable: true,
		        url:"${pageContext.request.contextPath }/permission/load.do",
		        autoParam:["id", "name=n", "level=lv"]
		    }
		};
		$.fn.zTree.init($("#permissionTree"), setting);
		
		
		function deleteNode(id, name) {
			var r = confirm("删除许可信息"+name+"，是否继续?");
			if(r){
				dataObj = {"id":id};
				paramObj ={
					type	:	"POST",
					url		:	"${pageContext.request.contextPath }/permission/deletePermission.do",
					data	:	dataObj,
					success	:	function(result){
						if(result.success){
							alert("数据删除成功");
							var treeObj = $.fn.zTree.getZTreeObj("permissionTree");
			  				treeObj.reAsyncChildNodes(null, "refresh");
						}else{
							alert("数据删除失败");
						}
					}
				}
				$.ajax(paramObj);
			}else{
				return false;
			}
		}
		
	</script>
</body>
</html>