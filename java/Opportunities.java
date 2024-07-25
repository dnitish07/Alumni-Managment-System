package alumni;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/Opportunities")
public class Opportunities extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/alumni_db"; // Update URL if needed
    private static final String DB_USER = "root"; // Update with your database username
    private static final String DB_PASSWORD = ""; // Update with your database password

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String company = request.getParameter("company");
        String jobTitle = request.getParameter("job-title");
        String description = request.getParameter("description");
        String location = request.getParameter("job-location");
        String dateCreated = request.getParameter("date-created");
        String applyLink = request.getParameter("apply-link");
        

        // Insert data into the database
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO careers (company, job_title, description, location, date_created, apply_link) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, company);
                statement.setString(2, jobTitle);
                statement.setString(3, description);
                statement.setString(4, location);
                statement.setString(5, dateCreated);
                statement.setString(6, applyLink);

                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                    response.sendRedirect("careers.jsp"); // Redirect to a success page
                } else {
                    response.sendRedirect("error.html"); // Redirect to an error page
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.html"); // Redirect to an error page
        }
    }
}
