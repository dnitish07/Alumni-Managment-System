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
<!-- DataTables CSS -->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">
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
<title>Forms</title>
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
								<b>Forum List</b>
								<span>
									<button class="btn btn-primary btn-block btn-sm col-sm-2 float-right" type="button" id="new_forum">
										<i class="fa fa-plus"></i> New</button>
								</span>
							</div>
							<div class="card-body">
								<table id="forumTable" class="table table-bordered table-condensed table-hover">
									<colgroup>
										<col width="5%">
										<col width="20%">
										<col width="30%">
										<col width="20%">
										<col width="10%">
										<col width="15%">
									</colgroup>
									<thead>
										<tr>
											<th class="text-center">#</th>
											<th class="">Topic</th>
											<th class="">Description</th>
											<th class="">Created By</th>
											<th class="">Comments</th>
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

											stmt = conn.prepareStatement("SELECT f.*, u.name FROM forum_topics f INNER JOIN users u ON u.id = f.user_id ORDER BY f.id DESC");
											rs = stmt.executeQuery();
											while(rs.next()) {
												String title = rs.getString("title");
												String description = rs.getString("description");
												String createdBy = rs.getString("name");
												int forumId = rs.getInt("id");
												// Count comments for the forum topic
												int countComments = 0;
												PreparedStatement commentStmt = conn.prepareStatement("SELECT COUNT(*) AS comment_count FROM forum_comments WHERE topic_id = ?");
												commentStmt.setInt(1, forumId);
												ResultSet commentRs = commentStmt.executeQuery();
												if (commentRs.next()) {
													countComments = commentRs.getInt("comment_count");
												}
												commentRs.close();
												commentStmt.close();
										%>
										<tr>
											<td class="text-center"><%= i++ %></td>
											<td>
												<p><b><%= title %></b></p>
											</td>
											<td>
												<p class="truncate"><b><%= description %></b></p>
											</td>
											<td>
												<p><b><%= createdBy %></b></p>
											</td>
											<td class="text-right">
												<p><b><%= countComments %></b></p>
											</td>
											<td class="text-center">
											<form action="ViewForms" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                                <button class="btn btn-sm btn-outline-danger" type="submit">View</button>
                                            </form>
										    <form action="EditForms" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                                <button class="btn btn-sm btn-outline-danger" type="submit">Edit</button>
                                            </form>
                                            <form action="DeleteForms" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                                <button class="btn btn-sm btn-outline-danger" type="submit">Delete</button>
                                            </form>											</td>
										</tr>
										<%
											}
										} catch (Exception e) {
											e.printStackTrace();
										} finally {
											if (rs != null) {
												try {
													rs.close();
												} catch (Exception e) {
													e.printStackTrace();
												}
											}
											if (stmt != null) {
												try {
													stmt.close();
												} catch (Exception e) {
													e.printStackTrace();
												}
											}
											if (conn != null) {
												try {
													conn.close();
												} catch (Exception e) {
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
<!-- DataTables JS -->
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
<script src="script.js"></script>
<script>
	$(document).ready(function() {
		$('#forumTable').dataTable();
	});

	$('#new_forum').click(function() {
		uni_modal("New Entry", "manage_forum.jsp", 'mid-large');
	});

	$('.edit_forum').click(function() {
		uni_modal("Manage Job Post", "manage_forum.jsp?id=" + $(this).attr('data-id'), 'mid-large');
	});

	$('.delete_forum').click(function() {
		var forumId = $(this).attr('data-id');
		if (confirm("Are you sure to delete this topic?")) {
			deleteForum(forumId);
		}
	});

	function deleteForum(forumId) {
		$.ajax({
			url: 'ajax.php?action=delete_forum',
			method: 'POST',
			data: {
				id: forumId
			},
			success: function(resp) {
				if (resp == 1) {
					alert("Data successfully deleted");
					location.reload();
				} else {
					alert("Error deleting data");
				}
			},
			error: function(xhr, status, error) {
				alert("Error: " + error);
			}
		});
	}
</script>
</body>
</html>
