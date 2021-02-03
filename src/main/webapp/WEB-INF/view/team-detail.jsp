<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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

<body id="page-top">
    <div id="wrapper">
    	<%@ include file="navbar.jsp" %>


        <div class="d-flex flex-column" id="content-wrapper">
            <div id="content">
                <nav class="navbar navbar-light navbar-expand bg-white shadow mb-4 topbar static-top">
                    <div class="container-fluid"><button class="btn btn-link d-md-none rounded-circle mr-3" id="sidebarToggleTop" type="button"><i class="fas fa-bars"></i></button>
                        <!-- Button trigger modal -->
                        <button type="button" class="btn" data-toggle="modal" data-target="#exampleModal"><h3 class="text-dark mb-0">${currentTeam.name}</h3></button>

                        <ul class="nav navbar-nav flex-nowrap ml-auto">
                            <div class="d-none d-sm-block topbar-divider"></div>
                            <li class="nav-item dropdown no-arrow">
                                <div class="nav-item dropdown no-arrow"><a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#">
                                    <span class="d-none d-lg-inline mr-2 text-gray-600 small">${currentUser.firstName} ${currentUser.lastName}</span>
                                    <img class="border rounded-circle img-profile" src="${pageContext.request.contextPath}/resources/img/usericon.png"></a>
                                    <div class="dropdown-menu shadow dropdown-menu-right animated--grow-in">
                                        <a class="dropdown-item" href="profile.html">
                                            <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>&nbsp;Profile
                                        </a>
                                        <div class="dropdown-divider"></div><a class="dropdown-item" href=""><i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>&nbsp;Logout</a>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>


                <div class="container-fluid">
                    <div class="row">

                        <div class="col-md-12 col-lg-8 col-xl-8 mb-4">
                            <div class="row">
                                <div class="col-md-12 col-xl-12">
                                    <div class="d-sm-flex justify-content-between align-items-center mb-4">
                                        <h5 class="text-info mb-0">PROJECTS OF TEAM</h5>
                                        <button type="button"
                                                class="btn btn-primary btn-sm d-none d-sm-inline-block"
                                                data-toggle="modal" data-target="#createProjectModal">Create Project</button>
                                    </div>
                                </div>
                                <c:forEach var="project" items="${currentTeam.teamProjects}">
                                        <div class="col-md-6 col-xl-6 mb-4">
                                            <div class="card border-bottom-info">
                                                <div class="card-content">
                                                    <div class="card-body">
                                                        <a href="${pageContext.request.contextPath}/proj/details?projectId=${project.id}">
                                                            <h4 class="card-title text-dark">${project.name}</h4>
                                                        </a>
                                                        <hr>
                                                        <div class="media d-flex">
                                                            <div class="media-body text-left">
                                                                <h5 class="success"># LATER #</h5>
                                                                <span class="text-dark">Members</span>
                                                            </div>
                                                            <div class="media-body text-left">
                                                                <h5 class="success">${project.projectTasks.size()}</h5>
                                                                <span class="text-dark">Tasks</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12 col-xl-12 text-right">
                                                        <div>
                                                            <a href="${pageContext.request.contextPath}/team/deleteProj?projId=${project.id}">
																	<span class="badge badge-danger">
																		<i class="far fa-trash-alt"></i>
																	</span>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                </c:forEach>
                            </div>
                        </div>


                        <div class="col-md-12 col-lg-4 col-xl-4 mb-4">
                            <div class="col-12">
                                <div class="d-sm-flex justify-content-between align-items-center mb-4">
                                    <h5 class="mb-0">Team Members</h5>
                                    <button type="button" class="btn btn-primary btn-sm d-none d-sm-inline-block" data-toggle="modal" data-target="#inviteModal">Send Invitation</button>
                                </div>
                            </div>
                            <div class="col-12 mb-2">
                                <ul class="list-group text-dark">
                                    <c:forEach var="member" items="${currentTeam.teamMembers}">
                                        <li class="list-group-item border-left-secondary">
                                                ${member.firstName} ${member.lastName}
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Detail Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title text-dark" id="exampleModalLabel">Team Details</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <h6 class="text-dark"><strong>Team Name: </strong>${currentTeam.name}</h6>
                            <h6 class="text-dark"><strong>Team Description: </strong>${currentTeam.description}</h6>
                            <h6 class="text-dark"><strong>Team Manager: </strong>${currentTeam.manager.firstName} ${currentTeam.manager.lastName}</h6>
                            <h6 class="text-dark"><strong>Team Created Date: </strong>${currentTeam.createdAt}</h6>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Detail Modal End -->

            <!-- Create Project Modal -->
            <div class="modal fade bd-example-modal-lg" id="createProjectModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-body">
                            <div class="container">
                                <div class="card shadow-lg o-hidden border-0 my-2">
                                    <div class="card-body p-0">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="p-5">
                                                    <div class="text-center">
                                                        <h4 class="text-dark mb-4">Create an Project!</h4>
                                                    </div>
                                                    <form:form action="${pageContext.request.contextPath}/proj/create" method="POST" class="user" modelAttribute="project">
                                                        <div class="form-group"><strong>Project Title* </strong><form:input path="name"  class="form-control form-control-user"/></div>
                                                        <div class="form-group"><strong>Project Description* </strong><form:input path="description" class="form-control form-control-user"/></div>
                                                        <div class="form-group">
                                                            <div><strong>Project Manager* </strong></div>
                                                            <form:select class="form-control"  path="manager">
                                                                <c:forEach var="user" items="${currentTeam.teamMembers}">
                                                                    <form:option label="${user.firstName} ${user.lastName}" value="${user.userName}"/>
                                                                </c:forEach>
                                                            </form:select><br>
                                                        </div>
                                                        <button class="btn btn-primary btn-block text-white btn-user" type="submit">Create</button>
                                                    </form:form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Create Project Modal -->

            <!-- Invite Model -->
            <div class="modal fade bd-example-modal-lg" id="inviteModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-body">
                            <div class="container">
                                <div class="card shadow-lg o-hidden border-0 my-2">
                                    <div class="card-body p-0">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="p-5">
                                                    <div class="text-center">
                                                        <h4 class="text-dark mb-4">Invite people to your team!</h4>
                                                    </div>
                                                    <form:form action="${pageContext.request.contextPath}/user/invite" method="POST" class="user">
                                                        <div class="form-group"><strong>User Name* </strong><input class="form-control form-control-user" type="text" name="userName" required="true"></div>
                                                        <div class="form-group">
                                                            <button class="btn btn-primary btn-block text-white btn-user" type="submit">Invite!</button>
                                                    </form:form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Invite Modal  End -->

            <footer class="bg-white sticky-footer">
                <div class="container my-auto">
                    <div class="text-center my-auto copyright"><span>Copyright © Brand 2021</span></div>
                </div>
            </footer>
        </div><a class="border rounded d-inline scroll-to-top" href="#page-top"><i class="fas fa-angle-up"></i></a>
    </div>
<%--<div class="container">--%>
<%--	<div class="row"><h3 id="teamName" class="card-title">TEAM DETAILS</h3></div>--%>
<%--  <div class="row">--%>
<%--    <div class="col-3">--%>
<%--		<div class="card">--%>
<%--		  <img src="${pageContext.request.contextPath}/resources/img/team.jpg" class="card-img-top" alt="Card image">--%>
<%--		  <div class="card-body">--%>
<%--		    <h5 id="teamName" class="card-title"> ${currentTeam.name}</h5>--%>
<%--		    <p id="teamDesc" class="card-text">${currentTeam.description}</p>--%>
<%--		  </div>--%>
<%--		  <ul class="list-group list-group-flush">--%>
<%--		    <li id="teamCategory" class="list-group-item"><strong>Category</strong> <br/>${currentTeam.category}</li>--%>
<%--		    <li id="createdData" class="list-group-item"><strong>Created Date</strong> <br/><fmt:formatDate type="both" dateStyle="short" timeStyle="short" value="${currentTeam.createdAt}"/></li>--%>
<%--		  </ul>--%>
<%--		</div>--%>
<%--    </div>--%>
<%--        <!-- 2. kolon -->--%>
<%--<div class="col">--%>

<%--      <!-- Projects için list -->--%>
<%--<div class="card" >--%>
<%--  <div class="card-header">--%>
<%--    Projects--%>
<%--    <button type="button" class="btn btn-sm btn-dark right-float" onclick="window.location.href='../proj/getForm'; return false;">Create Project</button>--%>
<%--  </div>--%>
<%--  <div class="list-group">--%>
<%--   	--%>
<%--     	<c:forEach var="project" items="${currentTeam.teamProjects}">--%>
<%-- 			<form:form action="${pageContext.request.contextPath}/proj/details" method="GET">--%>
<%--	 			<input type="hiqden" name="projectId" value="${project.id}"/>--%>
<%--				<button type="submit" class="list-group-item list-group-item-action">${project.name}</button>--%>
<%--			</form:form>--%>
<%--   		</c:forEach>--%>
<%--   	--%>
<%--  </div>--%>
<%--</div>--%>

<%--    </div>--%>
<%--    <div class="col-4">--%>
<%--      --%>

<%--<div class="card">--%>
<%--  <div class="card-header">--%>
<%--    Team Members--%>
<%--    <button type="button" class="btn btn-sm btn-dark right-float">Send Invitation</button>--%>
<%--  </div>--%>
<%--  <ul class="list-group list-group-flush">--%>
<%--	<c:forEach var="member" items="${currentTeam.teamMembers}">--%>
<%--	    <li class="list-group-item">${member.firstName} ${member.lastName}</li>--%>
<%--	</c:forEach>--%>
<%--	</ul>--%>

<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>



    <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/chart.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bs-init.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/theme.js"></script>

</body>
</html>