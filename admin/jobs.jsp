<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="styles.css">
<style>
	input[type=checkbox] {
		/* Double-sized Checkboxes */
		-ms-transform: scale(1.5); /* IE */
		-moz-transform: scale(1.5); /* FF */
		-webkit-transform: scale(1.5); /* Safari and Chrome */
		-o-transform: scale(1.5); /* Opera */
		transform: scale(1.5);
		padding: 10px;
	}
	td {
		vertical-align: middle !important;
	}
	td p {
		margin: unset;
	}
	img {
		max-width: 100px;
		max-height: 150px;
	}
</style>
<title>Jobs</title>
</head>
<body>
<section id="sidebar">
	<a href="index.jsp" class="brand">
		<img src="logo.png" style="height: 80px; width: 100px; margin: 10px; margin-top:50px;">
		<span class="text" style="padding: 5px; margin-top:40px; font-size: 40px;">Admin</span>
	</a>
	<ul class="side-menu top">
		<li class="active">
			<a href="index.jsp">
				<i class='bx bxs-dashboard' ></i>
				<span class="text">Home</span>
			</a>
		</li>
		<li>
			<a href="gallery.jsp">
				<i class='bx bxs-shopping-bag-alt' ></i>
				<span class="text">Gallery</span>
			</a>
		</li>
		<li>
			<a href="course.jsp">
				<i class='bx bxs-doughnut-chart' ></i>
				<span class="text">Course List</span>
			</a>
		</li>
		<li>
			<a href="alumni_list.jsp">
				<i class='bx bxs-message-dots' ></i>
				<span class="text">Alumni list</span>
			</a>
		</li>
		<li>
			<a href="jobs.jsp">
				<i class='bx bxs-group' ></i>
				<span class="text">Jobs</span>
			</a>
		</li>
		<li>
			<a href="forms.jsp">
				<i class='bx bxs-group' ></i>
				<span class="text">Forms</span>
			</a>
		</li>
		<li>
			<a href="events.jsp">
				<i class='bx bxs-group' ></i>
				<span class="text">Events</span>
			</a>
		</li>
	</ul>
	<ul class="side-menu">
		<li>
			<a href="settings.jsp">
				<i class='bx bxs-cog' ></i>
				<span class="text">Settings</span>
			</a>
		</li>
		<li>
			<a href="admin.html" class="logout">
				<i class='bx bxs-log-out-circle' ></i>
				<span class="text">Logout</span>
			</a>
		</li>
	</ul>
</section>
<section id="content">
	<nav>
		<i class='bx bx-menu' ></i>
		<a href="adminhome.jsp" class="nav-link">Welcome Admin</a>
		<form action="#">
			<div class="form-input">
				<input type="search" placeholder="Search...">
				<button type="submit" class="search-btn"><i class='bx bx-search' ></i></button>
			</div>
		</form>
		<input type="checkbox" id="switch-mode" hidden>
		<label for="switch-mode" class="switch-mode"></label>
		<a href="#" class="profile">
			<img src="people.png">
		</a>
	</nav>
	<main>
		<div class="container-fluid">
			<div class="col-lg-12">
				<div class="row mb-4 mt-4">
					<div class="col-md-12">
						
					</div>
				</div>
				<div class="row">
					<!-- Table Panel -->
					<div class="col-md-12">
						<div class="card">
							<div class="card-header">
								<b>Jobs List</b>
								<span>
									<button class="btn btn-primary btn-block btn-sm col-sm-2 float-right" type="button" id="new_career">
										<i class="fa fa-plus"></i> New</button>
								</span>
							</div>
							<div class="card-body">
								<table class="table table-bordered table-condensed table-hover">
									<thead>
										<tr>
											<th class="text-center">#</th>
											<th class="">Company</th>
											<th class="">Job Title</th>
											<th class="">Posted By</th>
											<th class="text-center">Action</th>
										</tr>
									</thead>
									<tbody>
										<%
										int i = 1;
										Connection conn = null;
										PreparedStatement stmt = null;
										ResultSet rs = null;
										try {
											Class.forName("com.mysql.jdbc.Driver");
											conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_db", "root", "");

											stmt = conn.prepareStatement("SELECT c.*, u.name FROM careers c INNER JOIN users u ON u.id = c.user_id ORDER BY id DESC");
											rs = stmt.executeQuery();
											while(rs.next()) {
												String company = rs.getString("company");
												String jobTitle = rs.getString("job_title");
												String postedBy = rs.getString("name");
												int jobId = rs.getInt("id");
										%>
										<tr>
											<td class="text-center"><%= i++ %></td>
											<td>
												<p><b><%= company %></b></p>
											</td>
											<td>
												<p><b><%= jobTitle %></b></p>
											</td>
											<td>
												<p><b><%= postedBy %></b></p>
											</td>
											<td class="text-center">
												<button class="btn btn-sm btn-outline-primary view_career" type="button" data-id="<%= jobId %>">View</button>
												<button class="btn btn-sm btn-outline-primary edit_career" type="button" data-id="<%= jobId %>">Edit</button>
												<button class="btn btn-sm btn-outline-danger delete_career" type="button" data-id="<%= jobId %>">Delete</button>
											</td>
										</tr>
										<%
											}
										} catch (Exception e) {
											e.printStackTrace();
										} finally {
											if (rs != null) {
												try {
													rs.close();
												} catch (SQLException e) {
													e.printStackTrace();
												}
											}
											if (stmt != null) {
												try {
													stmt.close();
												} catch (SQLException e) {
													e.printStackTrace();
												}
											}
											if (conn != null) {
												try {
													conn.close();
												} catch (SQLException e) {
													e.printStackTrace();
												}
											}
										}
										%>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- Table Panel -->
				</div>
			</div>
		</div>
	</main>
</section>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
<script>
	$(document).ready(function() {
		$('table').DataTable();
	});

	$('#new_career').click(function() {
		window.location.href = "manage_career.jsp";
	});

	$('.edit_career').click(function() {
		var jobId = $(this).attr('data-id');
		window.location.href = "manage_career.jsp?id=" + jobId;
	});

	$('.view_career').click(function() {
		var jobId = $(this).attr('data-id');
		window.location.href = "view_jobs.jsp?id=" + jobId;
	});

	$('.delete_career').click(function() {
		var jobId = $(this).attr('data-id');
		if (confirm("Are you sure to delete this post?")) {
			$.ajax({
				url: 'ajax.jsp?action=delete_career',
				method: 'POST',
				data: {
					id: jobId
					},
				success: function(resp) {
					if (resp == 1) {
						alert("Data successfully deleted");
						location.reload();
					} else {
						alert("Failed to delete data");
					}
				},
				error: function() {
					alert("Error occurred while processing your request");
				}
			});
		}
	});
</script>
</body>
</html>
