package alumni;

import java.io.IOException;
import java.sql.Connection;
//import java.sql.DriverManager;
import java.sql.PreparedStatement;
//import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteCourse")
public class DeleteCourse extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
       
        try {
			// PrintWriter out = response.getWriter();
			Connection con = DBConnect.connect(); // Ensure DBConnect class provides a valid connection

			// Insert image details into database
			 String sql = "DELETE FROM courses WHERE id = ?";
			PreparedStatement st = con.prepareStatement(sql);
			
			st.setInt(1, id);
			int rows = st.executeUpdate();
			if (rows > 0) {
                response.getWriter().write("{\"success\":true}");
            } else {
                response.getWriter().write("{\"success\":false, \"message\":\"No record found with the given ID.\"}");
            }
        

			response.sendRedirect("course.jsp"); // Redirect to gallery after successful upload

		} catch (Exception e) {
			// e.printStackTrace();
			// response.sendRedirect("gallery.jsp"); // Redirect to error page on database
			// error
		}
	}
}
