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
					<button type="button" class="btn" data-toggle="modal" data-target="#exampleModal"><h3 class="text-dark mb-0">${currentProject.name}</h3></button>

					<ul class="nav navbar-nav flex-nowrap ml-auto">
						<div class="d-none d-sm-block topbar-divider"></div>
						<li class="nav-item dropdown no-arrow">
							<div class="nav-item dropdown no-arrow"><a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#"><span class="d-none d-lg-inline mr-2 text-gray-600 small">${currentUser.firstName} ${currentUser.lastName}</span><img class="border rounded-circle img-profile" src="${pageContext.request.contextPath}/resources/img/usericon.png"></a>
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
									<h5 class="text-info mb-0">TASKS OF PROJECT</h5>
								</div>

							</div>
							<c:forEach var="task" items="${currentProject.projectTasks}">
								<div class="col-md-12 col-xl-12 mb-4">
									<div class="card border-bottom-info">
										<div class="card-content">
											<div class="card-body">
												<h4 class="card-title text-dark">${task.taskTitle}</h4>

												<hr>
												<div class="row">
														<div class="col-md-6 col-xl-6">
															<div class="font-weight-bold text-m mb-1">
																<span>Decsription: </span><span class="font-weight-normal">${task.description}</span>
															</div>
														</div>
														<div class="col-md-6 col-xl-6">
															<div class="font-weight-bold text-m mb-1">
																<span>Start Date: </span><span class="font-weight-normal">${task.startDate}</span>
															</div>
														</div>
														<div class="col-md-6 col-xl-6">
															<div class="font-weight-bold text-m mb-1">
																<span>End Date: </span><span class="font-weight-normal">${task.finishDate}</span></div>
														</div>
														<div class="col-md-6 col-xl-6">
															<div class="font-weight-bold text-m mb-1">
																<span>Status: </span><span class="font-weight-normal">${task.status}</span>
															</div>
														</div>
														<c:forEach var="resp" items="${task.respondents}">
															<div class="col-md-6 col-xl-6">
																<div class="font-weight-bold text-m mb-1">
																	<span>Respondent: </span><span class="font-weight-normal">${resp.firstName} ${resp.lastName}</span>
																</div>
															</div>
														</c:forEach>

														<div class="col-md-12 col-xl-12 text-right">
															<div>
																<a href="${pageContext.request.contextPath}/proj/deleteTask?taskId=${task.id}">
																	<span class="badge badge-danger">
																		<i class="far fa-trash-alt"></i>
																	</span>
																</a>
																&nbsp;&nbsp;
																<a href="${pageContext.request.contextPath}/proj/mark?taskId=${task.id}">
																	<span class="badge badge-success">
																		<i class="far fa-check-square"></i>
																	</span>
																</a>
															</div>
														</div>

													<div class="col-auto align-self-end pr-0"></div>
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
								<h5 class="mb-0">Task Members</h5>
								<button type="button" class="btn btn-primary btn-sm d-none d-sm-inline-block" data-toggle="modal" data-target="#createProjectModal">Create Task</button>
							</div>
						</div>
						<div class="col-12 mb-2">
							<ul class="list-group text-dark">
								<!-- PROJECT MEMBERS -->
								<c:forEach var="member" items="${projectMembers}">
									<li class="list-group-item border-left-secondary">${member.firstName} ${member.lastName}</li>
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
						<h5 class="modal-title text-dark" id="exampleModalLabel">Project Details</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<h6 class="text-dark"><strong>Owner Team: </strong>${currentProject.ownerTeam.name}</h6>
						<h6 class="text-dark"><strong>Project Name: </strong>${currentProject.name}</h6>
						<h6 class="text-dark"><strong>Project Description: </strong>${currentProject.description}</h6>
						<h6 class="text-dark"><strong>Project Manager: </strong>${currentProject.manager.firstName} ${currentProject.manager.lastName}</h6>
						<h6 class="text-dark"><strong>Project Created Date: </strong>${currentProject.createdAt}</h6>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
		<!-- Detail Modal End -->

		<!-- Create Task Modal -->
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
													<h4 class="text-dark mb-4">Create an Task!</h4>
												</div>
												<form:form action="${pageContext.request.contextPath}/proj/createTask" method="POST" modelAttribute="task" class="user">
													<div class="form-group"><strong>Task Title* </strong>
														<form:input path="taskTitle" type="text" class="form-control form-control-user" required="true"/>
													</div>
													<div class="form-group"><strong>Task Description* </strong>
														<form:input path="description" type="text" class="form-control form-control-user"/>
													</div>
													<div class="form-group"><strong>Start Date* </strong>
														<form:input path="startDate" class="form-control" type="date" value="2021-02-02"/>
													</div>
													<div class="form-group"><strong>Finish Date* </strong>
														<form:input path="finishDate" class="form-control" type="date" value="2021-02-02"/>
													</div>
													<div class="form-group">
														<div><strong>Task Respondents* </strong></div>
														<div class="custom-control custom-checkbox small">
															<c:forEach var="teamMember" items="${currentTeam.teamMembers}">
																<form:checkbox path="respondents"
																			   class="form-check-input"
																			   label="${teamMember.firstName} ${teamMember.lastName}"
																			   value="${teamMember.userName}"/>
															</c:forEach>
														</div>
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

		<footer class="bg-white sticky-footer">
			<div class="container my-auto">
				<div class="text-center my-auto copyright"><span>Copyright © Brand 2021</span></div>
			</div>
		</footer>
	</div><a class="border rounded d-inline scroll-to-top" href="#page-top"><i class="fas fa-angle-up"></i></a>
</div>


<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/chart.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bs-init.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/theme.js"></script>

</body>
</html>