<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
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
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
			  </div>
			  <div class="panel-body">
<form class="form-inline" process="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input id="querytext" class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;" onclick="deleteProcesses()"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" id="uploadBtn" class="btn btn-primary" style="float:right;" ><i class="glyphicon glyphicon-open"></i> 上传</button>
<br>
 <hr style="clear:both;">
		          <div class="table-responsive">
					<table id="processTable" class="table  table-bordered">
		              <thead>
		                <tr >
		                  <th width="30">#</th>
		                  <th width="30"><input id="checkAll" type="checkbox"></th>
		                  <th>流程标识</th>
		                  <th>流程名称</th>
		                  <th>流程版本</th>
		                  <th width="100">操作</th>
		                </tr>
		              </thead>
		              <tbody>
		             </tbody>
		                <tfoot>
		                 <tr >
		                     <td colspan="6" align="center">
		                        <div id="Pagination" class="pagination">
		                         </div>
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
    
    <form id="uploadForm" action="${pageContext.request.contextPath }/process/deployProdDef.do" enctype="multipart/form-data" method="post">
    	 <input type="file" id="procDefFile" name="procDefFile" style="display:none;" >
    </form>

    <script src="${pageContext.request.contextPath }/jquery/jquery-2.1.1.min.js"></script>
    <script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath }/script/docs.min.js"></script>
	<script src="${pageContext.request.contextPath }/jquery/jquery.pagination.js"></script>
	<script src="${pageContext.request.contextPath }/jquery/jquery-form.min.js"></script>
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
            	$("#processTable tbody :checkbox").each(function(i, checkbox){
            		checkbox.checked = that.checked;
            	});
            });
            
            $("#queryBtn").click(function(){
            	var querytext = $("#querytext");
            	if ( querytext.val() == "" ) {
            		layer.msg("查询条件不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
            			querytext.focus();
            		});
            	} else {
            		pageQuery(0);
            	}
            });
            
            $("#uploadBtn").click(function(){
                $("#procDefFile").click();
            });
            
            $("#procDefFile").change(function(event){
            
                // 提交文件上传表单
                var loadingIndex = -1;
		    	$("#uploadForm").ajaxSubmit({
		    		
		    		success : function( r ) {
		    			if ( r.success ) {
		    				alert("流程定义部署成功");
	    				    pageQuery(0);
	    				    // 重置文件域对象
	    				    $("#uploadForm")[0].reset();
		    			} else {
		    				alert("流程定义部署失败");
		    			}
		    		}
		    	});
            });
            
            var loadingIndex = -1;
            var pagesize = 10;
            function pageQuery( pageIndex ) {
            	var dataObj = {"pageno":pageIndex+1,"pagesize":pagesize};
    			var querytext = $("#querytext");
    			if(querytext.val() != ""){
    				dataObj["querytext"] = querytext.val();
    			}
    			
    			var paramObj = {
    					url		:	"${pageContext.request.contextPath }/process/pageQuery.do",
    					type	:	"POST",
    					data	:	dataObj,
    					success	:	function(result){
    						if(result.success){
    							var pageObj = result.page;
    							var content = "";
    							$.each(pageObj.datas,function(index, process){
    								content+='<tr>';
    				                content+='  <td>'+(index+1)+'</td>';
    								content+='  <td><input type="checkbox" value="'+process.id+'"></td>';
    				                content+='  <td>'+process.key+'</td>';
    				                content+='  <td>'+process.name+'</td>';
    				                content+='  <td>'+process.version+'</td>';
    				                content+='  <td>';
    								content+='      <button type="button" onclick="window.location.href=\'${pageContext.request.contextPath}/process/show/'+process.id+'.htm\'" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-search"></i></button>';
    								content+='	  <button type="button" onclick="deleteProcess(\''+process.id+'\',\''+process.name+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
    								content+='  </td>';
    				                content+='</tr>';
    							});
    							
    							$("#processTable tbody").html(content);
    							
    							if(querytext.val() != ""){
    								$("#process_nums").empty();
    								$("#process_nums").append("共查询到"+pageObj.totalsize+"条数据");
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
            
            function deleteProcess(id, name) {
            	var r = confirm("确认删除"+name+"吗?");
            	if(r == false){
            		return;
            	}
    				
   				$.ajax({
   					url : "${pageContext.request.contextPath }/process/deleteProcess.do",
   					type : "POST",
   					data : {
   						id : id
   					},
   					success : function(result) {
   						if(result){
   							alert("删除流程成功!!!");
   							pageQuery(0);
						}else{
							alert("删除流程失败!!!");
						}
   					}
   				});
   			}
            
    		function deleteProcesses(){
    			var select_box = $("#processTable tbody :checked");
    			var len = select_box.length;
    			if(len == 0){
    				alert("请选择需要删除的流程");
    				return false;
    			}else{
    				var r = confirm("确认删除选中的流程信息吗?");
    				if(r){
    					var dataObj = {};
    					$.each(select_box,function(i,n){
    						dataObj["dfIds["+i+"]"] = n.value;
    						alert(n.value);
    					})
    					
    					paramObj = {
    						url		:	"${pageContext.request.contextPath}/process/deleteProcesses.do",
    						type	:	"post",
    						data	:	dataObj,
    						success	:	function(result){
    							if(result){
    								alert("删除流程成功!!!");
    	   							pageQuery(0);
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
