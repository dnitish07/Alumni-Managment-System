package alumni;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
//import jakarta.servlet.http.Part;

@MultipartConfig
@WebServlet("/Courses")
public class Courses extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Directory to save uploaded images
	// private static final String UPLOAD_DIRECTORY = "uploads";

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Retrieves uploaded file
		/*Part file = request.getPart("img");
		String inputFileName = file.getSubmittedFileName();
		String uploadPath = "C:/Users/dniti/project/alumni/src/main/webapp/assets/uploads/" + inputFileName;
		try {
			FileOutputStream fos = new FileOutputStream(uploadPath);
			InputStream is = file.getInputStream();
			byte[] data = new byte[is.available()];
			is.read(data);
			fos.write(data);
			fos.close();
		} catch (Exception e) {
		}
*/
		// Database connection and insertion
		try {
			// PrintWriter out = response.getWriter();
			Connection con = DBConnect.connect(); // Ensure DBConnect class provides a valid connection

			// Insert image details into database
			PreparedStatement st = con.prepareStatement("INSERT INTO courses (course) VALUES (?)");
			
			st.setString(1, request.getParameter("course"));
			st.executeUpdate();

			response.sendRedirect("course.jsp"); // Redirect to gallery after successful upload

		} catch (Exception e) {
			// e.printStackTrace();
			// response.sendRedirect("gallery.jsp"); // Redirect to error page on database
			// error
		}
	}

	// Helper method to get uploaded file name

	// Helper method to construct upload path

}
