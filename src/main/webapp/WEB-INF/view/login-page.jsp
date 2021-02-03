

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fonts/fontawesome-all.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fonts/font-awesome.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fonts/fontawesome5-overrides.min.css">
</head>

<body class="bg-gradient-primary">
<div class="container">
	<div class="row justify-content-center">
		<div class="col-md-9 col-lg-12 col-xl-10">
			<div class="card shadow-lg o-hidden border-0 my-5">
				<div class="card-body p-0">
					<div class="row">
						<div class="col-lg-6">
							<div class="p-5">
								<div class="text-center">
									<h1 class="text-dark mb-4"><div class="sidebar-brand-icon rotate"><i class="fas fa-mug-hot"></i></div></h1>
								</div>

								<div class="text-center">
									<h4 class="text-dark mb-4">Are you ready?</h4>
								</div>

								<div class="text-center">
									<h4 class="text-dark mb-4">Brew your coffee and Login!</h4>
								</div>

							</div>
						</div>
						<div class="col-lg-6">
							<div class="p-5">
								<div class="text-center">
									<h4 class="text-dark mb-4">Welcome to Sunday!</h4>
								</div>
								<div class="text-center">
									<div>
										<c:if test="${param.error != null}">
											<div class="alert alert-danger col-xs-offset-1 col-xs-10">
												Incorrect username or password.
											</div>
										</c:if>
										<c:if test="${param.logout != null}">
											<div class="alert alert-success col-xs-offset-1 col-xs-10">
												You have been logged out.
											</div>
										</c:if>
									</div>
								</div>
								<form:form action="${pageContext.request.contextPath}/authenticateTheUser" method="POST" class="user">
									<div class="form-group"><input class="form-control form-control-user" type="text" placeholder="Enter User Name" name="username"></div>
									<div class="form-group"><input class="form-control form-control-user" type="password" placeholder="Password" name="password"></div>
									<div class="form-group">
									</div><button class="btn btn-primary btn-block text-white btn-user" type="submit">Login</button>
								</form:form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/chart.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bs-init.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/theme.js"></script>
</body>

</html>


<%--<%@ page language="java" contentType="text/html; charset=UTF-8"--%>
<%--    pageEncoding="UTF-8"%>--%>
<%--<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>--%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--	<head>--%>
<%--		<meta name="viewport" content="width=device-width, initial-scale=1">--%>
<%--		<title> Login Page </title>--%>
<%--		<!-- Bootstrap CSS -->--%>
<%--	    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<%--	</head>--%>
<%--	<body>--%>

<%--		<div class="container mt-4">--%>

<%--			<form:form action="${pageContext.request.contextPath}/authenticateTheUser" method="POST" class="col-lg-6 offset-lg-3" >--%>
<%--	    		<div class="form-group">--%>
<%--			        <div class="col-xs-15">--%>
<%--			            <div>--%>
<%--	           				<c:if test="${param.error != null}">--%>
<%--								<div class="alert alert-danger col-xs-offset-1 col-xs-10">--%>
<%--									Incorrect username or password.--%>
<%--								</div>--%>
<%--							</c:if>--%>
<%--							<c:if test="${param.logout != null}">--%>
<%--								<div class="alert alert-success col-xs-offset-1 col-xs-10">--%>
<%--									You have been logged out.--%>
<%--								</div>--%>
<%--					   		</c:if>--%>
<%--			            </div>--%>
<%--			        </div>--%>
<%--			    </div>--%>
<%--				<div class="row justify-content-center">--%>
<%--					<div class="form-group">--%>
<%--						<label for="unamfe">Username:</label>--%>
<%--						<input type="text" name="username"  class="form-control mb-2" placeholder="Enter username">--%>
<%--					</div>--%>
<%--					<div class="form-group">--%>
<%--						<label for="pwd">Password:</label>--%>
<%--						<input type="password" name="password" class="form-control mb-2" placeholder="Enter password">--%>
<%--					</div>--%>

<%--					<div class="row justify-content-center">--%>
<%--						<button type="submit" class="btn btn-primary btn-dark btn-block mb-4">Sign in</button>--%>
<%--					</div>--%>
<%--				</div>--%>
<%--			</form:form>--%>
<%--		</div>--%>

<%--	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"></script>--%>
<%--	</body>--%>
<%--</html>--%>






