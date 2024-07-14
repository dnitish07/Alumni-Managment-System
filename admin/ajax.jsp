<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.io.*, java.nio.file.*, jakarta.servlet.*, jakarta.servlet.http.*, jakarta.servlet.annotation.*" %>
<%
    String action = request.getParameter("action");

    if ("save_gallery".equals(action)) {
        String id = request.getParameter("id");
        String about = request.getParameter("about");
        Part filePart = request.getPart("img");
        String fileName = null;
        if (filePart != null && filePart.getSize() > 0) {
            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadDir = getServletContext().getRealPath("") + File.separator + "assets/uploads/gallery";
            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists()) uploadDirFile.mkdirs();
            filePart.write(uploadDir + File.separator + id + "_" + fileName);
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdb", "username", "password");

            if (id == null || id.isEmpty()) {
                String sql = "INSERT INTO gallery (about) VALUES (?)";
                pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                pstmt.setString(1, about);
                int affectedRows = pstmt.executeUpdate();
                if (affectedRows > 0) {
                    ResultSet generatedKeys = pstmt.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        id = String.valueOf(generatedKeys.getLong(1));
                    }
                }
                out.print("1");
            } else {
                String sql = "UPDATE gallery SET about=? WHERE id=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, about);
                pstmt.setString(2, id);
                pstmt.executeUpdate();
                out.print("2");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    } else if ("delete_gallery".equals(action)) {
        String id = request.getParameter("id");

        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdb", "username", "password");
            String sql = "DELETE FROM gallery WHERE id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.executeUpdate();
            out.print("1");

            String uploadDir = getServletContext().getRealPath("") + File.separator + "assets/uploads/gallery";
            File fileToDelete = new File(uploadDir + File.separator + id + "_*");
            fileToDelete.delete();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    } else {
        out.print("0");
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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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



