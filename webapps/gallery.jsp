<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <i class='bx bxs-log-out-circle'></i>
    <span>Logout</span>
</a></li></ul>
</section>
<section id="content">
		<!-- NAVBAR -->
		<nav>
			<i class='bx bx-menu' ></i>
			<a href="index.jsp" class="nav-link">Welcome Admin</a>
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
                <form action="Gallery" id="manage-gallery" method="post" enctype="multipart/form-data">
                    <div class="card" style="border: 1px solid #e67760;">
                        <div class="card-header" style="background-color: #e67760; color: white;">
                            Upload
                        </div>
                        <div class="card-body">
                            <input type="hidden" name="id">
                            <div class="form-group">
                                <label for="" class="control-label" style="color: #e67760;">Image</label>
                                <input type="file" class="form-control" name="img" onchange="displayImg(this, $(this))" style="border: 1px solid #e67760;">
                            </div>
                            <div class="form-group">
                                <img src="" alt="" id="cimg" width="100%">
                            </div>
                            <div class="form-group">
                                <label class="control-label" style="color: #e67760;">Short Description</label>
                                <textarea class="form-control" name="about" style="border: 1px solid #e67760;"></textarea>
                            </div>
                        </div>
                        <div class="card-footer">
                            <div class="row">
                                <div class="col-md-12">
                                    <button class="btn btn-sm" style="background-color: #e67760; color: white;" type="submit">Save</button>
                                    <button class="btn btn-sm btn-default" style="background-color: #ccc; color: #333;" type="button" onclick="window.location.href='gallery.jsp'">Cancel</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <!-- FORM Panel -->

            <!-- Table Panel -->
            <div class="col-md-8">
                <div class="card" style="border: 1px solid #e67760;">
                    <div class="card-header" style="background-color: #e67760; color: white;">
                        <b>Gallery List</b>
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th class="text-center" style="color: #e67760;">#</th>
                                    <th class="text-center" style="color: #e67760;">IMG</th>
                                    <th class="text-center" style="color: #e67760;">Gallery</th>
                                    <th class="text-center" style="color: #e67760;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                try {
                                    int i = 1;
                                    ResultSet gallery = stmt.executeQuery("SELECT * FROM photo ORDER BY id ASC");

                                    while (gallery.next()) {
                                        String imagePath = gallery.getString("image");
                                        String description = gallery.getString("about");
                                %>
                                <tr>
                                    <td class="text-center"><%= i++ %></td>
                                    <td class="">
                                        <img src="assets/uploads/<%= gallery.getString("image") %>" class="gimg" alt="<%=  description %>">
                                    </td>
                                    <td class="">
                                        <%= gallery.getString("about") %>
                                    </td>
                                    <td class="text-center">
                                        <form action="EditPhoto" method="post" style="display:inline;">
                                            <input type="hidden" name="id" value="<%= gallery.getInt("id") %>">
                                            <button class="btn btn-sm" style="background-color: #e67760; color: white;" type="submit">Edit</button>
                                        </form>
                                        <form action="DeletePhoto" method="post" style="display:inline;">
                                            <input type="hidden" name="id" value="<%= gallery.getInt("id") %>">
                                            <button class="btn btn-sm" style="background-color: #e67760; color: white;" type="submit">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                                <% 
                                    }
                                } catch(Exception e) {
                                    e.printStackTrace();
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
    <script>
    
    function displayImg(input) {
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