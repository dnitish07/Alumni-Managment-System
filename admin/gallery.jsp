<%@ page import="java.io.IOException" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="jakarta.servlet.ServletException"%>
<%@ page import="jakarta.servlet.http.HttpServlet"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>
<%@ page import="jakarta.servlet.http.HttpServletResponse"%>
<%@ page import="java.io.File, java.util.ArrayList, java.util.Arrays, java.util.List" %>
<%@ page import="java.sql.Connection, java.sql.ResultSet, java.sql.Statement" %>
<%@ page import="java.io.File, java.io.FileReader, java.io.FileWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<%@ page import="java.util.HashMap, java.util.Map" %>

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

    } catch (ClassNotFoundException e) {
        out.println("Driver not found: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html>
<style>
	
	td{
		vertical-align: middle !important;
	}
	img#cimg{
		max-height: 23vh;
		max-width: calc(100%);
	}
	.gimg{
		max-height: 15vh;
		max-width: 10vw;
	}

</style>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="styles.css">
    <title>Gallery page</title>
    <style>
        td{
            vertical-align: middle!important;
        }
        img#cimg{
            max-height: 23vh;
            max-width: calc(100%);
        }
       .gimg{
            max-height: 15vh;
            max-width: 10vw;
        }
       .card-body {
            flex: 1 1 auto;
            min-height: 1px;
            padding: 0.25rem;
        }
       .container-fluid{
            padding-top: 70px;
            padding-left: 300px;
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
    <i class='bx bxs-log-out-circle'></i>
    <span>Logout</span>
</a></li></ul>
</section>
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
</section>
<div class="container-fluid">
        <div class="col-lg-12">
            <div class="row">
                <!-- FORM Panel -->
                <div class="col-md-4">
                    <form action="ajax.jsp?action=save_gallery" id="manage-gallery" method="post" enctype="multipart/form-data">
                        <div class="card">
                            <div class="card-header">
                                Upload
                            </div>
                            <div class="card-body">
                                <input type="hidden" name="id">
                                <div class="form-group">
                                    <label for="" class="control-label">Image</label>
                                    <input type="file" class="form-control" name="img" onchange="displayImg(this, $(this))">
                                </div>
                                <div class="form-group">
                                    <img src="" alt="" id="cimg">
                                </div>
                                <div class="form-group">
                                    <label class="control-label">Short Description</label>
                                    <textarea class="form-control" name='about'></textarea>
                                </div>
                            </div>
                            <div class="card-footer">
                                <div class="row">
                                    <div class="col-md-12">
                                        <button class="btn btn-sm btn-primary col-sm-3 offset-md-3"> Save</button>
                                        <button class="btn btn-sm btn-default col-sm-3" type="button" onclick="$('#manage-gallery').get(0).reset()"> Cancel</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <!-- FORM Panel -->

                <!-- Table Panel -->
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header">
                            <b>Gallery List</b>
                        </div>
                        <div class="card-body">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th class="text-center">#</th>
                                        <th class="text-center">IMG</th>
                                        <th class="text-center">Gallery</th>
                                        <th class="text-center">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        int i = 1;
                                        Map<Integer, String> img = new HashMap<>();
                                        String fpath = application.getRealPath("assets/uploads/gallery");
                                        File folder = new File(fpath);
                                        File[] listOfFiles = folder.listFiles();

                                        if (listOfFiles != null) {
                                            for (File file : listOfFiles) {
                                                if (file.isFile()) {
                                                    String fileName = file.getName();
                                                    String[] n = fileName.split("_");
                                                    img.put(Integer.parseInt(n[0]), fileName);
                                                }
                                            }
                                        }

                                        
                                        ResultSet gallery = stmt.executeQuery("SELECT * FROM gallery ORDER BY id ASC");

                                        while (gallery.next()) {
                                    %>
                                    <tr>
                                        <td class="text-center"><%= i++ %></td>
                                        <td class="">
                                            <img src="assets/uploads/gallery/<%= img.get(gallery.getInt("id")) %>" class="gimg" alt="">
                                        </td>
                                        <td class="">
                                            <%= gallery.getString("about") %>
                                        </td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-primary edit_gallery" type="button" data-id="<%= gallery.getInt("id") %>" data-about="<%= gallery.getString("about") %>" data-src="assets/uploads/gallery/<%= img.get(gallery.getInt("id")) %>">Edit</button>
                                            <button class="btn btn-sm btn-danger delete_gallery" type="button" data-id="<%= gallery.getInt("id") %>">Delete</button>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                        con.close();
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

    <script>
        function displayImg(input, _this) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#cimg').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        $('#manage-gallery').submit(function (e) {
            e.preventDefault();
            start_load();
            $.ajax({
                url: 'ajax.jsp?action=save_gallery',
                data: new FormData($(this)[0]),
                cache: false,
                contentType: false,
                processData: false,
                method: 'POST',
                type: 'POST',
                success: function (resp) {
                    if (resp == 1) {
                        alert_toast("Data successfully added", 'success');
                        setTimeout(function () {
                            location.reload();
                        }, 1500);
                    } else if (resp == 2) {
                        alert_toast("Data successfully updated", 'success');
                        setTimeout(function () {
                            location.reload();
                        }, 1500);
                    }
                }
            })
        });

        $('.edit_gallery').click(function () {
            start_load();
            var cat = $('#manage-gallery');
            cat.get(0).reset();
            cat.find("[name='id']").val($(this).attr('data-id'));
            cat.find("[name='about']").val($(this).attr('data-about'));
            cat.find("img").attr('src', $(this).attr('data-src'));
            end_load();
        });

        $('.delete_gallery').click(function () {
            _conf("Are you sure to delete this data?", "delete_gallery", [$(this).attr('data-id')]);
        });

        function delete_gallery(id) {
            start_load();
            $.ajax({
                url: 'ajax.jsp?action=delete_gallery',
                method: 'POST',
                data: { id: id },
                success: function (resp) {
                    if (resp == 1) {
                        alert_toast("Data successfully deleted", 'success');
                        setTimeout(function () {
                            location.reload();
                        }, 1500);
                    }
                }
            })
        }

        $('table').dataTable();
    </script>
</body>
</html>