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

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="styles.css">
<title>Alumni List</title>
<style>
	
	td{
		vertical-align: middle !important;
	}
	td p{
		margin: unset
	}
	img{
		max-width:100px;
		max-height: :150px;
	}
	.avatar {
	    display: flex;
	    border-radius: 100%;
	    width: 100px;
	    height: 100px;
	    align-items: center;
	    justify-content: center;
	    border: 3px solid;
	    padding: 5px;
	}
	.avatar img {
	    max-width: calc(100%);
	    max-height: calc(100%);
	    border-radius: 100%;
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
					<i class='bx bxs-log-out-circle' ></i>
					<span class="text">Logout</span>
				</a>
			</li>
		</ul>
	</section>
	
<%@page import="java.sql.*, java.util.*" %>
<%@page import="jakarta.servlet.*, jakarta.servlet.http.*, jakarta.servlet.annotation.*" %>

<%! 
    // Method to capitalize the first letter of each word
    public String ucwords(String str) {
        if (str == null || str.isEmpty()) {
            return str;
        }
        String[] words = str.split("\\s+");
        StringBuilder capitalized = new StringBuilder();
        for (String word : words) {
            if (word.length() > 0) {
                capitalized.append(Character.toUpperCase(word.charAt(0))).append(word.substring(1).toLowerCase()).append(" ");
            }
        }
        return capitalized.toString().trim();
    }
%>
<section id="content">
    <nav>
        <i class='bx bx-menu'></i>
        <a href="index.jsp" class="nav-link">Welcome Admin</a>
        <form action="#">
            <div class="form-input">
                <input type="search" placeholder="Search...">
                <button type="submit" class="search-btn"><i class='bx bx-search'></i></button>
            </div>
        </form>
        <input type="checkbox" id="switch-mode" hidden>
        <label for="switch-mode" class="switch-mode"></label>
        <a href="#" class="profile">
            <img src="people.png" alt="Profile Image">
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
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header" style="background-color: #e67760; color: white;">
                            <b>List of Alumni</b>
                        </div>
                        <div class="card-body">
                            <table id="alumni_table" class="table table-condensed table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th class="text-center">#</th>
                                        <th class="text-center">Avatar</th>
                                        <th class="text-center">REGD NO</th>
                                        <th class="text-center">Name</th>
                                        <th class="text-center">Course Graduated</th>
                                        <th class="text-center">Status</th>
                                        <th class="text-center">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        int i = 1;
                                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_db", "root", "");
                                        Statement stmt = conn.createStatement();
                                        String query = "SELECT * FROM `alumnus_bio` ORDER by id ASC";
                                        ResultSet alumni = stmt.executeQuery(query);

                                        while (alumni.next()) {
                                    %>
                                    <tr>
                                        <td class="text-center"><%= i++ %></td>
                                        <td class="text-center">
                                            <div class="avatar">
                                                <img src="assets/uploads/<%= alumni.getString("picture") %>" style="width: 50px; height: 50px; border-radius: 50%;" alt="<%= ucwords(alumni.getString("fullname")) %>">
                                            </div>
                                        </td>
                                        <td class="">
                                            <p><b><%= ucwords(alumni.getString("regdno")) %></b></p>
                                        </td>
                                        <td class="">
                                            <p><b><%= ucwords(alumni.getString("fullname")) %></b></p>
                                        </td>
                                        <td class="">
                                            <p><b><%= alumni.getString("course") %></b></p>
                                        </td>
                                        <td class="text-center">
                                            <span class="badge badge-primary" style="background-color: #e67760;">Verified</span>
                                        </td>
                                        <td class="text-center">
                                            <form action="ViewAlumni" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="<%= alumni.getInt("id") %>">
                                                <button class="btn btn-sm btn-outline-danger" type="submit" style="border-color: #e67760; color: #e67760;">View</button>
                                            </form> 
                                            <form action="EditAlumni" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="<%= alumni.getInt("id") %>">
                                                <button class="btn btn-sm btn-outline-warning" type="submit" style="border-color: #e67760; color: #e67760;">Edit</button>
                                            </form>                                           
                                            <form action="DeleteAlumni" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="<%= alumni.getInt("id") %>">
                                                <button class="btn btn-sm btn-outline-danger" type="submit" style="border-color: #e67760; color: #e67760;">Delete</button>
                                            </form>
                                        </td>
                                    </tr>
                                    <% 
                                        }
                                        conn.close();
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </main>
</section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
<script src="script.js"></script>

<script>
    $(document).ready(function(){
        $('#alumni_table').DataTable();
    });

    $('.view_alumni').click(function(){
        uni_modal("Bio", "view_alumni.jsp?id=" + $(this).attr('data-id'), 'mid-large');
    });

    $('.delete_alumni').click(function(){
        _conf("Are you sure to delete this alumni?", "delete_alumni", [$(this).attr('data-id')]);
    });

   /* function delete_alumni(id){
        start_load();
        $.ajax({
            url: 'ajax.jsp?action=delete_alumni',
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
    }*/
</script>
<script>
    document.querySelectorAll('.delete_alumni').forEach(button => {
        button.addEventListener('click', function() {
            const id = this.getAttribute('data-id');
            if (confirm('Are you sure you want to delete this record?')) {
                fetch('DeleteAlumni', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 'id=' + id
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('Record deleted successfully.');
                        location.reload();
                    } else {
                        alert('Failed to delete record.');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred. Please try again.');
                });
            }
        });
    });
</script>

</body>
</html>