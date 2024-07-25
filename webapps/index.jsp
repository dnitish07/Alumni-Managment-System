<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="jakarta.servlet.ServletException"%>
<%@ page import="jakarta.servlet.http.HttpServlet"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>
<%@ page import="jakarta.servlet.http.HttpServletResponse"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<!-- Boxicons -->
	<link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
	<!-- My CSS -->
	<link rel="stylesheet" href="style.css">

	<title>Admin page</title>
</head>
<body>


	<!-- SIDEBAR -->
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
	<!-- SIDEBAR -->



	<!-- CONTENT -->
	<section id="content">
		<!-- NAVBAR -->
		<nav>
			<i class='bx bx-menu' ></i>
			<a href="adminhome.jsp" class="nav-link">Welcome Admin</a>
			<form action="#">
				<div class="form-input">
					<input type="search" placeholder="Search...">
					<button type="submit" class="search-btn"><i class='bx bx-search' ></i></button>
				</div>
			</form>
			<!--  <input type="checkbox" id="switch-mode" hidden>
			<label for="switch-mode" class="switch-mode"></label>-->
			<!--<a href="#" class="notification">
				<i class='bx bxs-bell' ></i>
				<span class="num">8</span>
			</a>-->
			<a href="#" class="profile">
				<img src="img02.webp">
			</a>
		</nav>
		<!-- NAVBAR -->

		<!-- MAIN -->
		<main>
			<div class="head-title">
				<div class="left">
					<h1>Alumni Managment System</h1>
					<!--<ul class="breadcrumb">
						<li>
							<a href="#">Dashboard</a>
						</li>
						<li><i class='bx bx-chevron-right' ></i></li>
						<li>
							<a class="active" href="#">Home</a>
						</li>
					</ul>-->
				</div>
			
			</div>

			<ul class="box-info">
				<li>
					
					<i class='bx bxs-group' ></i>
					<span class="text">
						<h3>
						
						<%

Connection con = null;
Statement stmt = null;
ResultSet rs = null;
ResultSet rm = null;

   try {
      // Load JDBC Driver
      Class.forName("com.mysql.jdbc.Driver");

      // Establish Connection
      con = DriverManager.getConnection(
         "jdbc:mysql://localhost:3306/alumni_db", "root", "");

      // Create Statement
      stmt = con.createStatement();

      // Execute Query
      rs = stmt.executeQuery("SELECT COUNT(*) AS num_active_alumni FROM alumnus_bio");

    // Move the cursor to the first row (if any)
    if (rs.next()) {
      int numActiveAlumni = rs.getInt(1); // Assuming the first column stores the number of rows
      out.println("" + numActiveAlumni);
    } else {
      out.println("No active alumni found.");
    }
   } catch (ClassNotFoundException e) {
      out.println("Driver not found: " + e.getMessage());
   } catch (SQLException e) {
      out.println(e);
   } finally {
      // Close resources
      
   }
%>
						
						</h3>
						<p>Alumni</p>
					</span>
				</li>
				<li>
					<i class='bx bxs-calendar-check' ></i>
					<span class="text">
						<h3><%
  // Assuming a connection object (`conn`) is already established

  // Execute the query to get the number of forum topics
  
try {
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT COUNT(*) AS num_active_alumni FROM forum_topics");

    // Check if there are any rows in the result set
    if (rs.next()) {
      int numTopics = rs.getInt(1); // Assuming the first column stores the number of rows (adjust if needed)
      out.println("" + numTopics);
    } else {
      out.println("No forum topics found.");
    }

  } catch (SQLException e) {
    out.println("Error executing query: " + e.getMessage());
  } finally {
    
  }
%></h3>
						<p>Forum Topics</p>
					</span>
				</li>
				<li>
					<i class='bx bxs-calendar-check' ></i>
					<span class="text">
						<h3> <%
                                            try {
                                                stmt = con.createStatement();
                                                rs = stmt.executeQuery("SELECT COUNT(*) AS num_active_alumni FROM careers");

                                                // Move the cursor to the first row (if any)
                                                if (rs.next()) {
                                                  int numActiveAlumni = rs.getInt(1); // Assuming the first column stores the number of rows
                                                  out.println("" + numActiveAlumni);
                                                } else {
                                                  out.println("No active alumni found.");
                                                }

                                              } catch (SQLException e) {
                                                out.println("Error executing query: " + e.getMessage());
                                              } finally {
                                                
                                              }
                                            
                                            %></h3>
						<p>Posted Jobs</p>
					</span>
				</li>
                <li>
					<i class='bx bxs-dollar-circle' ></i>
					<i class='bx bxs-calendar-check' ></i>
					<span class="text">
						<h3><%
                                            try {
                                                stmt = con.createStatement();
                                                rs = stmt.executeQuery("SELECT COUNT(*) AS num_active_alumni FROM events");

                                                // Move the cursor to the first row (if any)
                                                if (rs.next()) {
                                                  int numActiveAlumni = rs.getInt(1); // Assuming the first column stores the number of rows
                                                  out.println("" + numActiveAlumni);
                                                } else {
                                                  out.println("No active alumni found.");
                                                }

                                              } catch (SQLException e) {
                                                out.println("Error executing query: " + e.getMessage());
                                              } finally {
                                                
                                              }
                                            
                                            %></h3>
						<p>Upcoming Events</p>
					</span>
				</li>
			</ul>


			<!--  <div class="table-data">
				<div class="order">
					<div class="head">
						<h3>To Do</h3>
						<i class='bx bx-search' ></i>
						<i class='bx bx-filter' ></i>
					</div>
					<table>
						<thead>
							<tr>
								<th></th>
								<th>Date Order</th>
								<th>Status</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<img src="people.png">
									<p>Event 1</p>
								</td>
								<td>02-09-23</td>
								<td><span class="status completed">Completed</span></td>
							</tr>
							<tr>
								<td>
									<img src="people.png">
									<p>John Doe</p>
								</td>
								<td>01-10-2023</td>
								<td><span class="status pending">Pending</span></td>
							</tr>
							<tr>
								<td>
									<img src="people.png">
									<p>Event2</p>
								</td>
								<td>01-09-2023</td>
								<td><span class="status process">Process</span></td>
							</tr>
							<tr>
								<td>
									<img src="people.png">
									<p>Angelina</p>
								</td>
								<td>01-10-2023</td>
								<td><span class="status pending">Pending</span></td>
							</tr>
							<tr>
								<td>
									<img src="people.png">
									<p>Job Opportunity</p>
								</td>
								<td>07-08-2023</td>
								<td><span class="status completed">Completed</span></td>
							</tr>
						</tbody>
					</table>
				</div>-->
				<!--<div class="todo">
					<div class="head">
						<h3>Todos</h3>
						<i class='bx bx-plus' ></i>
						<i class='bx bx-filter' ></i>
					</div>
					<ul class="todo-list">
						<li class="completed">
							<p>Todo List</p>
							<i class='bx bx-dots-vertical-rounded' ></i>
						</li>
						<li class="completed">
							<p>Todo List</p>
							<i class='bx bx-dots-vertical-rounded' ></i>
						</li>
						<li class="not-completed">
							<p>Todo List</p>
							<i class='bx bx-dots-vertical-rounded' ></i>
						</li>
						<li class="completed">
							<p>Todo List</p>
							<i class='bx bx-dots-vertical-rounded' ></i>
						</li>
						<li class="not-completed">
							<p>Todo List</p>
							<i class='bx bx-dots-vertical-rounded' ></i>
						</li>
					</ul>
				</div>-->
			</div>
		</main>
		<!-- MAIN -->
	</section>
	<!-- CONTENT -->
	

	<script src="script.js"></script>
</body>
</html>