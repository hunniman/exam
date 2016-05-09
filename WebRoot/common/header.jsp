	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar" aria-expanded="false"
				aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#">星空广告</a>
		</div>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="nav navbar-nav">
				<c:if test="${sessionScope.USER_SESSION!=null}">
						<li><a href="<%=request.getContextPath()%>/project/">业务管理</a></li>
						<c:if test="${sessionScope.USER_SESSION.position==1}">
								<li><a href="<%=request.getContextPath()%>/user/list">用户管理</a></li>
			          	 </c:if>
						<li><a href="<%=request.getContextPath()%>/user/update?id=${sessionScope.USER_SESSION.id}&flag=1">个人信息管理</a></li>
						<li><a href="<%=request.getContextPath()%>/user/password">密码管理</a></li>
				</c:if>
			</ul>
			
			<ul class="nav navbar-nav navbar-right">
			   <c:if test="${sessionScope.USER_SESSION!=null}">
			        <li>
			        	<a>
			        		${sessionScope.USER_SESSION.name}
			        		 <c:if test="${sessionScope.USER_SESSION.position==1}">
			          		(管理员)
			          	 </c:if>
			          	 <c:if test="${sessionScope.USER_SESSION.position==0}">
			          		(业务员)
			          	 </c:if>
			        	</a>
			        </li>
			        <li><a href="<%=request.getContextPath()%>/user/logOut">  退出</a></li>
			   </c:if>
			   <c:if test="${sessionScope.USER_SESSION==null}">
			    	<li><a href="<%=request.getContextPath()%>/user/login">登陆</a></li>
			    	<li><a href="<%=request.getContextPath()%>/user/register">注册</a></li>
			   </c:if>
            </ul>
		</div>
		<!--/.nav-collapse -->
	</div>
	</nav>

