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
<title>用户列表</title>
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
<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input id="querytext" class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-danger" onclick="deleteCerts()" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" onclick="window.location.href='${pageContext.request.contextPath }/cert/add.htm'" class="btn btn-primary" style="float:right;"><i class="glyphicon glyphicon-plus"></i> 新增</button>

<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table id="certTable" class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input type="checkbox" id="allBox" value="allBox"></th>
                  <th>资质名称</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody >
          		  <div id="cert_nums">
         			用户数据
          		  </div>
              </tbody>
			  <tfoot>
			     <tr >
				     <td colspan="5" align="center">
						<ul id="Pagination" class="pagination">
								
							 </ul>
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
    
   	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
		<div class="modal-content">
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
		    pageQuery(0);
	    });
		
		var pagesize = 10;
		function pageQuery(pageIndex){
			
			var dataObj = {"pageno":pageIndex+1,"pagesize":pagesize};
			var querytext = $("#querytext");
			if(querytext.val() != ""){
				dataObj["querytext"] = querytext.val();
			}
			
			var paramObj = {
					url		:	"${pageContext.request.contextPath }/cert/pageQuery.do",
					type	:	"POST",
					data	:	dataObj,
					success	:	function(result){
						if(result.success){
							var pageObj = result.page;
							var content = "";
							$.each(pageObj.datas,function(index, cert){
								content+='<tr>';
				                content+='  <td>'+(index+1)+'</td>';
								content+='  <td><input type="checkbox" value="'+cert.id+'"></td>';
				                content+='  <td>'+cert.name+'</td>';
				                content+='  <td>';
								content+='      <button type="button" onclick="window.location.href=\'${pageContext.request.contextPath}/cert/assign/'+cert.id+'.htm\'" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-search"></i></button>';
								content+='      <button type="button" onclick="window.location.href=\'${pageContext.request.contextPath}/cert/to_edit/'+cert.id+'.htm\'" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
								content+='	  <button type="button" onclick="deleteCert('+cert.id+',\''+cert.certname+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
								content+='  </td>';
				                content+='</tr>';
							});
							
							$("#certTable tbody").html(content);
							
							if(querytext.val() != ""){
								$("#cert_nums").empty();
								$("#cert_nums").append("共查询到"+pageObj.totalsize+"条数据");
							}
							//设置页码
							$("#Pagination").pagination(pageObj.totalsize, {
            					num_edge_entries: 2, //边缘页数
            					num_display_entries: 3, //主体页数
            					current_page: pageIndex,// 当前页码索引
            					callback: pageQuery,
            					prev_text:"上一页",
            					next_text:"下一页",
            					items_per_page:pagesize //每页显示数据条数
            				});
							
						}else{
							alert("分页查询失败");
						}
					}
				} 
				$.ajax(paramObj);
			}
		
		$("#queryBtn").click(function(){
			var querytext = $("#querytext");
			if(querytext.val()==""){
				alert("请输入查询条件");
				$("#querytext").focus();
			}else{
				pageQuery(0);
			}
		})
		
		
		 
		 function deleteCert(id,certname){
			var r = confirm("确认删除"+certname+"吗?");
			if(r == true){
				dataObj = {"id"  :	id};	
				paramObj = {
						"url"	:	"${pageContext.request.contextPath}/cert/deleteCert.do",
						"type"	:	"POST",
						"data"	:	dataObj,
						success	:	function(result){
							if(result){
								window.location.href="${pageContext.request.contextPath}/cert/index.htm";
							}else{
								alert("删除用户失败!!!");
							}
						}
				}
				$.ajax(paramObj);
			}else{
				return false;
			}
		}
		
		$("#allBox").click(function(){
			var that = this;
			$("#certTable tbody :checkbox").each(function(i,checkbox){
				checkbox.checked = that.checked;
			})
		})
		
		function deleteCerts(){
			var select_box = $("#certTable tbody :checked");
			var len = select_box.length;
			if(len == 0){
				alert("请选择需要删除的用户");
				return false;
			}else{
				var r = confirm("确认删除选中的用户信息吗?");
				if(r){
					var dataObj = {};
					$.each(select_box,function(i,n){
						dataObj["ids["+i+"]"] = n.value;
					})
					
					paramObj = {
						url		:	"${pageContext.request.contextPath}/cert/deleteCerts.do",
						type	:	"post",
						data	:	dataObj,
						success	:	function(result){
							if(result){
								window.location.href="${pageContext.request.contextPath}/cert/index.htm";
							}else{
								alert("删除用户失败!!!");
							}
						}
					}
					
					$.ajax(paramObj);
				}else{
					return false;
				}
			}
		}
		
	</script>
</body>
</html>