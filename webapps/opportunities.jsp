<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

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













    
    
       <!--   
        <div id="opportunity-list">
            <div class="opportunity">
                <h2>Job Opening at XYZ Company</h2>
                <p>XYZ Company is looking for a software developer with experience in web development...</p>
                <p>Posted by John Doe on October 5, 2023</p>
            </div>
            <div class="opportunity">
                <h2>Internship Opportunity at ABC Startup</h2>
                <p>ABC Startup is offering a summer internship program for students interested in...</p>
                <p>Posted by Jane Smith on October 4, 2023</p>
            </div>
        </div>
    </div>
   
    <script>
       // JavaScript to toggle the display of the existing form
const addButton = document.getElementById("add-button");
const existingForm = document.getElementById("existing-form");
const opportunityList = document.getElementById("opportunity-list");

addButton.addEventListener("click", () => {
    existingForm.style.display = "block";
});

existingForm.addEventListener("submit", function (e) {
    e.preventDefault();

    // Get form input values
    const title = document.getElementById("opportunity-title").value;
    const description = document.getElementById("opportunity-description").value;
    const alumniName = document.getElementById("alumni-name").value;
    const postDate = document.getElementById("post-date").value;
    const applyLink = document.getElementById("applyLink").value;

    // Create a new opportunity element
    const opportunityDiv = document.createElement("div");
    opportunityDiv.className = "opportunity";
    opportunityDiv.innerHTML = `
        <h2>${title}</h2>
        <p>${description}</p>
        <p>Apply Link: <a href="${applyLink}" target="_blank">${applyLink}</a></p>
        <p>Posted by ${alumniName} on ${postDate}</p>
    `;

    // Append the new opportunity to the opportunity list
    opportunityList.appendChild(opportunityDiv);

    // Reset the form
    existingForm.reset();

    // Hide the form
    existingForm.style.display = "none";
});
    </script>
</body>
</html>
-->
















<!DOCTYPE html>
<html>
<head>
        <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alumni Opportunities</title>
    <style>
        /* Base styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4; /* Light gray background for better contrast */
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #e67760; /* Primary color */
            color: #fff;
            padding: 20px;
            text-align: center;
        }
        h1 {
            margin: 0;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff; /* White background for the container */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .opportunity {
            border: 1px solid #e67760; /* Border color matching the primary color */
            padding: 10px;
            margin-bottom: 20px;
            background-color: #f9f9f9; /* Slightly off-white background for opportunities */
        }
        .opportunity h2 {
            margin-top: 0;
            color: #e67760; /* Heading color matching the primary color */
        }
        .opportunity p {
            margin-bottom: 0;
        }
        #add-opportunity {
            text-align: center;
            margin-bottom: 20px;
        }
        #add-button {
            background-color: #e67760; /* Button color matching the primary color */
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
        }
        #add-button:hover {
            background-color: #d55a50; /* Slightly darker shade for hover effect */
        }
        #add-form {
            display: none;
            border: 1px solid #e67760; /* Border color matching the primary color */
            padding: 20px;
            background-color: #fff; /* White background for the form */
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333; /* Darker color for labels */
        }
        .form-group input[type="text"],
        .form-group textarea,
        .form-group input[type="date"],
        .form-group input[type="url"] {
            width: 100%;
            padding: 7px;
            border: 1px solid #ddd; /* Light gray border for form fields */
            border-radius: 4px;
        }
        .form-group input[type="submit"] {
            background-color: #e67760; /* Submit button color matching the primary color */
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 4px;
        }
        .form-group input[type="submit"]:hover {
            background-color: #d55a50; /* Slightly darker shade for hover effect */
        }
    </style>
</head>
<body>
<header>
        <h1>Alumni Opportunities</h1>
</header>
<div class="container">
       

<form action="Opportunities" id="manage-opportunities" method="post">
    <div class="form-group">
        <label for="company">Company</label>
        <input type="text" id="company" name="company" placeholder="Company Name" required>
    </div>
    <div class="form-group">
        <label for="job-title">Job Title</label>
        <input type="text" id="job-title" name="job-title" placeholder="Job Title" required>
    </div>
    <div class="form-group">
        <label for="description">Description</label>
        <textarea id="description" name="description" placeholder="Job Description" rows="4" required></textarea>
    </div>
    <div class="form-group">
        <label for="job-title">Job Location</label>
        <input type="text" id="job-location" name="job-location" placeholder="Job Location" required>
    </div>
    <div class="form-group">
        <label for="date-created">Date Created</label>
        <input type="datetime-local" id="date-created" name="date-created" required>
    </div>
    <div class="form-group">
        <label for="apply-link">Apply Link:</label>
        <input type="url" id="apply-link" name="apply-link" placeholder="https://example.com/apply">
    </div>
    <input type="submit" value="Post">
</form>
</div>

        
        
<!--  <div class="container-fluid">
        <div class="col-lg-12">
            <div class="row">
                
                <div class="col-md-4">
                    <form action="Gallery" id="manage-gallery" method="post" enctype="multipart/form-data">
                        <div class="card">
                            <div class="card-header">
                                Upload
                            </div>
                            <div class="card-body">
                                <input type="hidden" name="id">
                                <div class="form-group">
                                    <label for="" class="control-label">Image</label>
                                    <input type="file" class="form-control" name="img" onchange="displayImg(this, $(this))">
                                </div>
                                <div class="form-group">
                                    <img src="" alt="" id="cimg" width="100%">
                                </div>
                                <div class="form-group">
                                    <label class="control-label">Short Description</label>
                                    <textarea class="form-control" name='about'></textarea>
                                </div>
                            </div>
                            <div class="card-footer">
                                <div class="row">
                                    <div class="col-md-12">
                                        <button class="btn btn-sm btn-primary col-sm-3 offset-md-3"> Save</button>
                                        <button class="btn btn-sm btn-default col-sm-3" type="button" onclick="window.location.href='gallery.jsp'"> Cancel</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
               
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header">
                            <b>Gallery List</b>
                        </div>
                        <div class="card-body">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th class="text-center">#</th>
                                        <th class="text-center">IMG</th>
                                        <th class="text-center">Gallery</th>
                                        <th class="text-center">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                    try {
                                        int i = 1;
                                       Map<Integer, String> img = new HashMap<>();
                                        //String fpath = application.getRealPath("C:/Users/dniti/project/alumni/src/main/webapp/assets/uploads/");
                                      //  File folder = new File(fpath);
                                       // File[] listOfFiles = folder.listFiles();

                                        /*if (listOfFiles != null) {
                                            for (File file : listOfFiles) {
                                                if (file.isFile()) {
                                                    String fileName = file.getName();
                                                    String[] n = fileName;
                                                    //img.put(Integer.parseInt(n[0]), fileName);
                                                }
                                            }*/

                                        
                                        ResultSet gallery = stmt.executeQuery("SELECT * FROM photo ORDER BY id ASC");

                                        while (gallery.next()) {
                                        	 String imagePath = gallery.getString("image");
                                             String description = gallery.getString("about");
                                        
                                    %>
                                    <tr>
                                        <td class="text-center"><%= i++ %></td>
                                        <td class="">
                                            <img src="assets/uploads/<%= gallery.getString("image") %>" class="gimg" alt="<%=  description%>">
                                        </td>
                                        <td class="">
                                            <%= gallery.getString("about") %>
                                        </td>
                                        <td class="text-center">
                                            <form action="EditPhoto" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="<%= gallery.getInt("id") %>">
                                                <button class="btn btn-sm btn-outline-danger" type="submit">Edit</button>
                                            </form>                                            
                                            <form action="DeletePhoto" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="<%= gallery.getInt("id") %>">
                                                <button class="btn btn-sm btn-outline-danger" type="submit">Delete</button>
                                            </form> </td>
                                    </tr>
                                      <% 
                                      }
                                        }
                                        catch(Exception e){
                                        
                                        }
                                     %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
               
            </div>
        </div>
    </div> -->
</body>
</html>