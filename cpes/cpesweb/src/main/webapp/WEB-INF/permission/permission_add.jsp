<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  <div class="modal-header">
	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	<h4 class="modal-title" id="myModalLabel">新增许可</h4>
  </div>
  <div class="modal-body">
				<form action="${pageContext.request.contextPath }/permission/addPermission.do" method="post" id="permissionForm" role="form">
				  <input type="hidden" id="pid" name="pid" value="${param.id}">
				  <div class="form-group">
					<label for="exampleInputEmail1">许可名称</label>
					<input type="text" class="form-control" id="name" name="name" placeholder="请输入许可名称">
				  </div>
				  <div class="form-group">
					<label for="exampleInputEmail1">链接地址</label>
					<input type="text" class="form-control" id="url" name="url" placeholder="请输入链接地址">
				  </div>

				</form>
  </div>
  <!---->
  <div class="modal-footer">
				  <button id="saveBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 新增</button>
				  <button type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
  </div>

	<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-2.1.1.min.js"></script>
	<script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath }/ztree/jquery.ztree.all-3.5.min.js"></script>
	<script type="text/javascript">
		$("#saveBtn").click(function(){
			var treeId = $("#id");
			var name = $("#name");
			var url = $("#url");
			var pid = $("#pid");
			if(name.val() == ""){
				alert("许可名称不能为空");
				return false;
			}
			
			var dataObj = {"name":name.val(),"url":url.val(),"pid":pid.val()};
			var paramObj = {
					type	:	"POST",
					url		:	"${pageContext.request.contextPath }/permission/addPermission.do",
					data	:	dataObj,
					success	:	function(result){
						if(result.success){
							$(".close").click();
							var treeObj = $.fn.zTree.getZTreeObj("permissionTree");
							treeObj.reAsyncChildNodes(null, "refresh");
						}else{
							alert("添加许可失败");
						}
					}
			}
			$.ajax(paramObj);
		})
	
	</script>
