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

@WebServlet("/ViewAlumni")
public class ViewAlumni extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        response.setContentType("text/html;charset=UTF-8");

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_db", "root", "");
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM alumnus_bio WHERE id = ?")) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                response.getWriter().println("<html>"
                		+ "<head>"
                		+ "<title>View Alumni Details</title>"
                		+ "<link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>\r\n"
                		+ "	<!-- My CSS -->\r\n"
                		+ "	<link rel=\"stylesheet\" href=\"style.css\">"
                		+ "</head>"
                		+ "<body>"
                		+ "<section id=\"sidebar\">\r\n"
                		+ "		<a href=\"index.jsp\" class=\"brand\">\r\n"
                		+ "			<img src=\"logo.png\" style=\"height: 80px; width: 100px; margin: 10px; margin-top:50px;\">\r\n"
                		+ "			<span class=\"text\" style=\"padding: 5px; margin-top:40px; font-size: 40px;\">Admin</span>\r\n"
                		+ "		</a>\r\n"
                		+ "		<ul class=\"side-menu top\">\r\n"
                		+ "			<li class=\"active\">\r\n"
                		+ "				<a href=\"index.jsp\">\r\n"
                		+ "					<i class='bx bxs-dashboard' ></i>\r\n"
                		+ "					<span class=\"text\">Home</span>\r\n"
                		+ "				</a>\r\n"
                		+ "			</li>\r\n"
                		+ "			<li>\r\n"
                		+ "				<a href=\"gallery.jsp\">\r\n"
                		+ "					<i class='bx bxs-shopping-bag-alt' ></i>\r\n"
                		+ "					<span class=\"text\">Gallery</span>\r\n"
                		+ "				</a>\r\n"
                		+ "			</li>\r\n"
                		
                		+ "			<li>\r\n"
                		+ "				<a href=\"alumni_list.jsp\">\r\n"
                		+ "					<i class='bx bxs-message-dots' ></i>\r\n"
                		+ "					<span class=\"text\">Alumni list</span>\r\n"
                		+ "				</a>\r\n"
                		+ "			</li>\r\n"
                		+ "			<li>\r\n"
                		+ "				<a href=\"jobs.jsp\">\r\n"
                		+ "					<i class='bx bxs-group' ></i>\r\n"
                		+ "					<span class=\"text\">Jobs</span>\r\n"
                		+ "				</a>\r\n"
                		+ "			</li>\r\n"
                		
                		+ "                <li>\r\n"
                		+ "                    <a href=\"events.jsp\">\r\n"
                		+ "                        <i class='bx bxs-group' ></i>\r\n"
                		+ "                        <span class=\"text\">Events</span>\r\n"
                		+ "                    </a>\r\n"
                		+ "                </li>\r\n"
                		+ "		</ul>\r\n"
                		+ "		<ul class=\"side-menu\">\r\n"
                		+ "			<li>\r\n"
                		+ "				<a href=\"settings.jsp\">\r\n"
                		+ "					<i class='bx bxs-cog' ></i>\r\n"
                		+ "					<span class=\"text\">Settings</span>\r\n"
                		+ "				</a>\r\n"
                		+ "			</li>\r\n"
                		+ "			<li>\r\n"
                		+ "				<a href=\"home.html\" class=\"logout\">\r\n"
                		+ "					<i class='bx bxs-log-out-circle' ></i>\r\n"
                		+ "					<span class=\"text\">Logout</span>\r\n"
                		+ "				</a>\r\n"
                		+ "			</li>\r\n"
                		+ "		</ul>\r\n"
                		+ "	</section>\r\n"
                		+ "	<!-- SIDEBAR -->\r\n"
                		+ "<section id=\"content\">\r\n"
                		+ "		<!-- NAVBAR -->\r\n"
                		+ "		<nav>\r\n"
                		+ "			<i class='bx bx-menu' ></i>\r\n"
                		+ "			<a href=\"index.jsp\" class=\"nav-link\">Welcome Admin</a>\r\n"
                		+ "			<form action=\"#\">\r\n"
                		+ "				<div class=\"form-input\">\r\n"
                		+ "					<input type=\"search\" placeholder=\"Search...\">\r\n"
                		+ "					<button type=\"submit\" class=\"search-btn\"><i class='bx bx-search' ></i></button>\r\n"
                		+ "				</div>\r\n"
                		+ "			</form>\r\n"
                		+ "			<!--  <input type=\"checkbox\" id=\"switch-mode\" hidden>\r\n"
                		+ "			<label for=\"switch-mode\" class=\"switch-mode\"></label>-->\r\n"
                		+ "			<!--<a href=\"#\" class=\"notification\">\r\n"
                		+ "				<i class='bx bxs-bell' ></i>\r\n"
                		+ "				<span class=\"num\">8</span>\r\n"
                		+ "			</a>-->\r\n"
                		+ "			<a href=\"#\" class=\"profile\">\r\n"
                		+ "				<img src=\"img02.webp\">\r\n"
                		+ "			</a>\r\n"
                		+ "		</nav>"
                		+ "<main>");
                response.getWriter().println("<h1 style='color: #e67760;'>Alumni Details</h1>");
                response.getWriter().println("<div style='background-color: white; padding: 20px; border-radius: 8px;'>");

                response.getWriter().println("<p><strong>Picture/Avatar: </strong> <img width='50px' height='50px' src='assets/uploads/" + rs.getString("picture") + "' alt='" + rs.getInt("id") +"'></p>");
                response.getWriter().println("<p><strong>Registration Number (REGD NO): </strong> " + rs.getString("regdno") + "</p>");
                response.getWriter().println("<p><strong>Full Name: </strong> " + rs.getString("fullname") + "</p>");
                response.getWriter().println("<p><strong>Gender: </strong> " + rs.getString("gender") + "</p>");
                response.getWriter().println("<p><strong>Course: </strong> " + rs.getString("course") + " Engineering</p>");
                response.getWriter().println("<p><strong>Date of Birth: </strong> " + rs.getString("dob") + "</p>");
                response.getWriter().println("<p><strong>Aadhar Number: </strong> " + rs.getString("aadharnumber") + "</p>");
                response.getWriter().println("<p><strong>Blood Group: </strong> " + rs.getString("bloodgroup") + "</p>");
                response.getWriter().println("<p><strong>Phone Number: </strong> " + rs.getString("phonenumber") + "</p>");
                response.getWriter().println("<p><strong>Email ID: </strong> " + rs.getString("email") + "</p>");
                response.getWriter().println("<p><strong>Address: </strong> " + rs.getString("address") + "</p>");
                response.getWriter().println("<p><strong>Batch: </strong> " + rs.getString("batch") + "</p>");
                response.getWriter().println("<p><strong>About You: </strong> " + rs.getString("aboutyou") + "</p>");

                response.getWriter().println("<form action='EditAlumni' method='post' style='display: inline;'>"
                    + "<input type='hidden' name='id' value='" + rs.getInt("id") + "'>"
                    + "<button type='submit' style='background-color: #e67760; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer;'>Edit</button>"
                    + "</form>");

                response.getWriter().println("<button type='button' style='background-color: #ccc; color: #333; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer;' onclick=\"window.location.href='alumni_list.jsp'\">Back</button>");

                response.getWriter().println("</div>");

                response.getWriter().println("</main></section></body></html>");
            } else {
                response.getWriter().println("No course found with the provided ID.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred: " + e.getMessage());
        }
    }
}
