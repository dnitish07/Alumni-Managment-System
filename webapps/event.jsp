<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alumni Events</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: white;
        }
        header {
            background-color: #e67760;
            color: white;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        header .logo {
            font-size: 24px;
            font-weight: bold;
        }
        header nav ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
            gap: 20px;
        }
        header nav ul li {
            display: inline;
        }
        header nav ul li a {
            color: white;
            text-decoration: none;
        }
        main {
            padding: 20px;
        }
        .upcoming-events {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .upcoming-events h2 {
            margin-top: 0;
            color: #e67760;
        }
        .events {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .event {
            background-color: #f8f8f8;
            padding: 10px;
            border-radius: 8px;
            width: 300px;
            border: 1px solid #e67760;
        }
        .event h3 {
            margin: 0;
            color: #e67760;
        }
        .event p {
            margin: 5px 0 0;
        }
    </style>
</head>
<body>
    
    <main>
        <section class="upcoming-events">
            <h2>Upcoming Events</h2>
            <div class="events">
                <%
                    Connection con = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    try {
                    	Class.forName("com.mysql.jdbc.Driver");

                        // Establish Connection
                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_db", "root", "");

                        // Create Statement
                        stmt = con.createStatement();
                        String sql = "SELECT title, content, schedule, banner, date_created FROM events";
                        rs = stmt.executeQuery(sql);
                        while(rs.next()) {
                            String title = rs.getString("title");
                            String content = rs.getString("content");
                            String schedule = rs.getString("schedule");
                            String banner = rs.getString("banner");
                            String dateCreated = rs.getString("date_created");
                %>
                <div class="event">
                    <img src="assets/uploads/<%= banner %>" alt="<%= title %>" style="width:100%; border-radius: 8px 8px 0 0;">
                    <div>
                        <h3><%= title %></h3>
                        <p><%= content %></p>
                        <p><strong>Schedule:</strong> <%= schedule %></p>
                        <p><strong>Date Created:</strong> <%= dateCreated %></p>
                    </div>
                </div>
                <%
                        }
                    } catch(Exception e) {
                        e.printStackTrace();
                    } finally {
                        try { if(rs != null) rs.close(); } catch(Exception e) { e.printStackTrace(); }
                        try { if(stmt != null) stmt.close(); } catch(Exception e) { e.printStackTrace(); }
                        try { if(con != null) con.close(); } catch(Exception e) { e.printStackTrace(); }
                    }
                %>
            </div>
        </section>
    </main>
</body>
</html>
