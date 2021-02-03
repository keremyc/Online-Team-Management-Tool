<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
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
					<form class="form-inline d-none d-sm-inline-block mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
						<div class="input-group"><input class="bg-light form-control border-0 small" type="text" placeholder="Search for teams">
							<div class="input-group-append"><button class="btn btn-primary py-0" type="button"><i class="fas fa-search"></i></button></div>
						</div>
					</form>
					<ul class="nav navbar-nav flex-nowrap ml-auto">
						<li class="nav-item dropdown d-sm-none no-arrow"><a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#"><i class="fas fa-search"></i></a>
							<div class="dropdown-menu dropdown-menu-right p-3 animated--grow-in" aria-labelledby="searchDropdown">
								<form class="form-inline mr-auto navbar-search w-100">
									<div class="input-group"><input class="bg-light form-control border-0 small" type="text" placeholder="Search for ...">
										<div class="input-group-append"><button class="btn btn-primary py-0" type="button"><i class="fas fa-search"></i></button></div>
									</div>
								</form>
							</div>
						</li>

						<div class="d-none d-sm-block topbar-divider"></div>
						<li class="nav-item dropdown no-arrow">
							<div class="nav-item dropdown no-arrow">
								<a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#">
									<span class="d-none d-lg-inline mr-2 text-gray-600 small">${currentUser.firstName} ${currentUser.lastName}</span>
									<img class="border rounded-circle img-profile" src="${pageContext.request.contextPath}/resources/img/usericon.png">
								</a>
								<div class="dropdown-menu shadow dropdown-menu-right animated--grow-in">
									<a class="dropdown-item" href="profile.html">
										<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>&nbsp;Profile
									</a>
									<div class="dropdown-divider"></div>


									<form:form action="${pageContext.request.contextPath}/logout" method="POST">
										<button type="submit" class="dropdown-item">
											<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-dark">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Logout</i>
										</button>
									</form:form>
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
									<h3 class="text-dark mb-0">YOUR TASKS</h3>
								</div>
							</div>

							<c:forEach var="task" items="${currentUser.assignedTasks}">
								<input type="hidden" name="teamId" value="${task.id}"/>

								<div class="col-md-12 col-xl-6 mb-4">
									<div class="card shadow border-left-info py-2" >
										<div class="card-body py-0">
											<div class="row pt-2">&nbsp;&nbsp;${task.ownerProject.ownerTeam.name}</div>
											<hr>
											<div class="row">
												<div class="col">
													<div class="font-weight-bold text-m mb-1"><span>Task: </span><span class="font-weight-normal">${task.taskTitle}</span></div>
													<div class="font-weight-bold text-m mb-1"><span>End Date: </span><span class="font-weight-normal">${task.finishDate}</span></div>
												</div>
												<div class="col-auto align-self-end pr-0"><span class="badge badge-success">${task.status}</span></div>
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
								<h3 class="text-dark mb-0">TEAMS</h3>
								<button type="button" class="btn btn-primary btn-sm d-none d-sm-inline-block" data-toggle="modal" data-target="#createTeamModal">Create Team</button>
							</div>
						</div>

						<c:forEach var="team" items="${currentUser.registeredTeams}">
							<a href="${pageContext.request.contextPath}/team/details?teamId=${team.id}" style="text-decoration: none;">
								<div class="col-12 mb-2">
									<div class="card bg-white border-secondary shadow">
										<div class="card-body">
											<div class="row">
												<div class="col">
													<div class="font-weight-bold text-m">${team.name}</div>
												</div>
												<div class="col-auto align-self-end pr-0"><span class="badge badge-info"># USER ROLE #</span></div>
											</div>
										</div>
									</div>
								</div>
							</a>
						</c:forEach>

					</div>
				</div>
			</div>


			<!-- Create Team Modal -->
			<div class="modal fade bd-example-modal-lg" id="createTeamModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
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
														<h4 class="text-dark mb-4">Create an Team!</h4>
													</div>
													<form:form action="${pageContext.request.contextPath}/team/create" method="POST" class="user" modelAttribute="team">
														<div class="form-group"><strong>Team Name* </strong><form:input path="name" class="form-control form-control-user" /></div>
														<div class="form-group"><strong>Team Description* </strong><form:input path="description" class="form-control form-control-user" /></div>
														<div class="form-group">
															<strong>Select a category* </strong>
															<form:select path="category" class="form-control" id="sel1">
																<option>Back-End Development</option>
																<option>Front-End Development</option>
																<option>Mobile Development</option>
																<option>Testing</option>
															</form:select>
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

			<div class="col-md-12 col-lg-4 col-xl-4 mb-4">
				<div class="col-12">
					<div class="d-sm-flex justify-content-between align-items-center mb-4">
						<h3 class="text-dark mb-0">Pending Invitations</h3>
					</div>
				</div>
				<c:forEach var="inv" items="${currentUser.invitingTeams}">
					<div class="col-12 mb-2">
						<div class="card bg-white border-secondary shadow">
							<div class="card-body">
								<div class="row">
									<div class="col">
										<div class="font-weight-bold text-lg">${inv.name}</div>
									</div>
									<form:form method="POST" action="${pageContext.request.contextPath}/user/acceptInv">
										<input type="hidden" name="teamId" value="${inv.id}">
										<button type="submit" class="btn btn-primary align-self-end  btn-sm">Join</button>
									</form:form>&nbsp;&nbsp;
									<form:form method="POST" action="${pageContext.request.contextPath}/user/declineInv">
										<input type="hidden" name="teamId" value="${inv.id}">
										<button type="submit" class="btn btn-danger align-self-end  btn-sm">Decline</button>
									</form:form>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>

        <footer class="bg-white sticky-footer">
            <div class="container my-auto">
                <div class="text-center my-auto copyright"><span>Sunday - 2021</span></div>
            </div>
        </footer>
        <a class="border rounded d-inline scroll-to-top" href="#page-top"><i class="fas fa-angle-up"></i></a>
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