<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Form</title>
    <style>
        /* Your CSS styles */
        body {
            font-family: Arial, Helvetica, sans-serif;
            background-color: #E6E6FA;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            margin-top: 30px;
        }

        form {
            max-width: 300px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 10px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 7px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        input[type="radio"] {
            margin-bottom: 10px;
        }

        input[type="submit"] {
            width: 100%;
            background-color: #4CAF50;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .footer {
            text-align: center;
            margin-top: 20px;
        }

        .footer p {
            font-size: 14px;
        }

        .footer a {
            text-decoration: none;
            color: #4CAF50;
            font-weight: bold;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
    <h2>Login</h2>
    <form id="loginForm" action="login.jsp" method="post" target="_top">
        <label for="username">Username:</label>
        <input type="text" id="fullname" name="fullname" required>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>

        <label for="usertype">User Type:</label>
        <input type="radio" id="student" name="usertype" value="student"> Alumni
        <input type="radio" id="admin" name="usertype" value="admin"> Admin<br><br>

        <input type="submit" value="Login">
    </form>

    <!-- Footer with registration link -->
    <div class="footer">
        <p id="foot">If not registered, <a href="registration.html">click here</a> to register.</p>
    </div>

    <%-- Java code to handle login process --%>
    <%@ page import="java.sql.*" %>
    <%@ page import="jakarta.servlet.http.HttpSession" %>
    <%
        // Get the form data
        String fullname = request.getParameter("fullname");
        String password = request.getParameter("password");
        String usertype = request.getParameter("usertype");

        // Database connection parameters
        String jdbcUrl = "jdbc:mysql://localhost:3306/alumni_db";
        String dbUser = "root";
        String dbPassword = "";

        if (fullname != null && password != null) {
            try {
                // Load the MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish a database connection
                Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                // Check if the username exists in the registration data
                String checkUserSql = "SELECT * FROM alumnus_bio WHERE fullname = ?";
                PreparedStatement checkUserStmt = conn.prepareStatement(checkUserSql);
                checkUserStmt.setString(1, fullname);
                ResultSet userResultSet = checkUserStmt.executeQuery();

                if (userResultSet.next()) {
                    // User is registered, proceed with login authentication
                    // Check if the username and password match in the database
                    String loginSql = "SELECT * FROM alumnus_bio WHERE fullname = ? AND password = ?";
                    PreparedStatement loginStmt = conn.prepareStatement(loginSql);
                    loginStmt.setString(1, fullname);
                    loginStmt.setString(2, password);
                    ResultSet loginResultSet = loginStmt.executeQuery();

                    if (loginResultSet.next()) {
                        HttpSession session1 = request.getSession();
                        session1.setAttribute("fullname", fullname);
                        session1.setAttribute("usertype", usertype);

                        // Redirect based on user type
                        if ("student".equals(usertype)) {
                            response.sendRedirect("Home");
                        } else if ("admin".equals(usertype)) {
                            response.sendRedirect("index.jsp");
                        }
                    } else {
                        // Login failed
                        // Display error message and refresh form
                        out.println("<p class='error-message'>Invalid password. Please try again.</p>");
                        out.println("<script>document.getElementById('password').value = '';</script>");
                    }

                    // Close database resources for login check
                    loginResultSet.close();
                    loginStmt.close();
                } else {
                    // Username entered but not found in the database
                    // Display error message and refresh form
                    out.println("<p class='error-message'>User does not exist. Please try again.</p>");
                    out.println("<script>document.getElementById('username').value = '';</script>");
                }

                // Close database resources for user check
                userResultSet.close();
                checkUserStmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                // Display error message on error
                out.println("<p class='error-message'>An error occurred while processing your request. Please try again later.</p>");
            }
        }
    %>
</body>
</html>
