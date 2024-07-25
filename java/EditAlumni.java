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

@WebServlet("/EditAlumni")
public class EditAlumni extends HttpServlet {
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
                		+ "<title>Edit Alumni</title>"
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
                response.getWriter().println("<h1 style='color: #e67760;'>Edit Alumni</h1>"
                        + "<form action='UpdateAlumni' method='post' enctype='multipart/form-data' style='display: flex; flex-direction: column; max-width: 600px; margin: 0 auto;'>"
                        + "<input type='hidden' name='id' value='" + rs.getInt("id") + "'>"

                        + "<label for='regdno' style='margin: 10px 0 5px; color: #e67760;'>Registration Number:</label>"
                        + "<input type='text' name='regdno' id='regdno' value='" + rs.getString("regdno") + "' style='padding: 10px; border: 1px solid #e67760; border-radius: 5px;'>"

                        + "<label for='fullname' style='margin: 10px 0 5px; color: #e67760;'>Full Name:</label>"
                        + "<input type='text' name='fullname' id='fullname' value='" + rs.getString("fullname") + "' style='padding: 10px; border: 1px solid #e67760; border-radius: 5px;'>"

                        + "<label for='gender' style='margin: 10px 0 5px; color: #e67760;'>Gender:</label>"
                        + "<input type='text' name='gender' id='gender' value='" + rs.getString("gender") + "' style='padding: 10px; border: 1px solid #e67760; border-radius: 5px;'>"

                        + "<label for='course' style='margin: 10px 0 5px; color: #e67760;'>Course:</label>"
                        + "<input type='text' name='course' id='course' value='" + rs.getString("course") + "' style='padding: 10px; border: 1px solid #e67760; border-radius: 5px;'>"

                        + "<label for='dob' style='margin: 10px 0 5px; color: #e67760;'>Date of Birth:</label>"
                        + "<input type='date' name='dob' id='dob' value='" + rs.getString("dob") + "' style='padding: 10px; border: 1px solid #e67760; border-radius: 5px;'>"

                        + "<label for='aadharnumber' style='margin: 10px 0 5px; color: #e67760;'>Aadhar Number:</label>"
                        + "<input type='text' name='aadharnumber' id='aadharnumber' value='" + rs.getString("aadharnumber") + "' style='padding: 10px; border: 1px solid #e67760; border-radius: 5px;'>"

                        + "<label for='bloodgroup' style='margin: 10px 0 5px; color: #e67760;'>Blood Group:</label>"
                        + "<input type='text' name='bloodgroup' id='bloodgroup' value='" + rs.getString("bloodgroup") + "' style='padding: 10px; border: 1px solid #e67760; border-radius: 5px;'>"

                        + "<label for='phonenumber' style='margin: 10px 0 5px; color: #e67760;'>Phone Number:</label>"
                        + "<input type='text' name='phonenumber' id='phonenumber' value='" + rs.getString("phonenumber") + "' style='padding: 10px; border: 1px solid #e67760; border-radius: 5px;'>"

                        + "<label for='email' style='margin: 10px 0 5px; color: #e67760;'>Email:</label>"
                        + "<input type='email' name='email' id='email' value='" + rs.getString("email") + "' style='padding: 10px; border: 1px solid #e67760; border-radius: 5px;'>"

                        + "<label for='address' style='margin: 10px 0 5px; color: #e67760;'>Address:</label>"
                        + "<input type='text' name='address' id='address' value='" + rs.getString("address") + "' style='padding: 10px; border: 1px solid #e67760; border-radius: 5px;'>"

                        + "<label for='batch' style='margin: 10px 0 5px; color: #e67760;'>Batch:</label>"
                        + "<input type='text' name='batch' id='batch' value='" + rs.getString("batch") + "' style='padding: 10px; border: 1px solid #e67760; border-radius: 5px;'>"

                        + "<label for='aboutyou' style='margin: 10px 0 5px; color: #e67760;'>About You:</label>"
                        + "<textarea name='aboutyou' id='aboutyou' style='padding: 10px; border: 1px solid #e67760; border-radius: 5px;'>" + rs.getString("aboutyou") + "</textarea>"

                        + "<label for='picture' style='margin: 10px 0 5px; color: #e67760;'>Picture:</label>"
                        + "<input type='file' name='picture' id='picture' style='padding: 10px; border: 1px solid #e67760; border-radius: 5px;'>"

                        + "<label for='password' style='margin: 10px 0 5px; color: #e67760;'>Password:</label>"
                        + "<input type='password' name='password' id='password' value='" + rs.getString("password") + "' style='padding: 10px; border: 1px solid #e67760; border-radius: 5px;'>"

                        + "<label for='confirmpassword' style='margin: 10px 0 5px; color: #e67760;'>Confirm Password:</label>"
                        + "<input type='password' name='confirmpassword' id='confirmpassword' value='" + rs.getString("confirmpassword") + "' style='padding: 10px; border: 1px solid #e67760; border-radius: 5px;'>"

                        + "<label for='usertype' style='margin: 10px 0 5px; color: #e67760;'>User Type:</label>"
                        + "<input type='text' name='usertype' id='usertype' value='" + rs.getString("usertype") + "' style='padding: 10px; border: 1px solid #e67760; border-radius: 5px;'>"

                        + "<button type='submit' style='background-color: #e67760; color: white; border: none; padding: 10px; margin: 10px 0; border-radius: 5px; cursor: pointer;'>Update</button>"
                        + "<button type='button' style='background-color: #ccc; color: #333; border: none; padding: 10px; margin: 10px 0; border-radius: 5px; cursor: pointer;' onclick=\"window.location.href='alumni_list.jsp'\">Cancel</button>"
                        + "</form></main></section></body></html>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

