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
 <% 
        String message = null;

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String schedule = request.getParameter("schedule");
            String banner = request.getParameter("banner");
            String dateCreated = request.getParameter("date_created");

            Connection conn = null;
            PreparedStatement stmt = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_db", "root", "");

                String sql = "INSERT INTO events (title, content, schedule, banner, date_created) VALUES (?, ?, ?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, title);
                stmt.setString(2, content);
                stmt.setString(3, schedule);
                stmt.setString(4, banner);
                stmt.setString(5, dateCreated);

                int rows = stmt.executeUpdate();
                if (rows > 0) {
                    message = "Event added successfully.";
                } else {
                    message = "Failed to add the event.";
                }
            } catch (Exception e) {
                e.printStackTrace();
                message = "An error occurred: " + e.getMessage();
            } finally {
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
        }
    %>

    <h1 style="color: #e67760;">Manage Event</h1>
    <form action="manage_event.jsp" method="post" style="max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e67760; border-radius: 10px;">
        <!-- Add fields for event details -->
        <div style="margin-bottom: 15px;">
            <label for="title" style="color: #e67760; display: block; margin-bottom: 5px;">Title:</label>
            <input type="text" name="title" id="title" style="width: 100%; padding: 10px; border: 1px solid #e67760; border-radius: 5px;">
        </div>

        

        <div style="margin-bottom: 15px;">
            <label for="schedule" style="color: #e67760; display: block; margin-bottom: 5px;">Schedule:</label>
            <input type="datetime-local" name="schedule" id="schedule" style="width: 100%; padding: 10px; border: 1px solid #e67760; border-radius: 5px;">
        </div>
        
        <div style="margin-bottom: 15px;">
            <label for="content" style="color: #e67760; display: block; margin-bottom: 5px;">Content:</label>
            <input type="text" name="content" id="content" style="width: 100%; padding: 10px; border: 1px solid #e67760; border-radius: 5px;">
        </div>

        <div style="margin-bottom: 15px;">
            <label for="banner" style="color: #e67760; display: block; margin-bottom: 5px;">Banner URL:</label>
            <input type="text" name="banner" id="banner" style="width: 100%; padding: 10px; border: 1px solid #e67760; border-radius: 5px;">
        </div>

        <div style="margin-bottom: 15px;">
            <label for="date_created" style="color: #e67760; display: block; margin-bottom: 5px;">Date Created:</label>
            <input type="datetime-local" name="date_created" id="date_created" style="width: 100%; padding: 10px; border: 1px solid #e67760; border-radius: 5px;">
        </div>

        <div>
            <button type="submit" style="background-color: #e67760; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer;">Save</button>
            <button type="button" onclick="window.location.href='events.jsp'" style="background-color: #fff; color: #e67760; border: 1px solid #e67760; padding: 10px 20px; border-radius: 5px; cursor: pointer; margin-left: 10px;">Cancel</button>
        </div>
    </form>
    
    <% if (message != null) { %>
        <p style="color: #e67760;"><%= message %></p>
    <% } %>
</main>
		<!-- MAIN -->
	</section>
	<!-- CONTENT -->
	

	<script src="script.js"></script>
</body>
</html>
