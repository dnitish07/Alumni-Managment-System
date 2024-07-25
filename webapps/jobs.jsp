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
			<a href="home.html" class="logout">
				<i class='bx bxs-log-out-circle' ></i>
				<span class="text">Logout</span>
			</a>
		</li>
	</ul>
</section>
<section id="content">
	<nav>
		<i class='bx bx-menu' ></i>
		<a href="index.jsp" class="nav-link">Welcome Admin</a>
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
                <!-- Optional content here -->
            </div>
        </div>
        <div class="row">
            <!-- Table Panel -->
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header" style="background-color: #e67760; color: white;">
                        <b>Jobs List</b>
                        <span>
                            <button class="btn" type="button" id="new_career" style="background-color: white; color: #e67760; border: 2px solid #e67760; border-radius: 5px; padding: 10px 20px; float: right; margin-left: 10px;">
                                <i class="fa fa-plus"></i> New
                            </button>
                        </span>
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered table-condensed table-hover">
                            <thead>
                                <tr>
                                    <th class="text-center">#</th>
                                    <th class="">Company</th>
                                    <th class="">Job Title</th>
                                    <th class="">Location</th>
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

                                    stmt = conn.prepareStatement("SELECT * FROM careers ORDER BY id ASC");
                                    rs = stmt.executeQuery();
                                    while (rs.next()) {
                                        String company = rs.getString("company");
                                        String jobTitle = rs.getString("job_title");
                                        String location = rs.getString("location");
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
                                        <p><b><%= location %></b></p>
                                    </td>
                                    <td class="text-center">
                                        <form action="ViewJob" method="post" style="display:inline;">
                                            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                            <button class="btn btn-sm" style="background-color: #e67760; color: white; border: none; border-radius: 5px;" type="submit">View</button>
                                        </form>
                                        <form action="EditJob" method="post" style="display:inline;">
                                            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                            <button class="btn btn-sm" style="background-color: #e67760; color: white; border: none; border-radius: 5px;" type="submit">Edit</button>
                                        </form>
                                        <form action="DeleteJob" method="post" style="display:inline;">
                                            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                            <button class="btn btn-sm" style="background-color: #e67760; color: white; border: none; border-radius: 5px;" type="submit">Delete</button>
                                        </form>
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

	
    document.getElementById('new_career').addEventListener('click', function() {
        window.location.href = 'opportunities.jsp';
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
