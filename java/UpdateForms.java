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


@WebServlet("/UpdateForms")
public class UpdateForms extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String date_created = request.getParameter("date_created");
        

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_db", "root", "")) {
            String sql = "UPDATE forum_topics SET date_created = ?, description = ?, title = ? WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                
                stmt.setString(1, date_created);
                stmt.setString(2, description);
                stmt.setString(3, title);
                stmt.setInt(4, id);

                int rows = stmt.executeUpdate();
                if (rows > 0) {
                    response.sendRedirect("forms.jsp");
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
