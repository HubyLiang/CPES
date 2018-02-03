<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<ul style="padding-left:0px;" class="list-group">
    <c:forEach items="${menus }" var="menu">
            <c:if test="${empty menu.children }">
                <li class="list-group-item tree-closed" >
                    <a href="${pageContext.request.contextPath}${menu.url }"><i class="fa fa-fw ${menu.icon }"></i> ${menu.name }</a> 
                </li>
            </c:if>    
            <c:if test="${not empty menu.children }">
                <li class="list-group-item tree-closed">
                    <span><i class="fa fa-fw ${menu.icon }"></i> ${menu.name } <span class="badge" style="float:right">${fn:length(menu.children)}</span></span> 
                    <ul style="margin-top:10px;display:none;">
                        <c:forEach items="${ menu.children }" var="children">
                                <li style="height:30px;">
                                    <a href="${pageContext.request.contextPath}${children.url }"><i class="fa fa-fw ${children.icon }"></i> ${ children.name}</a> 
                                </li>
                        </c:forEach>
                    </ul>
                </li>
            </c:if>                
    </c:forEach>
</ul>
