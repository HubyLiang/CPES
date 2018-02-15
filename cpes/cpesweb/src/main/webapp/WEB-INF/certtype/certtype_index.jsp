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
<title>账户类型和资质</title>
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
<button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${APP_PATH}/cert/add.htm'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table id="certTable" class="table  table-bordered">
              <thead>
                <tr >
                  <th>证件图片</th>
				  <th >商业公司</th>
                  <th>个体工商户 </th>
                  <th>个人经营 </th>
                  <th>政府及非营利组织  </th>
                </tr>
              </thead>
              <tbody>
                  <c:forEach items="${certs }" var="cert">
                  	<tr >
	                  <th>${cert.name}</th>
					  <th ><input type="checkbox" data-acctype="0" data-certid="${cert.id}"></th>
	                  <th><input type="checkbox"  data-acctype="1" data-certid="${cert.id}"></th>
	                  <th><input type="checkbox"  data-acctype="2" data-certid="${cert.id}"> </th>
	                  <th><input type="checkbox"  data-acctype="3" data-certid="${cert.id}"> </th>
	                </tr>
                  </c:forEach>
              </tbody>
            </table>
          </div>
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
		    

	 	    /* $.each(acctCerts,function(i,acctCert){
		    	alert(acctCert);
		    	alert(i);
		    	var box = $("#certTable :checkbox[data-acctype='${acctCert.acctype}'][data-certid='${acctCert.certid}']");
	            box[0].checked = true; 
		    })   */

	    });		
	    
        $("#certTable :checkbox").click(function(){
            var flg = this.checked;
            var certid = $(this).attr("data-certid");
            var acctype = $(this).attr("data-acctype");
            
            if ( flg ) {
                $.ajax({
                    type : "POST",
                    url  : "${pageContext.request.contextPath }/certtype/insert.do",
                    data : {
                        certid : certid,
                        acctype : acctype
                    },
                    dataType: 'json'
                });
            } else {
                $.ajax({
                    type : "POST",
                    url  : "${pageContext.request.contextPath }/certtype/delete.do",
                    data : {
                        certid : certid,
                        acctype : acctype
                    }
                });
            }
        });
        
	    var acctCerts = eval('${acctCerts}');
	    console.log(acctCerts);
		
		init(acctCerts);
		
		function init(json){
			$.each(json,function(index,acctCert){
				console.log(acctCert);
				var type=acctCert.acctype;
				var id=acctCert.certid;
				var j="#certTable :checkbox[data-acctype="+type+"][data-certid="+id+"]";
		    	var box = $(j);
	            box[0].checked = true; 	
			})
		}

        
		  
/*  		for(int i = 0;i<acctCerts.length;i++){
			acctCert = acctCerts[i];
			alert(acctCert);
		}  */
        

	    

	</script>
</body>
</html>