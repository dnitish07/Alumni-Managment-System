<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="styles.css">
<title>Course</title>
<style>
	td {
		vertical-align: middle !important;
	}
</style>
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
				<div class="row">
					<!-- FORM Panel -->
					<div class="col-md-4">
						<form action="Courses" method="Post" id="manage-course">
							<div class="card">
								<div class="card-header">
									Course Form
								</div>
								<div class="card-body">
									<input type="hidden" name="id">
									<div class="form-group">
										<label class="control-label">Course</label>
										<input type="text" class="form-control" name="course">
									</div>
								</div>
								<div class="card-footer">
									<div class="row">
										<div class="col-md-12">
											<button class="btn btn-sm btn-primary col-sm-3 offset-md-3"> Save</button>
											<button class="btn btn-sm btn-default col-sm-3" type="button" onclick="window.location.href='course.jsp'"> Cancel</button>
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
					<div class="col-md-8">
						<div class="card">
							<div class="card-header">
								<b>Course List</b>
							</div>
							<div class="card-body">
								<table class="table table-bordered table-hover">
									<thead>
										<tr>
											<th class="text-center">#</th>
											<th class="text-center">Course</th>
											<th class="text-center">Action</th>
										</tr>
									</thead>
									<tbody>
										<%
											int i = 1;
											Connection conn = null;
											Statement stmt = null;
											ResultSet rs = null;
											try {
												conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_db", "root", "");
												stmt = conn.createStatement();
												String query = "SELECT * FROM courses ORDER BY id ASC";
												rs = stmt.executeQuery(query);
												while (rs.next()) {
										%>
													<tr>
														<td class="text-center"><%= i++ %></td>
														<td class=""><%= rs.getString("course") %></td>
														<td class="text-center">
                                            <form action="EditCourse" method="post" style="display:inline;">
    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
    <button class="btn btn-sm btn-primary edit_course" type="submit">Edit</button>
</form>
	
                                            <form action="DeleteCourse" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                                <button class="btn btn-sm btn-outline-danger" type="submit">Delete</button>
                                            </form>														</td>
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

<script src="script.js"></script>
<script>
	$('#manage-course').submit(function(e){
		e.preventDefault();
		start_load();
		$.ajax({
			url: 'ajax.jsp?action=save_course',
			data: new FormData($(this)[0]),
			cache: false,
			contentType: false,
			processData: false,
			method: 'POST',
			type: 'POST',
			success: function(resp){
				if(resp == 1){
					alert_toast("Data successfully added", 'success');
					setTimeout(function(){
						location.reload();
					}, 1500);
				} else if(resp == 2){
					alert_toast("Data successfully updated", 'success');
					setTimeout(function(){
						location.reload();
					}, 1500);
				}
			}
		});
	});

	$('.edit_course').click(function(){
		start_load();
		var cat = $('#manage-course');
		cat.get(0).reset();
		cat.find("[name='id']").val($(this).attr('data-id'));
		cat.find("[name='course']").val($(this).attr('data-course'));
		end_load();
	});

	$('.delete_course').click(function(){
		_conf("Are you sure to delete this course?", "delete_course", [$(this).attr('data-id')]);
	});

	function delete_course(id){
		start_load();
		$.ajax({
			url: 'ajax.jsp?action=delete_course',
			method: 'POST',
			data: {id: id},
			success: function(resp){
				if(resp == 1){
					alert_toast("Data successfully deleted", 'success');
					setTimeout(function(){
						location.reload();
					}, 1500);
				}
			}
		});
	}

	$('table').dataTable();
</script>
</body>
</html>
