<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
	</style>
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
<form class="form-inline" cert="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input id="querytext" class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;" onclick="deleteCerts()"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${pageContext.request.contextPath}/cert/add.htm'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table id="certTable" class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input id="allBox" type="checkbox"></th>
                  <th>申请会员名称</th>
                  <th>流程名称</th>
                  <th>任务名称</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>
              </tbody>
			  <tfoot>
			     <tr >
				     <td colspan="6" align="center">
				        <div id="Pagination" class="pagination">
					 </td>
				 </tr>

			  </tfoot>
            </table>
          </div>
			  </div>
			</div>
        </div>
      </div>
    </div>
    <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-2.1.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/script/docs.min.js"></script>
	<script src="${pageContext.request.contextPath}/jquery/jquery.pagination.js"></script>
	<script src="${pageContext.request.contextPath}/jquery/jquery-form.min.js"></script>
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
			    
			    pageQuery(0);
            });
            
            $("#allBox").click(function(){
            	// 获取全选框的选中状态
            	//var flg = this.checked;
            	var that = this;
            	// 将每一个用户复选框的状态和全选框保持一致
            	//$.each(集合，回调方法);
            	$("#certTable tbody :checkbox").each(function(i, checkbox){
            		checkbox.checked = that.checked;
            	});
            });
            
            $("#queryBtn").click(function(){
            	var querytext = $("#querytext");
            	if ( querytext.val() == "" ) {
            		alert("查询条件不能为空，请输入");
            		$("#querytext").focus();
            	} else {
            		pageQuery(0);
            	}
            });
            
            var pagesize = 10;
            function pageQuery( pageIndex ) {
            	
            	//var obj = {};
            	//obj.na.me = "zhangsan";
            	//obj["na.me"] = "zhangsan";
            	
            	
            	var dataObj = {"pageno" : pageIndex+1,"pagesize" : pagesize};
            	var querytext = $("#querytext");
            	if ( querytext.val() != "" ) {
            		dataObj["querytext"] = querytext.val();
            	}
            	
            	$.ajax({
            		url : "${pageContext.request.contextPath}/auth/pageQuery.do",
            		type : "POST",
            		data : dataObj,
            		success : function( result ) {
            			if ( result.success ) {
            				// 页面渲染
            				var pageObj = result.page;
            				// 循环遍历
            				var content = "";
            				$.each(pageObj.datas, function(index, task){
            					// 相同类型的引号不能嵌套使用
	            	            content += '<tr>';
	          	                content += '  <td>'+(index+1)+'</td>';
	          					content += '  <td><input type="checkbox" value="'+task.id+'"></td>';
	          	                content += '  <td>'+task.membername+'</td>';
	          	                content += '  <td>'+task.pdname+'</td>';
	          	                content += '  <td>'+task.name+'</td>';
	          	                content += '  <td>';
	          					content += '      <button type="button" onclick="window.location.href=\'${pageContext.request.contextPath}/auth/show.htm?taskId='+task.id+'&memberid='+task.memberid+'\'"class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
	          					content += '  </td>';
	          	                content += '</tr>';
            				});
            				$("#certTable tbody").html(content);
            				
            				// 分页查询会在初始化后默认查询第一页的数据
            				// 由于实现方式不一样，所以需要注释掉插件中的查询第一页的方法（L158）
            				$("#Pagination").pagination(pageObj.totalsize, {
            					num_edge_entries: 2, //边缘页数
            					num_display_entries: 3, //主体页数
            					current_page: pageIndex,// 当前页码索引
            					callback: pageQuery,
            					prev_text:"上一页",
            					next_text:"下一页",
            					items_per_page:pagesize //每页显示数据条数
            				});
            			} else {
            	    		alert("分页查询失败");
            			}
            		}
            	});
            }
            
        </script>
  </body>
</html>