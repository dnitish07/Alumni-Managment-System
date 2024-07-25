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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alumni Details</title>
    <style>
        body {
            font-family: sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f4f4f4;
        }

        .head {
            background-color: #e86100;
            color: #fff;
            padding: 20px;
            text-align: center;
        }

        .head h1 {
            margin: 0;
            font-size: 2rem;
        }

        .head p {
            margin: 0;
            font-size: 1.2rem;
            color: #ccc;
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
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            padding: 70px;
            padding-top: 200px;
        }

        .card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
            cursor: pointer;
        }

        .card:hover {
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }

        .card h3 {
            margin-bottom: 10px;
            font-size: 1.2rem;
            color: ##e86100;
        }

        .card p {
            font-size: 1rem;
            color: #666;
        }
        
         #alumnimeet {width: 50%; height: 60%; background-image: url('alumnimeet.jpeg'); background-size: cover;}

	           #alumnilogo {width: 170px; height: 115px; background-image: url('alumni.jpeg'); background-size: cover;}
	           .nav-dropdown {position: relative; display: inline-block;}

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
	           .submit{
	           	   background-color: white; color: #e86100; border: none; padding: 10px 20px; font-size: 18px; cursor: pointer; margin-right: 20px;}


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
        <h1>Alumni Details</h1>
        <p>Select Year</p>
    </div>
     <form action="Next" method="post">
    <div class="container">
   
        <div class="card">
            <h3><button class="login-button" id="2024" name="buttonvalue" value="2024">Class of 2024</button></h3>
            <p> <%

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
      rs = stmt.executeQuery("SELECT COUNT(*) FROM `alumnus_bio` WHERE `batch` = '2024'");

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
%>
    </p>
        </div>
        <div class="card">
            <h3><button class="login-button" id="2023" name="buttonvalue" value="2023">Class of 2023</button></h3>
            <p><%try {
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT COUNT(*) FROM `alumnus_bio` WHERE `batch`='2023'");

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
            <h3><button class="login-button" id="2022" name="buttonvalue" value="2022">Class Of 2022</button></h3>
            <p><%try {
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT COUNT(*) FROM `alumnus_bio` WHERE `batch` = '2022'");

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
            <h3><button class="login-button" id="2021" name="buttonvalue" value="2021">Class of 2021</button></h3>
            <p><%try {
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT COUNT(*) FROM `alumnus_bio` WHERE `batch`='2021'");

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
            <h3><button class="login-button" id="2020" name="buttonvalue" value="2020">Class of 2020</button></h3>
            <p><%try {
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT COUNT(*) FROM `alumnus_bio` WHERE `batch`='2020'");

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
            <h3><button class="login-button" id="2019" name="buttonvalue" value="2019">Class Of 2019</button></h3>
            <p><%try {
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT COUNT(*) FROM `alumnus_bio` WHERE `batch`='2019'");

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
            <h3><button class="login-button" id="2018" name="buttonvalue" value="2018">Class Of 2018</button></h3>
            <p><%try {
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT COUNT(*) FROM `alumnus_bio` WHERE `batch`='2018'");

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
            <h3><button class="login-button" id="2017" name="buttonvalue" value="2017">Class Of 2017</button></h3>
            <p><%try {
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT COUNT(*) FROM `alumnus_bio` WHERE `batch`='2017'");

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
            <h3><button type="submit" class="login-button"  name="buttonvalue" value="2016" >Class Of 2016</button></h3>
            <p><%try {
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT COUNT(*) FROM `alumnus_bio` WHERE `batch`='2016'");

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
            <h3><button class="login-button" id="2015" name="buttonvalue" value="2015">Class Of 2015</button></h3>
            <p><%try {
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT COUNT(*) FROM `alumnus_bio` WHERE `batch`='2015'");

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
            <h3><button class="login-button" id="2014" name="buttonvalue" value="2014">Class Of 2014</button></h3>
            <p><%try {
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT COUNT(*) FROM `alumnus_bio` WHERE `batch`='2014'");

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
            <h3><button class="login-button" id="2013" name="buttonvalue" value="2013">Class Of 2013</button></h3>
            <p><%try {
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT COUNT(*) FROM `alumnus_bio` WHERE `batch`='2013'");

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
            <h3><button class="login-button" id="2012" name="buttonvalue" value="2012">Class of 2012</button></h3>
            <p><%try {
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT COUNT(*) FROM `alumnus_bio` WHERE `batch`='2012'");

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
            <h3><button class="login-button" id="2011" name="buttonvalue" value="2011">Class Of 2011</button></h3>
            <p><%try {
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT COUNT(*) FROM `alumnus_bio` WHERE `batch`='2011'");

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
            <h3><button class="login-button" id="2010" name="buttonvalue" value="2010">Class Of 2010</button></h3>
            <p><%try {
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT COUNT(*) FROM `alumnus_bio` WHERE `batch`='2010'");

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
            <h3><button class="login-button" id="2009" name="buttonvalue" value="2009">Class Of 2009</button></h3>
            <p><%try {
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT COUNT(*) FROM `alumnus_bio` WHERE `batch`='2009'");

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
    
    <script>
        // Add JavaScript code here if needed
    </script>
</body>
</html>