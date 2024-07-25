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
<meta charset="ISO-8859-1">
<title>Admin Home</title>
<link rel="stylesheet" href="styles.css">
<style>
   span.float-right.summary_icon {
    font-size: 3rem;
    position: absolute;
    right: 1rem;
    color: #ffffff96;
}
.imgs{
		margin: .5em;
		max-width: calc(100%);
		max-height: calc(100%);
	}
	.imgs img{
		max-width: calc(100%);
		max-height: calc(100%);
		cursor: pointer;
	}
	#imagesCarousel,#imagesCarousel .carousel-inner,#imagesCarousel .carousel-item{
		height: 60vh !important;background: black;
	}
	#imagesCarousel .carousel-item.active{
		display: flex !important;
	}
	#imagesCarousel .carousel-item-next{
		display: flex !important;
	}
	#imagesCarousel .carousel-item img{
		margin: auto;
	}
	#imagesCarousel img{
		width: auto!important;
		height: auto!important;
		max-height: calc(100%)!important;
		max-width: calc(100%)!important;
	}
</style>
</head>
<body>
<div class="containe-fluid">
	<div class="row mt-3 ml-3 mr-3">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-body">
                    Welcome Back Admin
                    <hr>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="card">
                                <div class="card-body bg-primary">
                                    <div class="card-body text-white">
                                        <span class="float-right summary_icon"><i class="fa fa-users"></i></span>
                                        <h4><b>
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
      rs = stmt.executeQuery("SELECT COUNT(*) AS num_active_alumni FROM alumnus_bio");

    // Move the cursor to the first row (if any)
    if (rs.next()) {
      int numActiveAlumni = rs.getInt(1); // Assuming the first column stores the number of rows
      out.println("" + numActiveAlumni);
    } else {
      out.println("No active alumni found.");
    }
   } catch (ClassNotFoundException e) {
      out.println("Driver not found: " + e.getMessage());
   } catch (SQLException e) {
      out.println(e);
   } finally {
      // Close resources
      
   }
%>
                                        </b></h4>
                                        <p><b>Alumni</b></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card">
                                <div class="card-body bg-info">
                                    <div class="card-body text-white">
                                        <span class="float-right summary_icon"><i class="fa fa-comments"></i></span>
                                        <h4><b>
                                            <%
  // Assuming a connection object (`conn`) is already established

  // Execute the query to get the number of forum topics
  
try {
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT COUNT(*) AS num_active_alumni FROM forum_topics");

    // Check if there are any rows in the result set
    if (rs.next()) {
      int numTopics = rs.getInt(1); // Assuming the first column stores the number of rows (adjust if needed)
      out.println("" + numTopics);
    } else {
      out.println("No forum topics found.");
    }

  } catch (SQLException e) {
    out.println("Error executing query: " + e.getMessage());
  } finally {
    
  }
%>
                                        </b></h4>
                                        <p><b>Forum Topics</b></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card">
                                <div class="card-body bg-warning">
                                    <div class="card-body text-white">
                                        <span class="float-right summary_icon"><i class="fa fa-briefcase"></i></span>
                                        <h4><b>
                                            
                                            <%
                                            try {
                                                stmt = con.createStatement();
                                                rs = stmt.executeQuery("SELECT COUNT(*) AS num_active_alumni FROM careers");

                                                // Move the cursor to the first row (if any)
                                                if (rs.next()) {
                                                  int numActiveAlumni = rs.getInt(1); // Assuming the first column stores the number of rows
                                                  out.println("" + numActiveAlumni);
                                                } else {
                                                  out.println("No active alumni found.");
                                                }

                                              } catch (SQLException e) {
                                                out.println("Error executing query: " + e.getMessage());
                                              } finally {
                                                
                                              }
                                            
                                            %>
                                        </b></h4>
                                        <p><b>Posted jobs</b></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card">
                                <div class="card-body bg-primary">
                                    <div class="card-body text-white">
                                        <span class="float-right summary_icon"><i class="fa fa-calendar-day"></i></span>
                                        <h4><b>
                                            
                                            <%
                                            try {
                                                stmt = con.createStatement();
                                                rs = stmt.executeQuery("SELECT COUNT(*) AS num_active_alumni FROM events where date_format(schedule,'%Y-%m%-d')");

                                                // Move the cursor to the first row (if any)
                                                if (rs.next()) {
                                                  int numActiveAlumni = rs.getInt(1); // Assuming the first column stores the number of rows
                                                  out.println("" + numActiveAlumni);
                                                } else {
                                                  out.println("No active alumni found.");
                                                }

                                              } catch (SQLException e) {
                                                out.println("Error executing query: " + e.getMessage());
                                              } finally {
                                                
                                              }
                                            
                                            %>
                                        </b></h4>
                                        <p><b>Upcoming Events</b></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>	

                    
                </div>
            </div>      			
        </div>
    </div>
</div>
<script>
	$('#manage-records').submit(function(e){
        e.preventDefault()
        start_load()
        $.ajax({
            url:'ajax.php?action=save_track',
            data: new FormData($(this)[0]),
            cache: false,
            contentType: false,
            processData: false,
            method: 'POST',
            type: 'POST',
            success:function(resp){
                resp=JSON.parse(resp)
                if(resp.status==1){
                    alert_toast("Data successfully saved",'success')
                    setTimeout(function(){
                        location.reload()
                    },800)

                }
                
            }
        })
    })
    $('#tracking_id').on('keypress',function(e){
        if(e.which == 13){
            get_person()
        }
    })
    $('#check').on('click',function(e){
            get_person()
    })
    function get_person(){
            start_load()
        $.ajax({
                url:'ajax.php?action=get_pdetails',
                method:"POST",
                data:{tracking_id : $('#tracking_id').val()},
                success:function(resp){
                    if(resp){
                        resp = JSON.parse(resp)
                        if(resp.status == 1){
                            $('#name').html(resp.name)
                            $('#address').html(resp.address)
                            $('[name="person_id"]').val(resp.id)
                            $('#details').show()
                            end_load()

                        }else if(resp.status == 2){
                            alert_toast("Unknow tracking id.",'danger');
                            end_load();
                        }
                    }
                }
            })
    }
</script>
</body>
</html>