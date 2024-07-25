package alumni;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
//import java.sql.ResultSet;
import java.sql.ResultSet;

/**
 * Servlet implementation class Login2
 */
@MultipartConfig
@WebServlet("/Registration")
public class Registration extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Part file = request.getPart("picture");
		String picture = file.getSubmittedFileName();
		String uploadPath = "C:/Users/dniti/project/alumni/src/main/webapp/assets/uploads/" + picture;

		try {
			FileOutputStream fos = new FileOutputStream(uploadPath);
			InputStream is = file.getInputStream();
			byte[] data = new byte[is.available()];
			is.read(data);
			fos.write(data);
			fos.close();
		} catch (Exception e) {
		}

		try {
			//PrintWriter out = response.getWriter();
			Connection con = DBConnect.connect();

			PreparedStatement st = con.prepareStatement(
					"insert into  alumnus_bio (fullname,email,password,dob,address,gender,aboutyou,regdno,phonenumber,confirmpassword,course,batch,bloodgroup,usertype,aadharnumber,picture) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			st.setString(1, request.getParameter("fullname"));
			st.setString(2, request.getParameter("email"));
			st.setString(3, request.getParameter("password"));
			st.setString(4, request.getParameter("dob"));
			st.setString(5, request.getParameter("address"));
			st.setString(6, request.getParameter("gender"));
			st.setString(7, request.getParameter("aboutyou"));
			st.setString(8, request.getParameter("regdno"));
			st.setString(9, request.getParameter("phonenumber"));
			st.setString(10, request.getParameter("confirmpassword"));
			st.setString(11, request.getParameter("course"));
			st.setString(12, request.getParameter("batch"));
			st.setString(13, request.getParameter("bloodgroup"));
			st.setString(14, request.getParameter("usertype"));
			st.setString(15, request.getParameter("aadharnumber"));
			st.setString(16, picture);
			st.executeUpdate();

			response.sendRedirect("home.html");
		} catch (Exception e) {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.println("error " + e);

		}
	}

}
