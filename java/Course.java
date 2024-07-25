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
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/Course")
public class Course extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String courseName = request.getParameter("course");
        String batch = request.getParameter("batch");

        // Store the course name in the session
        HttpSession session = request.getSession();
        session.setAttribute("courseName", courseName);
        session.setAttribute("batch", batch);

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            PrintWriter out = response.getWriter();
            Class.forName("com.mysql.cj.jdbc.Driver"); // Updated driver class

            // Establish Connection
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_db", "root", "");

            // Create PreparedStatement
            String query = "SELECT * FROM alumnus_bio WHERE batch = ? AND course = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, batch);
            pstmt.setString(2, courseName);
            rs = pstmt.executeQuery();

            out.println("<!DOCTYPE html>");
            out.println("<html lang=\"en\">");
            out.println("<head>");
            out.println("<meta charset=\"UTF-8\">");
            out.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
            out.println("<title>Alumni Details</title>");
            out.println("<style>");
            out.println("body { font-family: Arial, sans-serif; background-color: #f8f8f8; margin: 0; padding: 20px; }");
            out.println(".container { display: flex; flex-wrap: wrap; gap: 20px; }");
            out.println(".profile-card { flex: 1 1 calc(25% - 20px); box-sizing: border-box; background-color: white; border-radius: 10px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); padding: 20px; text-align: center; margin-bottom: 20px; text-decoration: none; color: inherit; }");
            out.println(".profile-card img { border-radius: 50%; width: 150px; height: 150px; }");
            out.println(".profile-card h2 { color: #e67760; margin: 10px 0; }");
            out.println(".profile-card p { color: #333; margin: 5px 0; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1 style=\"text-align: center; color: #e67760;\">Alumni Details</h1>");
            out.println("<div class=\"container\">");

            while (rs.next()) {
                String regdno = rs.getString("regdno");
                String fullname = rs.getString("fullname");
                String phonenumber = rs.getString("phonenumber");
                String email = rs.getString("email");
                String photo = rs.getString("picture");
                String id = rs.getString("id");

                out.println("<a href=\"studentDetails.jsp?regdno=" + regdno + "\" class=\"profile-card\">");
                out.println("<img src=\"assets/uploads/" + photo + "\" alt=\"Profile Picture\">");
                out.println("<h2>" + fullname + "</h2>");
                out.println("<p>Student ID: " + regdno + "</p>");
                out.println("<p>Year: " + batch + "</p>");
                out.println("<p>Course: " + courseName + "</p>");
                out.println("</a>");
            }

            out.println("</div>");
            out.println("</body>");
            out.println("</html>");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
