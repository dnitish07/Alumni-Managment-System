package alumni;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/UpdateJob")
public class UpdateJob extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String company = request.getParameter("company");
        String location = request.getParameter("location");
        String job_title = request.getParameter("job_title");
        String description = request.getParameter("description");
        String date_created = request.getParameter("date_created");
        String apply_link = request.getParameter("apply_link");

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_db", "root", "")) {
            String sql = "UPDATE careers SET apply_link = ?, date_created = ?, description = ?, job_title = ?, location = ?, company = ? WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            	stmt.setString(1, apply_link);
            	stmt.setString(2, date_created);
            	stmt.setString(3, description);
                stmt.setString(4, job_title);
                stmt.setString(5, location);
                stmt.setString(6, company);
                stmt.setInt(7, id);

                int rows = stmt.executeUpdate();
                if (rows > 0) {
                    response.sendRedirect("jobs.jsp");
                } else {
                    response.getWriter().println("Failed to update record.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred: " + e.getMessage());
        }
    }
}
