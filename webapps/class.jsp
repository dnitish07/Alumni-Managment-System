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
<html>
<head>
<style>
body {
  font-family: 'Open Sans', sans-serif;
  background-color: #f9f9f9;
}
.head{
padding-top:200px;
}
 #header {
            position:fixed; 
            top:0; 
            left:0; 
            right:0; 
            background-color: white; 
            color: #fff; 
            padding: 10px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            z-index:100;
       }
       #header h1 {
            color: grey; 
            margin: 0px; 
            font-size: 30px; 
            position: fixed; 
            top: 35px; 
            left: 200px;
      }
      #logo {
            width: 170px; 
            height: 115px; 
            background-image: url('logo.png'); 
            background-size: cover;
      }

.container {
  max-width: 1200px;
  margin: 40px auto;
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  grid-gap: 20px;
  padding-top:2px;
}

.card {
  background-color: #fff;
  padding: 20px;
  border-radius: 5px;
  box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
}

.card h2 {
  margin-top: 0;
  font-weight: bold;
  color: #333;
}

.card p {
  margin-bottom: 0;
  font-size: 15px;
  color: #666;
  text-align: center;
}

.card p span {
  font-weight: bold;
  color: #ff9900; /* orange */
  border-radius: 50%;
  padding: 5px 10px;
  background-color: #fff;
  border: 1px solid #ff9900;
}

.circle {
  font-size: 17px;
  font-weight: bold;
  color: #e86100;
  border-radius: 50%;
  padding: 10px 15px;
  background-color: #fff;
  border: 1px solid #ff9900;
  display: inline-block;
}

h2 {
  margin-top: 0;
  font-weight: bold;
  color: black;
  font-size: 20px;
}

h3 {
  margin-bottom: 10px;
  font-weight: bold;
  color: black;
}
#alumnimeet {
  width: 50%; 
  height: 60%;
  background-image: url('alumnimeet.jpeg'); 
  background-size: cover;
}
#alumnilogo {
  width: 170px; 
  height: 115px; 
  background-image: url('alumni.jpeg'); 
  background-size: cover;
}
.nav-dropdown {
position: relative; 
display: inline-block;
}
.container h2{
color: #e86100;
font-size: 17px;
}

	           .nav-dropdown-content {display: none;background-image:url('success_stories.jpg');background-repeat: no-repeat;background-position: buttom;color:rgba(232,97,0); position: absolute;min-width: 205px; box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); z-index: 1; text-align: left;}

	           .nav-dropdown-content a {padding: 10px; display: block; font-size: 20px; text-decoration: none;color: #e86100;}

	           .nav-dropdown:hover .nav-dropdown-content {display: block;}
	          .navbar {position: fixed; top: 130px; left: 0; right: 0; background-color: #e86100; padding: 20px 0; display: flex; justify-content: center; z-index: 100;}

	           .navbar .nav-dropdown {margin-left: 0px; margin-right:20px;}
	           .registration-button {background-color: white; color: #e86100; border: none; padding: 10px 20px; font-size: 18px; cursor: pointer; margin-right: -1070px;}
	           .login-button {background-color: white; color: #e86100; border: none; padding: 10px 20px; font-size: 18px; cursor: pointer; margin-right: 20px;}
	           .center-division a:link {color: white; background-color: transparent; text-decoration: none;}
	          .center-division a:visited {color:blue; background-color: transparent; text-decoration: none;}
	           .center-division a:hover {color: red; background-color: transparent; text-decoration: underline;}
	           .center-division a:active {color: yellow; background-color: transparent; text-decoration: underline;}
	           footer {background-color: #333; padding: 20px 0; color: #fff;}
	           span{color: white; font-size: 17.5px;}
	           .left-division {margin-left: 30px; height:100px;align-content: absolute; }
	           .left-division p{margin: 0 10px;}
	           .clear{clear:both;}
	           
	           .right-division {margin-left: 1300px; margin-top:-150px; height:100px; }
	           

	                  /* Style for the center division */
	           .center-division {text-align: center; margin-right:10px; font-size: larger;}
	          .center-division a{margin: 0 10px;}
	           .events{width:50%; margin: 10px; margin-left:100px; margin-top: 20px; padding-left: 20px; padding-top: 10px;}
	           .news{width:40%; margin: 10px; margin-left: 850px; margin-top: -325px; padding-left: 20px; padding-top: 10px;}
       

</style>
</head>
<body>
<header id='header'>
<div id='logo'></div>
<h1>Alumni<br>Managment System</h1>
<form action='login.html'>
<button class='login-button' id='login-button' style='font-size: 30px'>:    : Login</button></form>
</header>
<div class="navbar">
	           <div class="nav-dropdown">
	           <span>About</span>
	           <div class="nav-dropdown-content">
	           <a href="alumni.jsp">Alumni</a>
	           <a href="opportunities.html">Opportunities</a>
	           <a href="boardmembers.html">Board Members</a>
	           </div></div>
	           
	           <div class="nav-dropdown">
	           <span>Events</span>
	           <div class="nav-dropdown-content">
	           <a href="event2024.html">2024-2025 Events </a>
	           <a href="event2023.html">2023-2024 Events </a>
	           <a href="event2022.html">2022-2023 Events </a>
	           <a href="event2021.html\">2021-2022 Events </a>
	           <a href="event2020.html\">2020-2021 Events </a>
	           <a href="event2019.html\">2019-2020 Events </a>
	           <a href="event2018.html\">2018-2019 Events </a>
	           </div></div>
	           
	           <div class="nav-dropdown">
	           <span>NewsRoom</span>
	           <div class="nav-dropdown-content">
	           <a href="success-stories.html">success-stories</a>
	           <a href="campus.html">campus</a>
	           <a href="achievements.html">Achievements</a>
	           </div></div>
	           
	           
	           <div class="nav-dropdown">
	           <span>Gallery</span>
	           <div class="nav-dropdown-content">
	           <a href="images.html">Album</a>
	           <a href="videos.html">Videos</a>
	           <a href="memories.html">Memories</a>
	           </div></div>
	           
	           <div class="nav-dropdown">
	           <span>Assist</span>
	           <div class="nav-dropdown-content">
	           <a href="query.html">Send a query</a>
	           <a href="feedbackform.html">Feedback</a>
	           <a href="https://instagram.com/alumni_vvit?igshid=MzRlODBiNWFlZA==" target="_blank">Instagram page</a>
	           </div></div>
	           
	           <div class="nav-dropdown">
	           <span>Engage</span>
	           <div class="nav-dropdown-content">
	           <a href="volunteer.html">Volunteer</a>
	           <a href="mentor.html">Be a mentor</a>
	           <a href="opportunities.html">Share opportunities</a>
	           <a href="achievementform.html">Share Achievements</a>
	           </div></div>
	           
	           <div class="nav-dropdown">
	           <span>More</span>
	           <div class="nav-dropdown-content">
	           <a href="contact.html">Contact us</a>
	           <a href="community.html">Join a community</a>
	           </div></div></div>
	           

<div class="head">
<h2><span class="circle"><%= session.getAttribute("buttonId") %></span> > Select Programme/Course/Department</h2>

<h3>Bachelor of Technology (B. Tech)</h3></div>
<form action="Course" method="post">
 <input type="hidden" name="batch" value="<%= session.getAttribute("buttonId") %>">
<div class="container">
  <div class="card">
    <h2><button class="login-button" name="course" value="CSE">Computer Science and Engineering - CSE</button></h2>
    <p><%

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
String buttonId = (String) session.getAttribute("buttonId");
String query = "SELECT COUNT(*) FROM `alumnus_bio` WHERE `course` = 'CSE' AND `batch` = '" + buttonId + "'";
rs = stmt.executeQuery(query);
    // Move the cursor to the first row (if any)
    if (rs.next()) {
      int numActiveAlumni = rs.getInt(1); // Assuming the first column stores the number of rows
      out.println("" + numActiveAlumni+" Members");
    }
   } catch (ClassNotFoundException e) {
      out.println("Driver not found: " + e.getMessage());
   } catch (SQLException e) {
      out.println(e);
   } finally {
      // Close resources
      
   }
%></p>
  </div>
  <div class="card">
    <h2><button class="login-button" name="course" value="IT">Information Technology - IT</button></h2>
    <p><%try {
    stmt = con.createStatement();
    String buttonId = (String) session.getAttribute("buttonId");
    String query = "SELECT COUNT(*) FROM `alumnus_bio` WHERE `course` = 'IT' AND `batch` = '" + buttonId + "'";
    rs = stmt.executeQuery(query);
    // Check if there are any rows in the result set
    if (rs.next()) {
      int numTopics = rs.getInt(1); // Assuming the first column stores the number of rows (adjust if needed)
      out.println("" + numTopics+" Members");
    } 
  } catch (SQLException e) {
    out.println("Error executing query: " + e.getMessage());
  } finally {
    
  }
%></p>
  </div>
  <div class="card">
    <h2><button class="login-button" name="course" value="MECH">Mechanical Engineering - MECH</button></h2>
    <p><%try {
    stmt = con.createStatement();
    String buttonId = (String) session.getAttribute("buttonId");
    String query = "SELECT COUNT(*) FROM `alumnus_bio` WHERE `course` = 'MECH' AND `batch` = '" + buttonId + "'";
    rs = stmt.executeQuery(query);
    // Check if there are any rows in the result set
    if (rs.next()) {
      int numTopics = rs.getInt(1); // Assuming the first column stores the number of rows (adjust if needed)
      out.println("" + numTopics+" Members");
    } 
  } catch (SQLException e) {
    out.println("Error executing query: " + e.getMessage());
  } finally {
    
  }
%></p>
  </div>
  <div class="card">
    <h2><button class="login-button" name="course" value="ECE">Electronics and Communication Engineering - ECE</button></h2>
    <p><%try {
    stmt = con.createStatement();
    String buttonId = (String) session.getAttribute("buttonId");
    String query = "SELECT COUNT(*) FROM `alumnus_bio` WHERE `course` = 'ECE' AND `batch` = '" + buttonId + "'";
    rs = stmt.executeQuery(query);
    // Check if there are any rows in the result set
    if (rs.next()) {
      int numTopics = rs.getInt(1); // Assuming the first column stores the number of rows (adjust if needed)
      out.println("" + numTopics+" Members");
    } 
  } catch (SQLException e) {
    out.println("Error executing query: " + e.getMessage());
  } finally {
    
  }
%></p>
  </div>
  <div class="card">
    <h2><button class="login-button" name="course" value="CIVIL">CIVIL Engineering - CIV</button></h2>
    <p><%try {
    stmt = con.createStatement();
    String buttonId = (String) session.getAttribute("buttonId");
    String query = "SELECT COUNT(*) FROM `alumnus_bio` WHERE `course` = 'CIVIL' AND `batch` = '" + buttonId + "'";
    rs = stmt.executeQuery(query);
    // Check if there are any rows in the result set
    if (rs.next()) {
      int numTopics = rs.getInt(1); // Assuming the first column stores the number of rows (adjust if needed)
      out.println("" + numTopics+" Members");
    } 
  } catch (SQLException e) {
    out.println("Error executing query: " + e.getMessage());
  } finally {
    
  }
%></p>
  </div>
  <div class="card">
    <h2><button class="login-button" name="course" value="EEE">Electrical and Electronics Engineering - EEE</button></h2>
    <p><%try {
    stmt = con.createStatement();
    String buttonId = (String) session.getAttribute("buttonId");
    String query = "SELECT COUNT(*) FROM `alumnus_bio` WHERE `course` = 'EEE' AND `batch` = '" + buttonId + "'";
    rs = stmt.executeQuery(query);
    // Check if there are any rows in the result set
    if (rs.next()) {
      int numTopics = rs.getInt(1); // Assuming the first column stores the number of rows (adjust if needed)
      out.println("" + numTopics+" Members");
    } 
  } catch (SQLException e) {
    out.println("Error executing query: " + e.getMessage());
  } finally {
    
  }
%></p>
  </div>
  <div class="card">
    <h2><button class="login-button" name="course" value="CIC">Computer Science and Engineering in Cyber Security - CIC</button></h2>
    <p><%try {
    stmt = con.createStatement();
    String buttonId = (String) session.getAttribute("buttonId");
    String query = "SELECT COUNT(*) FROM `alumnus_bio` WHERE `course` = 'CIC' AND `batch` = '" + buttonId + "'";
    rs = stmt.executeQuery(query);
    // Check if there are any rows in the result set
    if (rs.next()) {
      int numTopics = rs.getInt(1); // Assuming the first column stores the number of rows (adjust if needed)
      out.println("" + numTopics+" Members");
    } 
  } catch (SQLException e) {
    out.println("Error executing query: " + e.getMessage());
  } finally {
    
  }
%></p>
  </div>
  <div class="card">
    <h2><button class="login-button" name="course" value="IOT" id="">Computer Science and Engineering in IOT</button></h2>
    <p><%try {
    stmt = con.createStatement();
    String buttonId = (String) session.getAttribute("buttonId");
    String query = "SELECT COUNT(*) FROM `alumnus_bio` WHERE `course` = 'IOT' AND `batch` = '" + buttonId + "'";
    rs = stmt.executeQuery(query);
    // Check if there are any rows in the result set
    if (rs.next()) {
      int numTopics = rs.getInt(1); // Assuming the first column stores the number of rows (adjust if needed)
      out.println("" + numTopics+" Members");
    } 
  } catch (SQLException e) {
    out.println("Error executing query: " + e.getMessage());
  } finally {
    
  }
%></p>
  </div>
  <div class="card">
    <h2><button class="login-button" name="course" value="AIDS">Artificial Intelligance in Data Science - AIDS</button></h2>
    <p><%try {
    stmt = con.createStatement();
    String buttonId = (String) session.getAttribute("buttonId");
    String query = "SELECT COUNT(*) FROM `alumnus_bio` WHERE `course` = 'AIDS' AND `batch` = '" + buttonId + "'";
    rs = stmt.executeQuery(query);
    // Check if there are any rows in the result set
    if (rs.next()) {
      int numTopics = rs.getInt(1); // Assuming the first column stores the number of rows (adjust if needed)
      out.println("" + numTopics+" Members");
    } 
  } catch (SQLException e) {
    out.println("Error executing query: " + e.getMessage());
  } finally {
    
  }
%></p>
  </div>
  <div class="card">
    <h2><button class="login-button" name="course" value="AIML">Artificial Intelligance in Machine Learning - AIML</button></h2>
    <p><%try {
    stmt = con.createStatement();
    String buttonId = (String) session.getAttribute("buttonId");
    String query = "SELECT COUNT(*) FROM `alumnus_bio` WHERE `course` = 'AIML' AND `batch` = '" + buttonId + "'";
    rs = stmt.executeQuery(query);
    // Check if there are any rows in the result set
    if (rs.next()) {
      int numTopics = rs.getInt(1); // Assuming the first column stores the number of rows (adjust if needed)
      out.println("" + numTopics+" Members");
    } 
  } catch (SQLException e) {
    out.println("Error executing query: " + e.getMessage());
  } finally {
    
  }
%></p>
  </div>
</div>
</form>

</body>
</html>