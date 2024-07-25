package alumni;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/UpdateAlumni")
@MultipartConfig
public class UpdateAlumni extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String regdno = request.getParameter("regdno");
        String fullname = request.getParameter("fullname");
        String gender = request.getParameter("gender");
        String course = request.getParameter("course");
        String dob = request.getParameter("dob");
        String aadharnumber = request.getParameter("aadharnumber");
        String bloodgroup = request.getParameter("bloodgroup");
        String phonenumber = request.getParameter("phonenumber");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String batch = request.getParameter("batch");
        String aboutyou = request.getParameter("aboutyou");
        String password = request.getParameter("password");
        String confirmpassword = request.getParameter("confirmpassword");
        String usertype = request.getParameter("usertype");
        Part imagePart = request.getPart("picture");

        String imageFileName = null;
        if (imagePart != null && imagePart.getSize() > 0) {
            imageFileName = imagePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("") + File.separator + "assets/uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            File file = new File(uploadDir, imageFileName);
            Files.copy(imagePart.getInputStream(), file.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_db", "root", "")) {
            String sql = imageFileName != null ? 
                "UPDATE alumnus_bio SET regdno = ?, fullname = ?, gender = ?, course = ?, dob = ?, aadharnumber = ?, bloodgroup = ?, phonenumber = ?, email = ?, address = ?, batch = ?, aboutyou = ?, picture = ?, password = ?, confirmpassword = ?, usertype = ? WHERE id = ?" :
                "UPDATE alumnus_bio SET regdno = ?, fullname = ?, gender = ?, course = ?, dob = ?, aadharnumber = ?, bloodgroup = ?, phonenumber = ?, email = ?, address = ?, batch = ?, aboutyou = ?, password = ?, confirmpassword = ?, usertype = ? WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, regdno);
                stmt.setString(2, fullname);
                stmt.setString(3, gender);
                stmt.setString(4, course);
                stmt.setString(5, dob);
                stmt.setString(6, aadharnumber);
                stmt.setString(7, bloodgroup);
                stmt.setString(8, phonenumber);
                stmt.setString(9, email);
                stmt.setString(10, address);
                stmt.setString(11, batch);
                stmt.setString(12, aboutyou);
                if (imageFileName != null) {
                    stmt.setString(13, imageFileName);
                    stmt.setString(14, password);
                    stmt.setString(15, confirmpassword);
                    stmt.setString(16, usertype);
                    stmt.setInt(17, id);
                } else {
                    stmt.setString(13, password);
                    stmt.setString(14, confirmpassword);
                    stmt.setString(15, usertype);
                    stmt.setInt(16, id);
                }

                int rows = stmt.executeUpdate();
                if (rows > 0) {
                    response.sendRedirect("alumni_list.jsp");
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
