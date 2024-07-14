<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 
  This JSP assumes your database connection logic resides in a separate class (e.g., DbConnection.java).
  Update the import statement and connection logic accordingly.
 --%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.ServletException"%>
<%@ page import="jakarta.servlet.http.HttpServlet"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>
<%@ page import="jakarta.servlet.http.HttpServletResponse"%>


<%
  session = request.getSession();
  if (session.getAttribute("login_id") != null) {
    response.sendRedirect("index.jsp?page=home");
    return;
  }

  Connection con = null;
  ResultSet rs = null;
  ResultSet rm = null;
  String message = null;


     try {
        // Load JDBC Driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish Connection
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_db", "root", "");
    String query = "SELECT * FROM system_settings limit 1";
    PreparedStatement stmt = con.prepareStatement(query);
    rs = stmt.executeQuery();

    if (rs.next()) {
      pageContext.setAttribute("systemName", rs.getString("name"));
    }
  } catch (Exception e) {
    e.printStackTrace();
    //message = "An error occurred. Please try again later.";
  } finally {
    if (con != null) {
      try {
        con.close();
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title><%= (String) pageContext.getAttribute("systemName") %></title>

  <style>
    /* Add your custom styles here */
  </style>
</head>

<body>


  <main id="main" class=" bg-dark">
    <div id="login-left">
    </div>

    <div id="login-right">
      <div class="card col-md-8">
        <div class="card-body">

          <form id="login-form">
            <% if (message != null) { %>
              <div class="alert alert-danger"><%= message %></div>
            <% } %>
            <div class="form-group">
              <label for="username" class="control-label">Username</label>
              <input type="text" id="username" name="username" class="form-control">
            </div>
            <div class="form-group">
              <label for="password" class="control-label">Password</label>
              <input type="password" id="password" name="password" class="form-control">
            </div>
            <center><button class="btn-sm btn-block btn-wave col-md-4 btn-primary">Login</button></center>
          </form>
        </div>
      </div>
    </div>


  </main>

  <a href="#" class="back-to-top"><i class="icofont-simple-up"></i></a>
<script>
$('#login-form').submit(function(e) {
	  e.preventDefault();
	  $('#login-form button[type="button"]').attr('disabled', true).html('Logging in...');
	  $(this).find('.alert-danger').remove();

	  $.ajax({
	    url: 'LoginServlet', // Assuming LoginServlet is mapped to this URL
	    method: 'POST',
	    data: $(this).serialize(),
	    error: function(err) {
	      console.log(err);
	      $('#login-form button[type="button"]').removeAttr('disabled').html('Login');
	      $('#login-form').prepend('<div class="alert alert-danger">An error occurred. Please try again later.</div>');
	    },
	    success: function(resp) {
	      if (resp == 1) {
	        location.href = 'index.jsp?page=home';
	      } else {
	        $('#login-form').prepend('<div class="alert alert-danger">Username or password is incorrect.</div>');
	        $('#login-form button[type="button"]').removeAttr('disabled').html('Login');
	      }
	    }
	  })
	})
</script>
</body>
</html>