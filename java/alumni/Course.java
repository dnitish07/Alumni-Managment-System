package alumni;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet implementation class Course
 */
@WebServlet("/Course")
public class Course extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String courseName = request.getParameter("course");
        
        
	     
        // Store the class of year in the session
        HttpSession session = request.getSession();
        session.setAttribute("buttonId", courseName);
        
        // Redirect to the next page
        try {
			PrintWriter out = response.getWriter(); 
			Connection con =DBConnect.connect();
			response.setContentType("text/html");
			PreparedStatement tt = con.prepareStatement("SELECT RegNo,StudentName,Phone,EmailId, FROM ``");
			 ResultSet resultSet = tt.executeQuery();
			 out.println("<html>");
	         out.println("<head>");
	         out.println("<title></title>");
	         out.println("<style>");
	         out.println("body { font-family: 'Arial', sans-serif; background-color: #f4f4f4; }");
	         out.println("table { width: 80%; border-collapse: collapse; margin: 20px auto; }");
	         out.println("th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }");
	         out.println("th { background-color: #4CAF50; color: white; }");
	         out.println("</style>");
	         out.println("</head>");
	         out.println("<body>");

	         out.println("<h1 style='color: #333; text-align: center;'>Alumni Details</h1>");

	         out.println("<table>");
	         out.println("<tr><th>Reg No</th><th>Student Name</th><th>phone</th><th>Email ID</th></tr>");

	         while (resultSet.next()) {
	             String firstname = resultSet.getString("RegNo");
	             String email = resultSet.getString("StudentName");
	             String password = resultSet.getString("Phone");
	             String dob = resultSet.getString("EmailId");
	             
	             

	             out.println("<tr>");
	             out.println("<td>" + firstname + "</td>");
	             out.println("<td>" + email + "</td>");
	             out.println("<td>" + password + "</td>");
	             out.println("<td>" + dob + "</td>");
	             
	             out.println("</tr>");
	         }
	         out.println("</table>");
	         out.println("</body>");
	         out.println("</html>");

        }catch(Exception e) {
        	
        }
	}

}
