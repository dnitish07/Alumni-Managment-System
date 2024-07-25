<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>Events</title>
<style>
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
</head>
<body>
<section id="sidebar">
    <a href="index.jsp" class="brand">
        <img src="logo.png" style="height: 80px; width: 100px; margin: 10px; margin-top: 50px;">
        <span class="text" style="padding: 5px; margin-top: 40px; font-size: 40px;">Admin</span>
    </a>
    <ul class="side-menu top">
        <li>
            <a href="index.jsp">
                <i class='bx bxs-dashboard'></i>
                <span class="text">Home</span>
            </a>
        </li>
        <li>
            <a href="gallery.jsp">
                <i class='bx bxs-shopping-bag-alt'></i>
                <span class="text">Gallery</span>
            </a>
        </li>
        <li>
            <a href="course.jsp">
                <i class='bx bxs-doughnut-chart'></i>
                <span class="text">Course List</span>
            </a>
        </li>
        <li>
            <a href="alumni_list.jsp">
                <i class='bx bxs-message-dots'></i>
                <span class="text">Alumni list</span>
            </a>
        </li>
        <li>
            <a href="jobs.jsp">
                <i class='bx bxs-group'></i>
                <span class="text">Jobs</span>
            </a>
        </li>
        
        <li class="active">
            <a href="events.jsp">
                <i class='bx bxs-group'></i>
                <span class="text">Events</span>
            </a>
        </li>
    </ul>
    <ul class="side-menu">
        <li>
            <a href="settings.jsp">
                <i class='bx bxs-cog'></i>
                <span class="text">Settings</span>
            </a>
        </li>
        <li>
            <a href="admin.html" class="logout">
                <i class='bx bxs-log-out-circle'></i>
                <span class="text">Logout</span>
            </a>
        </li>
    </ul>
</section>
<section id="content">
    <nav>
        <i class='bx bx-menu'></i>
        <a href="adminhome.jsp" class="nav-link">Welcome Admin</a>
        <form action="#">
            <div class="form-input">
                <input type="search" placeholder="Search...">
                <button type="submit" class="search-btn"><i class='bx bx-search'></i></button>
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
                                <b>List of Events</b>
                                <span class="float:right">
                                    <a class="btn btn-primary btn-block btn-sm col-sm-2 float-right" href="manage_event.jsp" id="new_event">
                                        <i class="fa fa-plus"></i> New Entry
                                    </a>
                                </span>
                            </div>
                            <div class="card-body">
                                <table id="eventTable" class="table table-condensed table-bordered table-hover">
                                    <colgroup>
                                        <col width="5%">
                                        <col width="20%">
                                        <col width="15%">
                                        <col width="30%">
                                        <col width="15%">
                                        <col width="15%">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th class="text-center">#</th>
                                            <th class="">Schedule</th>
                                            <th class="">Title</th>
                                            <th class="">Description</th>
                                            <th class="">Committed To Participate</th>
                                            <th class="text-center">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%@ page import="java.sql.*" %>
                                        <% 
                                        int i = 1;
                                        Connection conn = null;
                                        PreparedStatement stmt = null;
                                        ResultSet rs = null;
                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_db","root","");
                                            
                                            stmt = conn.prepareStatement("SELECT * FROM events ORDER BY schedule DESC");
                                            rs = stmt.executeQuery();
                                            while(rs.next()) {
                                                int eventId = rs.getInt("id");
                                                Timestamp schedule = rs.getTimestamp("schedule");
                                                String title = rs.getString("title");
                                                String description = rs.getString("content");
                                                
                                                // Count commits for the event
                                                int commits = 0;
                                                PreparedStatement commitStmt = conn.prepareStatement("SELECT COUNT(*) AS commit_count FROM event_commits WHERE event_id = ?");
                                                commitStmt.setInt(1, eventId);
                                                ResultSet commitRs = commitStmt.executeQuery();
                                                if (commitRs.next()) {
                                                    commits = commitRs.getInt("commit_count");
                                                }
                                                commitRs.close();
                                                commitStmt.close();
                                        %>
                                        <tr>
                                            <td class="text-center"><%= i++ %></td>
                                            <td><%= new java.text.SimpleDateFormat("MMM dd, yyyy hh:mm a").format(schedule) %></td>
                                            <td><%= title %></td>
                                            <td><%= description %></td>
                                            <td class="text-right"><%= commits %></td>
                                            <td class="text-center">
                                            <form action="ViewEvents" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                                <button class="btn btn-sm btn-outline-danger" type="submit">View</button>
                                            </form>
                                            <form action="EditEvents" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                                <button class="btn btn-sm btn-outline-danger" type="submit">Edit</button>
                                            </form>
                                            <form action="DeleteEvent" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                                <button class="btn btn-sm btn-outline-danger" type="submit">Delete</button>
                                            </form>	                                            </td>
                                        </tr>
                                        <% 
                                            }
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        } finally {
                                            if (rs != null) {
                                                try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                                            }
                                            if (stmt != null) {
                                                try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                                            }
                                            if (conn != null) {
                                                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
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
<script>
    $(document).ready(function() {
        $('#eventTable').dataTable();
    });

    $('.view_event').click(function() {
        window.open("../index.jsp?page=view_event&id=" + $(this).attr('data-id'));
    });

    $('.edit_event').click(function() {
        location.href = "index.jsp?page=manage_event&id=" + $(this).attr('data-id');
    });

    $('.delete_event').click(function() {
        var eventId = $(this).attr('data-id');
        if (confirm("Are you sure to delete this event?")) {
            deleteEvent(eventId);
        }
    });

    function delete_event($id){
        start_load();
        $.ajax({
            url: 'ajax.jsp',
            method: 'POST',
            data: { action: 'delete_event', id: $id },
            success: function(resp) {
                console.log("Response from AJAX:", resp);
                if (resp == 1) {
                    alert_toast("Event successfully deleted", 'success');
                    setTimeout(function(){
                        location.reload(); // Reload the page to update the event list
                    }, 1500);
                } else {
                    alert_toast("Failed to delete event. Please try again later.", 'error');
                }
            },
            error: function(xhr, status, error) {
                console.error("AJAX Error:", error);
                alert_toast("An error occurred while deleting event. Please try again later.", 'error');
            }
        });
    }

</script>
</body>
</html>