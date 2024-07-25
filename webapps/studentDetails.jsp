<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alumni Profile Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 80%;
            max-width: 900px;
            padding: 20px;
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
        }
        .header h1 {
            color: #e67760;
        }
        .profile {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .profile .profile-card, .profile .info-card {
            flex: 1;
            min-width: 250px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .profile .profile-card {
            text-align: center;
        }
        .profile .profile-card img {
            border-radius: 50%;
            width: 150px;
            height: 150px;
        }
        .profile .profile-card h2 {
            margin: 10px 0;
            color: #e67760;
        }
        .profile .profile-card p {
            margin: 5px 0;
            color: #333;
        }
        .info-card h3 {
            color: #e67760;
            margin-bottom: 10px;
        }
        .info-card table {
            width: 100%;
            border-collapse: collapse;
        }
        .info-card table th, .info-card table td {
            text-align: left;
            padding: 8px;
            border-bottom: 1px solid #ddd;
        }
        .info-card table th {
            color: #e67760;
        }
        .info-card p {
            margin: 10px 0;
            color: #333;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="header">
            <h1>Alumni Detailed Information</h1>
            <p>A student profile.</p>
        </div>
        <div class="profile">
    <div class="profile-card">
                
                
               
                
        <%
            String regdno = request.getParameter("regdno");
            Connection con = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // Updated driver class
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_db", "root", "");
                String query = "SELECT * FROM alumnus_bio WHERE regdno= ?";
                pstmt = con.prepareStatement(query);
                pstmt.setString(1, regdno);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    String fullname = rs.getString("fullname");
                    String phonenumber = rs.getString("phonenumber");
                    String email = rs.getString("email");
                    String photo = rs.getString("picture");
                    String batch = rs.getString("batch");
                    String course = rs.getString("course");
                    String gender = rs.getString("gender");
                    String bloodgroup = rs.getString("bloodgroup");
                    String aboutyou = rs.getString("aboutyou");
                    String dob = rs.getString("dob");
                    String address = rs.getString("address");

                    // Display detailed information about the alumni
        %>
                    <img src="assets/uploads/<%= photo %>" alt="Profile Picture">
                    <h2><%= fullname %></h2>
                    
                    
                    <p>Course: <%= course %></p>
                    <p>Student ID: <%= regdno %></p>
                     <p>Email ID: <%= email %></p>
                    <p>Batch: <%= batch %></p>
                   
                    
                    
        
    </div>
    <div class="info-card">
                <h3>General Information</h3>
                <table>
                    <tr>
                        <th>Phone Number</th>
                        <td><%= phonenumber %></td>
                    </tr>
                    <tr>
                        <th> Address</th>
                        <td><%= address %></td>
                    </tr>
                    <tr>
                        <th>Date of Birth</th>
                        <td><%= dob %></td>
                    </tr>
                    <tr>
                        <th>Gender</th>
                        <td><%= gender %></td>
                    </tr>
                    
                    <tr>
                        <th>Blood</th>
                        <td><%= bloodgroup %></td>
                    </tr>
                </table>
            </div>
            <div class="info-card" style="flex-basis: 100%;">
                <h3>Other Information</h3>
                <p><%= aboutyou %></p>
            </div>
        </div>
        <%
                } else {
                    out.println("<p>No details found for the selected student.</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (con != null) con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>
</body>
</html>

