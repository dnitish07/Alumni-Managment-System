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
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Part file=request.getPart("image");
        String inputFileName=file.getSubmittedFileName();
String uploadPath="C:/Users/dniti/project/alumni/src/main/webapp/"+inputFileName;
        
        try {
        	FileOutputStream fos=new FileOutputStream(uploadPath);
            InputStream is= file.getInputStream();
            byte[] data=new byte[is.available()];
            is.read(data);
            fos.write(data);
            fos.close();
        }catch(Exception e){}
       
        
		try {
			PrintWriter out = response.getWriter(); 
			Connection con =DBConnect.connect();

		PreparedStatement st = con.prepareStatement("insert into  registration(firstname,email,password,dob,aboutyou,lastname,phonenumber,confirmpassword,course,batch,inputFileName) values(?,?,?,?,?,?,?,?,?,?,?)");
		st.setString(1, request.getParameter("firstname"));
		st.setString(2, request.getParameter("email"));
		st.setString(3, request.getParameter("password"));
		st.setString(4, request.getParameter("dob"));
		st.setString(5, request.getParameter("aboutyou"));
		st.setString(6, request.getParameter("lastname"));
		st.setString(7, request.getParameter("phonenumber"));
		st.setString(8, request.getParameter("confirmpassword"));
		st.setString(9, request.getParameter("course"));
		st.setString(10, request.getParameter("batch"));
		st.setString(11,inputFileName);
		st.executeUpdate();
		
		
		response.setContentType("text/html");
		PreparedStatement tt = con.prepareStatement("SELECT * FROM `registration`");
		 ResultSet resultSet = tt.executeQuery();
		 out.println("<html>");
         out.println("<head>");
         out.println("<title></title>");
         out.println("<style>");
         out.println("body { font-family: 'Arial', sans-serif; background-color: #f4f4f4; }");
         out.println("table { width: 80%; border-collapse: collapse; margin: 20px auto; }");
         out.println("th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }");
         out.println("th { background-color: #4CAF50; color: white; }");
         out.println("</style>");
         out.println("</head>");
         out.println("<body>");

         out.println("<h1 style='color: #333; text-align: center;'>Alumni Details</h1>");

         out.println("<table>");
         out.println("<tr><th>firstname</th><th>email</th><th>password</th><th>dob</th><th>aboutyou</th><th>lastname</th><th>phonenumber</th><th>confirmpassword</th><th>course</th><th>batch</th><th>profile</th></tr>");

         while (resultSet.next()) {
             String firstname = resultSet.getString("firstname");
             String email = resultSet.getString("email");
             String password = resultSet.getString("password");
             String dob = resultSet.getString("dob");
             String aboutyou = resultSet.getString("aboutyou");
             String lastname = resultSet.getString("lastname");
             String phonenumber = resultSet.getString("phonenumber");
             String confirmpassword = resultSet.getString("confirmpassword");
             String course = resultSet.getString("course");
             int batch = resultSet.getInt("batch");
             String image =resultSet.getString("inputFileName");
             

             out.println("<tr>");
             out.println("<td>" + firstname + "</td>");
             out.println("<td>" + email + "</td>");
             out.println("<td>" + password + "</td>");
             out.println("<td>" + dob + "</td>");
             out.println("<td>" + aboutyou + "</td>");
             out.println("<td>" + lastname + "</td>");
             out.println("<td>" + phonenumber + "</td>");
             out.println("<td>" + confirmpassword + "</td>");
             out.println("<td>" + course + "</td>");
             out.println("<td>" + batch + "</td>");
             out.println("<td><img width='50px' height='50px'src='"+image+"'</td>");
             out.println("</tr>");
         }
         out.println("</table>");
         out.println("</body>");
         out.println("</html>");

		
			
		
		}catch(Exception e) {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.println("error " +e);
		
		}
		}

	

}
