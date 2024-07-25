package alumni;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/EditCourse")
public class EditCourse extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        response.setContentType("text/html;charset=UTF-8");

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_db", "root", "");
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM courses WHERE id = ?")) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                response.getWriter().println("<html><head><title>Edit Course</title></head><body>");
                response.getWriter().println("<h1>Edit Course</h1><form action='UpdateCourse' method='post'>");
                response.getWriter().println("<input type='hidden' name='id' value='" + rs.getInt("id") + "'>");
                response.getWriter().println("<label for='course'>New Course Name:</label>");
                response.getWriter().println("<input type='text' name='course' id='course' value='" + rs.getString("course") + "'><br><br>");
                response.getWriter().println("<button type='submit'>Update</button>");
                response.getWriter().println("<button type='button' onclick=\"window.location.href='course.jsp'\">Cancel</button>");
                response.getWriter().println("</form></body></html>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
