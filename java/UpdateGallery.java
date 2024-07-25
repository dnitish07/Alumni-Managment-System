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

@WebServlet("/UpdateGallery")
@MultipartConfig
public class UpdateGallery extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String description = request.getParameter("description");
        Part imagePart = request.getPart("image");

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
            String sql = imageFileName != null ? "UPDATE photo SET image = ?, about = ? WHERE id = ?" : "UPDATE photo SET about = ? WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                if (imageFileName != null) {
                    stmt.setString(1, imageFileName);
                    stmt.setString(2, description);
                    stmt.setInt(3, id);
                } else {
                    stmt.setString(1, description);
                    stmt.setInt(2, id);
                }
                int rows = stmt.executeUpdate();
                if (rows > 0) {
                    response.sendRedirect("gallery.jsp");
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
