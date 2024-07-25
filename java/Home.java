package alumni;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
//import java.text.SimpleDateFormat;
//import java.sql.*;
//import java.util.Date;

@WebServlet("/Home")
public class Home extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			PrintWriter out = response.getWriter();
			Connection con = DBConnect.connect();
			response.setContentType("text/html");
			PreparedStatement stmt = con.prepareStatement("SELECT * FROM events ORDER BY id DESC;");
			ResultSet rs = stmt.executeQuery();
			PreparedStatement stm = con.prepareStatement("SELECT * FROM events");
			ResultSet sr = stm.executeQuery();
			out.println("<html>");
			out.println("<head>");
			out.println("<title>Alumni Managment System</title>");
			out.println("<link rel=\"stylesheet\" href=\"cssfile.css\">");
			out.println("<style>");
			out.println("#profile-container {"
					+ "            position: fixed;"
					+ "            top: 0;"
					+ "            left: 0;"
					+ "            width: 100%;"
					+ "            height: 100%;"
					+ "            background-color: rgba(0, 0, 0, 0.5);"
					+ "            display: none;"
					+ "            justify-content: center;"
					+ "            align-items: center;"
					+ "            z-index: 200;"
					+ "        }"
					+ ""
					+ "        #profile-container iframe {"
					+ "            width: 50%;"
					+ "            height: 80%;"
					+ "            border: none;"
					+ "        }"
					+ ""
					+ "        .profile-button {"
					+ "            width: 85px;"
					+ "            height: 85px;"
					+ "            background-image: url('profile.jpeg');"
					+ "            background-size: cover;"
					+ "            background-position: center;"
					+ "            border-radius: 50%;"
					+ "            border: none;"
					+ "            cursor: pointer;"
					+ "        }"
					+ "");

			out.println(" .col{background-color: white; color:black;font-size: 20px;}");
			out.println(".content-section {background-size: cover; background-position: center; height: 175px;}");
			out.println(" body {font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f5f5dc;}");
			out.println(
					" #header {position:fixed; top:0; left:0; right:0; background-color: white; color: #fff; padding: 10px; display: flex; justify-content: space-between; align-items: center; z-index:100;}");
			out.println(
					" #header h1 {color: grey; margin: 0px; font-size: 30px; position: fixed; top: 35px; left: 200px;}");

			out.println(
					"  #logo {width: 170px; height: 115px; background-image: url('logo.png'); background-size: cover;}");
			out.println(
					"  #alumnimeet {width: 50%; height: 60%; background-image: url('alumnimeet.jpeg'); background-size: cover;}");

			out.println(
					"  #alumnilogo {width: 170px; height: 115px; background-image: url('alumni.jpeg'); background-size: cover;}");
			out.println(" .nav-dropdown {position: relative; display: inline-block;}");

			out.println(
					"  .nav-dropdown-content {display: none;background-image:url('success_stories.jpg');background-repeat: no-repeat;background-position: buttom;color:rgba(232,97,0); position: absolute;min-width: 205px; box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); z-index: 1; text-align: left;}");

			out.println(
					"  .nav-dropdown-content a {padding: 10px; display: block; font-size: 20px; text-decoration: none;color: #e86100;}");

			out.println(" .nav-dropdown:hover .nav-dropdown-content {display: block;}");
			out.println(
					" .navbar {position: fixed; top: 130px; left: 0; right: 0; background-color: #e86100; padding: 20px 0; display: flex; justify-content: center; z-index: 100;}");

			out.println(" .navbar .nav-dropdown {margin-left: 0px; margin-right:20px;}");
			out.println(
					" .registration-button {background-color: white; color: #e86100; border: none; padding: 10px 20px; font-size: 18px; cursor: pointer; margin-right: -1070px;}");
			out.println(
					" .login-button {background-color: white; color: #e86100; border: none; padding: 10px 20px; font-size: 18px; cursor: pointer; margin-right: 20px;}");
			out.println(
					" .center-division a:link {color: white; background-color: transparent; text-decoration: none;}");
			// out.println(" .center-division a:visited {color:blue; background-color:
			// transparent; text-decoration: none;}");
			out.println(
					" .center-division a:hover {color: red; background-color: transparent; text-decoration: underline;}");
			out.println(
					" .center-division a:active {color: yellow; background-color: transparent; text-decoration: underline;}");
			out.println(" footer {background-color: #333; padding: 20px 0; color: #fff;}");
			out.println(" span{color: white; font-size: 17.5px;}");
			out.println(" .left-division {margin-left: 30px; height:100px;align-content: absolute; }");
			out.println(" .left-division p{margin: 0 10px;}");
			out.println(" .clear{clear:both;}");

			out.println(" .right-division {margin-left: 1300px; margin-top:-150px; height:100px; }");

			/* Style for the center division */
			out.println(" .center-division {text-align: center; margin-right:10px; font-size: larger;}");
			out.println(" .center-division a{margin: 0 10px;}");
			out.println(
					" .events{width:50%; margin: 10px; margin-left:100px; margin-top: 20px; padding-left: 20px; padding-top: 10px;}");
			out.println(
					" .news{width:40%; margin: 10px; margin-left: 850px; margin-top: -325px; padding-left: 20px; padding-top: 10px;}");
			out.println("</style>");
			out.println("</head>");
			out.println("<body>");
			out.println("<header id='header'>");

			out.println("<div id='logo'></div>");

			out.println("<h1>Alumni<br>Managment System</h1>");
			//out.println("<form action='login.html'>");
			out.println(
					"<button class='profile-button' id='profile-button' onclick='openProfile()'></button>");
			//out.println("Student<br>Profile");
					//+ "</form>");
			out.println("</header>");
			out.println("<div class='navbar'>");
			out.println("<div class=\"nav-dropdown\">");
			out.println("<span>About</span>");
			out.println("<div class=\"nav-dropdown-content\">");
			out.println("<a href=\"alumni.jsp\">Alumni</a>");
			//out.println("<a href=\"careers.jsp\">Opportunities</a>");
			out.println("<a href=\"boardmembers.html\">Board Members</a>");
			out.println("</div></div>");

			out.println("<div class=\"nav-dropdown\">");
			out.println("<span>Events</span>");
			out.println("<div class=\"nav-dropdown-content\">");
			out.println("<a href=\"event.jsp\">All Events </a>");
			out.println("</div></div>");

			

			out.println("<div class=\"nav-dropdown\">");
			out.println("<span>Gallery</span>");
			out.println("<div class=\"nav-dropdown-content\">");
			out.println("<a href=\"images.html\">Album</a>");
			out.println("<a href=\"videos.html\">Videos</a>");
			
			out.println("</div></div>");

			out.println("<div class=\"nav-dropdown\">");
			out.println("<span>Assist</span>");
			out.println("<div class=\"nav-dropdown-content\">");
			//out.println("<a href=\"query.html\">Send a query</a>");
			out.println("<a href=\"feedback.jsp\">Feedback</a>");
			out.println(
					"<a href=\"https://instagram.com/alumni_vvit?igshid=MzRlODBiNWFlZA==\" target=\"_blank\">Instagram page</a>");
			out.println("</div></div>");

			out.println("<div class=\"nav-dropdown\">");
			out.println("<span>Engage</span>");
			out.println("<div class=\"nav-dropdown-content\">");
			//out.println("<a href=\"volunteer.html\">Volunteer</a>");
			out.println("<a href=\"mentor.jsp\">Be a mentor</a>");
			out.println(" <a href=\"careers.jsp\">Share opportunities</a>");
			//out.println(" <a href=\"achievementform.html\">Share Achievements</a>");
			out.println("</div></div>");

			out.println("<div class=\"nav-dropdown\">");
			out.println("<span>More</span>");
			out.println("<div class=\"nav-dropdown-content\">");
			out.println("<a href=\"contact.jsp\">Contact us</a>");
			out.println("<a href=\"communities.jsp\">Join a community</a>");
			out.println("</div></div></div>");
			
			out.println("<div class=\"content-section\">"
					+"<div id=\"profile-container\"></div>");
			out.println("<div id=\"login-form-container\"></div></div>");
			out.println("<div class=\"slider\">\r\n" + "		<div class=\"myslide fade\">\r\n"
					+ "			<div class=\"txt\">\r\n" + "				<h1>Welcome</h1>\r\n"
					+ "				<p>To official Network of Alumni Managment System</p>\r\n" + "			</div>\r\n"
					+ "			<img src=\"img001.jpg\" style=\"width: 100%; height: 100%;\">\r\n" + "		</div>\r\n"
					+ "		<div class=\"myslide fade\">\r\n" + "			<div class=\"txt\">\r\n"
					+ "				<h1>Welcome</h1>\r\n"
					+ "				<p>To official Network of Alumni Managment System</p>\r\n" + "			</div>\r\n"
					+ "			<img src=\"img02.webp\" style=\"width: 100%; height: 100%;\">\r\n" + "		</div>\r\n"
					+ "		<div class=\"myslide fade\">\r\n" + "			<div class=\"txt\">\r\n"
					+ "				<h1>Welcome</h1>\r\n"
					+ "				<p>To official Network of Alumni Managment System</p>\r\n" + "			</div>\r\n"
					+ "			<img src=\"img0003.webp\" style=\"width: 100%; height: 100%;\">\r\n"
					+ "		</div>\r\n" + "		<div class=\"myslide fade\">\r\n" + "			<div class=\"txt\">\r\n"
					+ "				<h1>Welcome</h1>\r\n"
					+ "				<p>To official Network of Alumni Managment System</p>\r\n" + "			</div>\r\n"
					+ "			<img src=\"image04.webp\" style=\"width: 100%; height: 100%;\">\r\n"
					+ "		</div>\r\n" + "		<div class=\"myslide fade\">\r\n" + "			<div class=\"txt\">\r\n"
					+ "				<h1>Welcome</h1>\r\n"
					+ "				<p>To official Network of Alumni Managment System</p>\r\n" + "			</div>\r\n"
					+ "			<img src=\"img01.jpg\" style=\"width: 100%; height: 100%;\">\r\n" + "		</div>\r\n"
					+ "		<a class=\"prev\" onclick=\"plusSlides(-1)\">&#10094;</a>\r\n"
					+ "  		<a class=\"next\" onclick=\"plusSlides(1)\">&#10095;</a>\r\n"
					+ "		<div class=\"dotsbox\" style=\"text-align:center\">\r\n"
					+ "			<span class=\"dot\" onclick=\"currentSlide(1)\"></span>\r\n"
					+ "			<span class=\"dot\" onclick=\"currentSlide(2)\"></span>\r\n"
					+ "			<span class=\"dot\" onclick=\"currentSlide(3)\"></span>\r\n"
					+ "			<span class=\"dot\" onclick=\"currentSlide(4)\"></span>\r\n"
					+ "			<span class=\"dot\" onclick=\"currentSlide(5)\"></span>\r\n" + "		</div>\r\n"
					+ "	</div>\r\n" + "<script src=\"jsfile.js\"></script>");
			out.println("<style>");
			out.println(".container { display: flex; justify-content: space-around; }"); // Flexbox setup for container
			out.println(
					".events, .news { flex: 1; margin: 10px; background-color: #f3f3f3; padding: 20px; border-radius: 10px; }");
			out.println(
					".header { background-color:white; font-size: 30px; color: #e86100; padding: 10px; text-align: center; }");
			out.println(
					".readmore { background-color: #e86100; color: white; border: none; padding: 10px; cursor: pointer; border-radius: 5px; }");
			out.println(".readmore:hover { background-color: #d05000; }");
			out.println(".alumnimeet, .footer { margin: 10px; padding: 20px; border-radius: 10px; }");
			out.println(".alumnimeet { background-color: #e86100; color: white; }");
			out.println(
					".footer { background-color: black; color: white; display: flex; flex-direction: column; align-items: center; }");
			out.println(".footer p, .footer div { margin: 5px 0; text-align: center; }");
			out.println(
					".right-division, .center-division { display: flex; justify-content: center; align-items: center; flex-direction: column; }");
			out.println(".center-division a { margin: 0 5px; color: white; text-decoration: none; }");
			out.println(".center-division a:hover { text-decoration: underline; }");
			out.println("</style>");

			out.println("<div class='container'>");

			// Events Section
			out.println("<div class='events'>");
			out.println("<h1 class='header'>Upcoming Events</h1>");

			while (rs.next()) {
				String title = rs.getString("title").toUpperCase();
				String schedule = rs.getString("schedule");
				String content = rs.getString("content");
				out.println("<div class='col'>");
				out.println("<br>");
				out.println("<p>" + title + "</p>");
				out.println("<p style='color: #e86100;'>" + schedule + "</p>");
				out.println("<p>" + content + "</p>");
				out.println("<form action='ReadMore' method='post'>"
						+ "<button class=\"readmore\" id=\"readmore\">Read More</button>" + "</form>");
				out.println("<br>");
				out.println("</div>");
			}
			out.println("</div>");

			// News Section
			out.println("<div class='news'>");
			out.println("<h1 class='header'>News Letter</h1>");

			while (sr.next()) {
				String title = sr.getString("title").toUpperCase();
				String schedule = sr.getString("schedule");
				String content = sr.getString("content");
				out.println("<div class='col'>");
				out.println("<br>");
				out.println("<p>" + title + "</p>");
				out.println("<p style='color: #e86100;'>" + schedule + "</p>");
				out.println("<p>" + content + "</p>");
				out.println("<form action='ReadMore' method='post'>"
						+ "<button class=\"readmore\" id=\"readmore\">Read More</button>" + "</form>");
				out.println("<br>");
				out.println("</div>");
			}
			out.println("</div>");

			out.println("</div>"); // Close container

			// Alumnimeet section
			out.println(
					"<div style='display: flex; align-items: stretch; background-color: #f2f2f2; padding: 20px; border-radius: 10px;'>");

			// Alumnimeet section (text)
			out.println(
					"<div style='flex: 2; background-color: #e86100; color: white; font-size: 20px; padding: 20px; box-sizing: border-box; border-top-left-radius: 10px; border-bottom-left-radius: 10px; display: flex; flex-direction: column; justify-content: center;'>");
			out.println("<p style='margin-bottom: 20px;'><strong>The Reunite Program</strong></p>");
			out.println(
					"<p>Hello everyone! Welcome to Alumni Connect, the website of VVIT Alumni Management System Project. The VVIT has had the proud privilege to have served as an incubation space for your promising young selves. As you bid farewell to us and embark on fresh adventures, we wish to help retain memories of this place that once constituted your training ground---your playing field. Alumni Connect hopes to function as a forum where all members of VVIT Alumni Association can pick up where they left off, reconnect with peers and faculty, and continually renew their bond with their alma mater. Let’s Reconnect, Recreate and Represent VVIT in all its glory to scale further heights.</p>");
			out.println(
					"<p>Connect today<br>Transform tomorrow<br>it's not just our mission<br>it's our wish for you</p>");
			out.println("</div>");

			// Image next to alumnimeet
			out.println(
					"<div style='flex: 1; background-image: url(\"alumnimeet.jpeg\"); background-size: cover; background-position: center; border-top-right-radius: 10px; border-bottom-right-radius: 10px;'>");
			out.println("</div>");

			out.println("</div>"); // End of flex container
// End of flex container

			// Footer Section
			out.println("<div class='footer'>" + "<p>ADDRESS<br>" + "Vasireddy Venkatadri Institute of Technology<br>"
					+ "Nambur (V)<br>" + "Peda Kakani (Md)<br>" + "Guntur (Dt)<br>" + "Andhra Pradesh<br>"
					+ "522508 </p>" + "<div class='right-division'>" + "<p>CONTACT<br>" + "9951 023 336<br>"
					+ "9849 542 336<br>" + "9849 549 336<br>" + "</p></div>" + "<div class='center-division'>"
					+ "<a href='#'>Home</a>" + "<a href='#'>About</a>" + "<a href='#'>Services</a>"
					+ "<a href='#'>Contact</a>"
					+ "<a href='https://instagram.com/alumni_vvit?igshid=MzRlODBiNWFlZA==' target='_blank'>"
					+ "<img src='instalogo.jpg' alt='alumni-instagram' width='50px' height='35px'>" + "</a>" + "</div>"
					+ "</div>");

			/*
			 * out.println("<footer>"); out.println("<div class=\"left-division\">");
			 * out.println("<p>ADDRESS<br>" +
			 * "            Vasireddy Venkatadri Institute of Technology<br>\r\n" +
			 * "            Nambur (V)<br>\r\n" + "            Peda Kakani (Md)<br>\r\n" +
			 * "            Guntur (Dt)<br>\r\n" + "            Andhra Pradesh<br>\r\n" +
			 * "            522508 </p></div>");
			 * out.println("<div class=\"right-division\">"); out.println("<p>CONTACT<br>" +
			 * "                9951 023 336<br>\r\n" +
			 * "                9849 542 336<br>\r\n" +
			 * "                9849 549 336<br>\r\n" + "            </p></div>");
			 * out.println("<div class=\"center-division clear\">\r\n" +
			 * "        <a href=\"#\">Home</a>\r\n" + "        <a href=\"#\">About</a>\r\n"
			 * + "        <a href=\"#\">Services</a>\r\n" +
			 * "        <a href=\"#\">Contact</a>\r\n" +
			 * "        <a href=\"https://instagram.com/alumni_vvit?igshid=MzRlODBiNWFlZA==\" target=\"_blank\">\r\n"
			 * +
			 * "            <img src=\"instalogo.jpg\" alt=\"alumni-instagram\" width=\"50px\" height=\"50px\">\r\n"
			 * + "            </a>\r\n" + "    \r\n" + "    </div>\r\n" + "</footer>");
			 */
			/*
			 * out.println("<script>"); out.println("function openLoginForm() {"); out.
			 * println("var container = document.getElementById(\"login-form-container\");"
			 * ); out.println("var body = document.getElementById(\"main-body\");");
			 * out.println("var existingIframe = container.querySelector(\"iframe\");");
			 * out.println("if (existingIframe) {");
			 * out.println("container.removeChild(existingIframe);");
			 * out.println("body.style.overflow = \"auto\";"); out.println("} else {");
			 * out.println("var iframe = document.createElement(\"iframe\");");
			 * out.println("iframe.src = \"login.html\";");
			 * out.println("iframe.style.width = \"40%\";");
			 * out.println("iframe.style.height = \"450px\";");
			 * out.println("iframe.style.position = \"absolute\";");
			 * out.println("iframe.style.top = \"60%\";");
			 * out.println("iframe.style.left = \"50%\";");
			 * out.println("iframe.style.transform = \"translate(-50%, -50%)\";");
			 * out.println("container.appendChild(iframe);");
			 * out.println("body.style.overflow = \"hidden\";\r\n" + "        }\r\n" +
			 * "    }"); out.println("</script>");
			 * out.println("function openRegistrationForm() {");
			 * 
			 * out.println("<script>");
			 * 
			 * out.println("</script>");
			 */
			out.println("<script>"
				    + "function openProfile() {"
				    + "    var container = document.getElementById(\"profile-container\");"
				    + "    var body = document.body;"
				    + "    var existingIframe = container.querySelector(\"iframe\");"
				    + ""
				    + "    if (existingIframe) {"
				    + "        container.style.display = \"none\";"
				    + "        container.removeChild(existingIframe);"
				    + "        body.style.overflow = \"auto\";"
				    + "    } else {"
				    + "        var iframe = document.createElement(\"iframe\");"
				    + "        iframe.src = \"profile.jsp\";"
				    + "        container.appendChild(iframe);"
				    + "        container.style.display = \"flex\";"
				    + "        body.style.overflow = \"hidden\";"
				    + "    }"
				   
				    + "}"
				    
				    + "</script>");
			out.println("</body>");
			
			out.println("</html>");

		} catch (Exception e) {
			PrintWriter out = response.getWriter();
			e.printStackTrace();
			out.println("An error occurred!" + e);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			PrintWriter out = response.getWriter();
			Connection con = DBConnect.connect();
			response.setContentType("text/html");
			PreparedStatement stmt = con.prepareStatement("SELECT * FROM events");
			ResultSet rs = stmt.executeQuery();
			PreparedStatement stm = con.prepareStatement("SELECT * FROM events");
			ResultSet sr = stm.executeQuery();
			out.println("<html>");
			out.println("<head>");
			out.println("<title>Alumni Managment System</title>");
			out.println("<link rel=\"stylesheet\" href=\"cssfile.css\">");
			out.println("<style>");
			out.println("#profile-container {\r\n"
					+ "            position: fixed;\r\n"
					+ "            top: 0;\r\n"
					+ "            left: 0;\r\n"
					+ "            width: 100%;\r\n"
					+ "            height: 100%;\r\n"
					+ "            background-color: rgba(0, 0, 0, 0.5);\r\n"
					+ "            display: none;\r\n"
					+ "            justify-content: center;\r\n"
					+ "            align-items: center;\r\n"
					+ "            z-index: 200;\r\n"
					+ "        }\r\n"
					+ "\r\n"
					+ "        #profile-container iframe {\r\n"
					+ "            width: 50%;\r\n"
					+ "            height: 80%;\r\n"
					+ "            border: none;\r\n"
					+ "        }\r\n"
					+ "\r\n"
					+ "        .profile-button {\r\n"
					+ "            width: 50px;\r\n"
					+ "            height: 50px;\r\n"
					+ "            background-image: url('profile.jpeg');\r\n"
					+ "            background-size: cover;\r\n"
					+ "            background-position: center;\r\n"
					+ "            border-radius: 50%;\r\n"
					+ "            border: none;\r\n"
					+ "            cursor: pointer;\r\n"
					+ "        }\r\n"
					+ "");

			out.println(" .col{background-color: white; color:black;font-size: 20px;}");
			out.println(".content-section {background-size: cover; background-position: center; height: 175px;}");
			out.println(" body {font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f5f5dc;}");
			out.println(
					" #header {position:fixed; top:0; left:0; right:0; background-color: white; color: #fff; padding: 10px; display: flex; justify-content: space-between; align-items: center; z-index:100;}");
			out.println(
					" #header h1 {color: grey; margin: 0px; font-size: 30px; position: fixed; top: 35px; left: 200px;}");

			out.println(
					"  #logo {width: 170px; height: 115px; background-image: url('logo.png'); background-size: cover;}");
			out.println(
					"  #alumnimeet {width: 50%; height: 60%; background-image: url('alumnimeet.jpeg'); background-size: cover;}");

			out.println(
					"  #alumnilogo {width: 170px; height: 115px; background-image: url('alumni.jpeg'); background-size: cover;}");
			out.println(" .nav-dropdown {position: relative; display: inline-block;}");

			out.println(
					"  .nav-dropdown-content {display: none;background-image:url('success_stories.jpg');background-repeat: no-repeat;background-position: buttom;color:rgba(232,97,0); position: absolute;min-width: 205px; box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); z-index: 1; text-align: left;}");

			out.println(
					"  .nav-dropdown-content a {padding: 10px; display: block; font-size: 20px; text-decoration: none;color: #e86100;}");

			out.println(" .nav-dropdown:hover .nav-dropdown-content {display: block;}");
			out.println(
					" .navbar {position: fixed; top: 130px; left: 0; right: 0; background-color: #e86100; padding: 20px 0; display: flex; justify-content: center; z-index: 100;}");

			out.println(" .navbar .nav-dropdown {margin-left: 0px; margin-right:20px;}");
			out.println(
					" .registration-button {background-color: white; color: #e86100; border: none; padding: 10px 20px; font-size: 18px; cursor: pointer; margin-right: -1070px;}");
			out.println(
					" .login-button {background-color: white; color: #e86100; border: none; padding: 10px 20px; font-size: 18px; cursor: pointer; margin-right: 20px;}");
			out.println(
					" .center-division a:link {color: white; background-color: transparent; text-decoration: none;}");
			// out.println(" .center-division a:visited {color:blue; background-color:
			// transparent; text-decoration: none;}");
			out.println(
					" .center-division a:hover {color: red; background-color: transparent; text-decoration: underline;}");
			out.println(
					" .center-division a:active {color: yellow; background-color: transparent; text-decoration: underline;}");
			out.println(" footer {background-color: #333; padding: 20px 0; color: #fff;}");
			out.println(" span{color: white; font-size: 17.5px;}");
			out.println(" .left-division {margin-left: 30px; height:100px;align-content: absolute; }");
			out.println(" .left-division p{margin: 0 10px;}");
			out.println(" .clear{clear:both;}");

			out.println(" .right-division {margin-left: 1300px; margin-top:-150px; height:100px; }");

			/* Style for the center division */
			out.println(" .center-division {text-align: center; margin-right:10px; font-size: larger;}");
			out.println(" .center-division a{margin: 0 10px;}");
			out.println(
					" .events{width:50%; margin: 10px; margin-left:100px; margin-top: 20px; padding-left: 20px; padding-top: 10px;}");
			out.println(
					" .news{width:40%; margin: 10px; margin-left: 850px; margin-top: -325px; padding-left: 20px; padding-top: 10px;}");
			out.println("</style>");
			out.println("</head>");
			out.println("<body>");
			out.println("<header id='header'>");

			out.println("<div id='logo'></div>");

			out.println("<h1>Alumni<br>Managment System</h1>");
			//out.println("<form action='login.html'>");
			out.println(
					"<button class='profile-button' id='profile-button' onclick='openProfile()'></button>");
					//+ "</form>");
			out.println("</header>");
			out.println("<div class='navbar'>");
			out.println("<div class=\"nav-dropdown\">");
			out.println("<span>About</span>");
			out.println("<div class=\"nav-dropdown-content\">");
			out.println("<a href=\"alumni.jsp\">Alumni</a>");
			//out.println("<a href=\"careers.jsp\">Opportunities</a>");
			out.println("<a href=\"boardmembers.html\">Board Members</a>");
			out.println("</div></div>");

			out.println("<div class=\"nav-dropdown\">");
			out.println("<span>Events</span>");
			out.println("<div class=\"nav-dropdown-content\">");
			out.println("<a href=\"event.jsp\">All Events </a>");
			out.println("</div></div>");

			

			out.println("<div class=\"nav-dropdown\">");
			out.println("<span>Gallery</span>");
			out.println("<div class=\"nav-dropdown-content\">");
			out.println("<a href=\"images.html\">Album</a>");
			out.println("<a href=\"videos.html\">Videos</a>");
			
			out.println("</div></div>");

			out.println("<div class=\"nav-dropdown\">");
			out.println("<span>Assist</span>");
			out.println("<div class=\"nav-dropdown-content\">");
			out.println("<a href=\"query.html\">Send a query</a>");
			out.println("<a href=\"feedbackform.html\">Feedback</a>");
			out.println(
					"<a href=\"https://instagram.com/alumni_vvit?igshid=MzRlODBiNWFlZA==\" target=\"_blank\">Instagram page</a>");
			out.println("</div></div>");

			out.println("<div class=\"nav-dropdown\">");
			out.println("<span>Engage</span>");
			out.println("<div class=\"nav-dropdown-content\">");
			//out.println("<a href=\"volunteer.html\">Volunteer</a>");
			out.println("<a href=\"mentor.html\">Be a mentor</a>");
			out.println(" <a href=\"careers.jsp\">Share opportunities</a>");
			//out.println(" <a href=\"achievementform.html\">Share Achievements</a>");
			out.println("</div></div>");

			out.println("<div class=\"nav-dropdown\">");
			out.println("<span>More</span>");
			out.println("<div class=\"nav-dropdown-content\">");
			out.println("<a href=\"contact.html\">Contact us</a>");
			out.println("<a href=\"community.html\">Join a community</a>");
			out.println("</div></div></div>");
			out.println("<div class=\"content-section\">");
			out.println("<div id=\"login-form-container\"></div></div>");
			out.println("<div class=\"slider\">\r\n" + "		<div class=\"myslide fade\">\r\n"
					+ "			<div class=\"txt\">\r\n" + "				<h1>Welcome</h1>\r\n"
					+ "				<p>To official Network of Alumni Managment System</p>\r\n" + "			</div>\r\n"
					+ "			<img src=\"img001.jpg\" style=\"width: 100%; height: 100%;\">\r\n" + "		</div>\r\n"
					+ "		<div class=\"myslide fade\">\r\n" + "			<div class=\"txt\">\r\n"
					+ "				<h1>Welcome</h1>\r\n"
					+ "				<p>To official Network of Alumni Managment System</p>\r\n" + "			</div>\r\n"
					+ "			<img src=\"img02.webp\" style=\"width: 100%; height: 100%;\">\r\n" + "		</div>\r\n"
					+ "		<div class=\"myslide fade\">\r\n" + "			<div class=\"txt\">\r\n"
					+ "				<h1>Welcome</h1>\r\n"
					+ "				<p>To official Network of Alumni Managment System</p>\r\n" + "			</div>\r\n"
					+ "			<img src=\"img0003.webp\" style=\"width: 100%; height: 100%;\">\r\n"
					+ "		</div>\r\n" + "		<div class=\"myslide fade\">\r\n" + "			<div class=\"txt\">\r\n"
					+ "				<h1>Welcome</h1>\r\n"
					+ "				<p>To official Network of Alumni Managment System</p>\r\n" + "			</div>\r\n"
					+ "			<img src=\"image04.webp\" style=\"width: 100%; height: 100%;\">\r\n"
					+ "		</div>\r\n" + "		<div class=\"myslide fade\">\r\n" + "			<div class=\"txt\">\r\n"
					+ "				<h1>Welcome</h1>\r\n"
					+ "				<p>To official Network of Alumni Managment System</p>\r\n" + "			</div>\r\n"
					+ "			<img src=\"img01.jpg\" style=\"width: 100%; height: 100%;\">\r\n" + "		</div>\r\n"
					+ "		<a class=\"prev\" onclick=\"plusSlides(-1)\">&#10094;</a>\r\n"
					+ "  		<a class=\"next\" onclick=\"plusSlides(1)\">&#10095;</a>\r\n"
					+ "		<div class=\"dotsbox\" style=\"text-align:center\">\r\n"
					+ "			<span class=\"dot\" onclick=\"currentSlide(1)\"></span>\r\n"
					+ "			<span class=\"dot\" onclick=\"currentSlide(2)\"></span>\r\n"
					+ "			<span class=\"dot\" onclick=\"currentSlide(3)\"></span>\r\n"
					+ "			<span class=\"dot\" onclick=\"currentSlide(4)\"></span>\r\n"
					+ "			<span class=\"dot\" onclick=\"currentSlide(5)\"></span>\r\n" + "		</div>\r\n"
					+ "	</div>\r\n" + "<script src=\"jsfile.js\"></script>");
			out.println("<style>");
			out.println(".container { display: flex; justify-content: space-around; }"); // Flexbox setup for container
			out.println(
					".events, .news { flex: 1; margin: 10px; background-color: #f3f3f3; padding: 20px; border-radius: 10px; }");
			out.println(
					".header { background-color:white; font-size: 30px; color: #e86100; padding: 10px; text-align: center; }");
			out.println(
					".readmore { background-color: #e86100; color: white; border: none; padding: 10px; cursor: pointer; border-radius: 5px; }");
			out.println(".readmore:hover { background-color: #d05000; }");
			out.println(".alumnimeet, .footer { margin: 10px; padding: 20px; border-radius: 10px; }");
			out.println(".alumnimeet { background-color: #e86100; color: white; }");
			out.println(
					".footer { background-color: black; color: white; display: flex; flex-direction: column; align-items: center; }");
			out.println(".footer p, .footer div { margin: 5px 0; text-align: center; }");
			out.println(
					".right-division, .center-division { display: flex; justify-content: center; align-items: center; flex-direction: column; }");
			out.println(".center-division a { margin: 0 5px; color: white; text-decoration: none; }");
			out.println(".center-division a:hover { text-decoration: underline; }");
			out.println("</style>");

			out.println("<div class='container'>");

			// Events Section
			out.println("<div class='events'>");
			out.println("<h1 class='header'>Upcoming Events</h1>");

			while (rs.next()) {
				String title = rs.getString("title").toUpperCase();
				String schedule = rs.getString("schedule");
				String content = rs.getString("content");
				out.println("<div class='col'>");
				out.println("<br>");
				out.println("<p>" + title + "</p>");
				out.println("<p style='color: #e86100;'>" + schedule + "</p>");
				out.println("<p>" + content + "</p>");
				out.println("<form action='ReadMore' method='post'>"
						+ "<button class=\"readmore\" id=\"readmore\">Read More</button>" + "</form>");
				out.println("<br>");
				out.println("</div>");
			}
			out.println("</div>");

			// News Section
			out.println("<div class='news'>");
			out.println("<h1 class='header'>News Letter</h1>");

			while (sr.next()) {
				String title = sr.getString("title").toUpperCase();
				String schedule = sr.getString("schedule");
				String content = sr.getString("content");
				out.println("<div class='col'>");
				out.println("<br>");
				out.println("<p>" + title + "</p>");
				out.println("<p style='color: #e86100;'>" + schedule + "</p>");
				out.println("<p>" + content + "</p>");
				out.println("<form action='ReadMore' method='post'>"
						+ "<button class=\"readmore\" id=\"readmore\">Read More</button>" + "</form>");
				out.println("<br>");
				out.println("</div>");
			}
			out.println("</div>");

			out.println("</div>"); // Close container

			// Alumnimeet section
			out.println(
					"<div style='display: flex; align-items: stretch; background-color: #f2f2f2; padding: 20px; border-radius: 10px;'>");

			// Alumnimeet section (text)
			out.println(
					"<div style='flex: 2; background-color: #e86100; color: white; font-size: 20px; padding: 20px; box-sizing: border-box; border-top-left-radius: 10px; border-bottom-left-radius: 10px; display: flex; flex-direction: column; justify-content: center;'>");
			out.println("<p style='margin-bottom: 20px;'><strong>The Reunite Program</strong></p>");
			out.println(
					"<p>Hello everyone! Welcome to Alumni Connect, the website of VVIT Alumni Management System Project. The VVIT has had the proud privilege to have served as an incubation space for your promising young selves. As you bid farewell to us and embark on fresh adventures, we wish to help retain memories of this place that once constituted your training ground---your playing field. Alumni Connect hopes to function as a forum where all members of VVIT Alumni Association can pick up where they left off, reconnect with peers and faculty, and continually renew their bond with their alma mater. Let’s Reconnect, Recreate and Represent VVIT in all its glory to scale further heights.</p>");
			out.println(
					"<p>Connect today<br>Transform tomorrow<br>it's not just our mission<br>it's our wish for you</p>");
			out.println("</div>");

			// Image next to alumnimeet
			out.println(
					"<div style='flex: 1; background-image: url(\"alumnimeet.jpeg\"); background-size: cover; background-position: center; border-top-right-radius: 10px; border-bottom-right-radius: 10px;'>");
			out.println("</div>");

			out.println("</div>"); // End of flex container
// End of flex container

			// Footer Section
			out.println("<div class='footer'>" + "<p>ADDRESS<br>" + "Vasireddy Venkatadri Institute of Technology<br>"
					+ "Nambur (V)<br>" + "Peda Kakani (Md)<br>" + "Guntur (Dt)<br>" + "Andhra Pradesh<br>"
					+ "522508 </p>" + "<div class='right-division'>" + "<p>CONTACT<br>" + "9951 023 336<br>"
					+ "9849 542 336<br>" + "9849 549 336<br>" + "</p></div>" + "<div class='center-division'>"
					+ "<a href='#'>Home</a>" + "<a href='#'>About</a>" + "<a href='#'>Services</a>"
					+ "<a href='#'>Contact</a>"
					+ "<a href='https://instagram.com/alumni_vvit?igshid=MzRlODBiNWFlZA==' target='_blank'>"
					+ "<img src='instalogo.jpg' alt='alumni-instagram' width='50px' height='35px'>" + "</a>" + "</div>"
					+ "</div>");

			out.println("</body>");
			out.println("<script>"
					+ "function openProfile() {"
					+ "            var container = document.getElementById(\"profile-container\");"
					+ "            var body = document.body;"
					+ "            var existingIframe = container.querySelector(\"iframe\");"
					+ ""
					+ "            if (existingIframe) {"
					+ "                container.style.display = \"none\";"
					+ "                container.removeChild(existingIframe);"
					+ "                body.style.overflow = \"auto\";"
					+ "            } else {"
					+ "                var iframe = document.createElement(\"iframe\");"
					+ "                iframe.src = \"profile.jsp\";"
					+ "                container.appendChild(iframe);"
					+ "                container.style.display = \"flex\";"
					+ "                body.style.overflow = \"hidden\";"
					+ "            }"
					+ "        }"
					+ "</script>");
			
			out.println("</html>");

		} catch (Exception e) {
			PrintWriter out = response.getWriter();
			e.printStackTrace();
			out.println("An error occurred!" + e);
		}
	}
}