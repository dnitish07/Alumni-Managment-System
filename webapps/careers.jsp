<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.ServletException"%>
<%@ page import="jakarta.servlet.http.HttpServlet"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>
<%@ page import="jakarta.servlet.http.HttpServletResponse"%>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Career Portal</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 0;
        }
        .container {
            display: flex;
            flex-wrap: wrap;
            margin: 20px;
        }
        .sidebar {
            flex: 1;
            max-width: 200px;
            background-color: white;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-right: 20px;
        }
        .content {
            flex: 3;
            padding: 20px;
        }
        .job-card {
            background-color: white;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .job-card h3 {
            margin-top: 0;
            color: #e67760;
        }
        .job-card p {
            margin: 5px 0;
        }
        .filter h4 {
            color: #e67760;
            margin-top: 0;
        }
        .filter-item {
            margin: 10px 0;
        }
        .location, .type, .date {
            font-size: 0.9em;
            color: gray;
        }
        .search {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #e67760;
            padding: 10px 20px;
            color: white;
        }
        .header h1 {
            margin: 0;
        }
        .header .btn-opportunities {
            background-color: white;
            color: #e67760;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
        }
        .header .btn-opportunities:hover {
            background-color: #f8f8f8;
        }
    </style>
</head>
<body>
 <header class="header">
        <h1>Job Opportunities</h1>
        <a href="opportunities.jsp" class="btn-opportunities">Add Job Opportunities</a>
    </header>
    <div class="container">
        <aside class="sidebar">
            <input type="text" class="search" placeholder="Keyword Search">
            <div class="filter">
                <h4>Filter by Category</h4>
                <div class="filter-item">IT (7)</div>
                <div class="filter-item">.NET Architect/Developer (6)</div>
                <div class="filter-item">Construction (7)</div>
                <div class="filter-item">Healthcare (7)</div>
                <div class="filter-item">Software Developer (4)</div>
                <div class="filter-item">Communication (6)</div>
                <div class="filter-item">Business Services (11)</div>
                <div class="filter-item">Commercial Law (5)</div>
                <div class="filter-item">Registered Nurse (4)</div>
                <div class="filter-item">Senior .Net Developer (4)</div>
                <div class="filter-item">Finance (66)</div>
                <div class="filter-item">Air Conditioning (4)</div>
            </div>
            
            <div class="filter">
                <h4>Filter by City</h4>
                <div class="filter-item">Andhra Pradesh (60)</div>
                <div class="filter-item">Telengana (26)</div>
                <div class="filter-item">Karnataka (23)</div>
                <div class="filter-item">Chennai (20)</div>
                <div class="filter-item">Kerala (11)</div>
                <div class="filter-item">Delhi (11)</div>
                <div class="filter-item">Kolkata (10)</div>
                <div class="filter-item">Gujarat (8)</div>
                <div class="filter-item">Arunachal Pradesh (8)</div>
                <div class="filter-item">Sikkim (8)</div>
                <div class="filter-item">Jammu & Kashmir (8)</div>
                <div class="filter-item">Jarkhand (8)</div>
            </div>
        </aside>
        <main class="content">
            <%
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                // Load JDBC Driver
                Class.forName("com.mysql.jdbc.Driver");

                // Establish Connection
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_db", "root", "");

                // Create Statement
                stmt = con.createStatement();

                // Execute Query
                String query = "SELECT company, location, job_title, description, date_created, apply_link FROM careers";
                rs = stmt.executeQuery(query);
                
                while (rs.next()) {
            %>
            <div class="job-card">
                <h3><%= rs.getString("company") %></h3>
                <h4><%= rs.getString("job_title") %></h4>
                <p><%= rs.getString("description") %></p>
                <p class="location">Location: <%= rs.getString("location") %></p>
                <p class="date">Posted on: <%= rs.getDate("date_created") %></p>
                <a href="<%= rs.getString("apply_link") %>" class="apply-link">Apply Now</a>
            </div>
            <%
                }
            } catch (ClassNotFoundException e) {
                out.println("Driver not found: " + e.getMessage());
            } catch (SQLException e) {
                out.println("SQL Exception: " + e.getMessage());
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                if (con != null) try { con.close(); } catch (SQLException ignore) {}
            }
            %>
        </main>
    </div>
</body>
</html>
