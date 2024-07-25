<%@ page import="java.sql.*, java.io.*, jakarta.servlet.*, jakarta.servlet.http.*, jakarta.servlet.annotation.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.annotation.MultipartConfig" %>
<%@ page import="jakarta.servlet.http.Part" %>
<%@ page import="java.nio.file.Paths" %>

<%
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html;charset=UTF-8");

    String action = request.getParameter("action");
    if ("save_gallery".equals(action)) {
        String savePath = application.getRealPath("/") + "uploads";
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }

        Part filePart = request.getPart("img"); // Retrieves <input type="file" name="img">
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
        filePart.write(savePath + File.separator + fileName);

        String about = request.getParameter("about");

        // Database connection
        String dbURL = "jdbc:mysql://localhost:3306/alumni_db";
        String dbUser = "root";
        String dbPass = "";

        Connection conn = null;
        PreparedStatement statement = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            String sql = "INSERT INTO photo (image, about) VALUES (?, ?)";
            statement = conn.prepareStatement(sql);
            statement.setString(1, "uploads/" + fileName);
            statement.setString(2, about);

            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                out.println("<p>File uploaded and saved into database.</p>");
            } else {
                out.println("<p>Failed to save file into database.</p>");
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>

<%
// Establish database connection
Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;


try {
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_db", "root", "");

    if (action != null) {
        if (action.equals("save_course")) {
            String id = request.getParameter("id");
            String course = request.getParameter("course");

            if (id == null || id.isEmpty()) {
                // Insert new course
                stmt = conn.prepareStatement("INSERT INTO courses (course) VALUES (?)");
                stmt.setString(1, course);
                stmt.executeUpdate();
                response.getWriter().print(1); // Success response
            } else {
                // Update existing course
                stmt = conn.prepareStatement("UPDATE courses SET course = ? WHERE id = ?");
                stmt.setString(1, course);
                stmt.setInt(2, Integer.parseInt(id));
                stmt.executeUpdate();
                response.getWriter().print(2); // Success response
            }
        } else if (action.equals("delete_course")) {
            String id = request.getParameter("id");
            stmt = conn.prepareStatement("DELETE FROM courses WHERE id = ?");
            stmt.setInt(1, Integer.parseInt(id));
            stmt.executeUpdate();
            response.getWriter().print(1); // Success response
        }
    }
} catch (SQLException e) {
    e.printStackTrace();
    response.getWriter().print(0); // Error response
} finally {
    // Close resources
    if (rs != null) {
        try {
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    if (stmt != null) {
        try {
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    if (conn != null) {
        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
%>

<%

if (action != null && action.equals("delete_event")) {
    int eventId = Integer.parseInt(request.getParameter("id"));
    Connection con = null;
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_db", "root", "");
        
        // Delete event record
        String deleteEventQuery = "DELETE FROM events WHERE id = ?";
        stmt = conn.prepareStatement(deleteEventQuery);
        stmt.setInt(1, eventId);
        int rowsAffected = stmt.executeUpdate();
        
        // Delete associated commits (if needed)
        String deleteCommitsQuery = "DELETE FROM event_commits WHERE event_id = ?";
        stmt = conn.prepareStatement(deleteCommitsQuery);
        stmt.setInt(1, eventId);
        int commitsDeleted = stmt.executeUpdate();
        
        out.println(rowsAffected); // Return number of rows affected (1 for success, 0 for failure)
        
    } catch (Exception e) {
        e.printStackTrace();
        out.println("0"); // Return 0 indicating failure
    } finally {
        if (stmt != null) {
            try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (conn != null) {
            try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
%>

<%@ page import="java.io.*, java.util.*, jakarta.servlet.*, jakarta.servlet.http.*, jakarta.servlet.annotation.*, java.nio.file.*"%>
<%
    
    if ("save_settings".equals(action)) {
        // Get the form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String about = request.getParameter("about");

        // Handle file upload
        Part filePart = request.getPart("img");
        String fileName = null;
        if (filePart != null && filePart.getSize() > 0) {
            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadDir = getServletContext().getRealPath("") + File.separator + "assets/uploads";
            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists()) uploadDirFile.mkdirs();
            filePart.write(uploadDir + File.separator + fileName);
        }

        // Save the data (for demonstration purposes, we're just printing it out)
        // In a real application, save the data to a database or configuration file
        System.out.println("Name: " + name);
        System.out.println("Email: " + email);
        System.out.println("Contact: " + contact);
        System.out.println("About: " + about);
        System.out.println("Image: " + fileName);

        // Send a response
        response.getWriter().print("1");
    } else {
        response.getWriter().print("0");
    }
%>



