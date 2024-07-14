<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>
<%@ page import="jakarta.servlet.http.HttpServletResponse"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>

<%
@SuppressWarnings("unused")
class DBConnect {
    private Connection db;

    public DBConnect() throws SQLException {
        db = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_db", "root", "");
    }

    public void close() throws SQLException {
        db.close();
    }

    public int login(String username, String password) throws SQLException {
        PreparedStatement pstmt = db.prepareStatement("SELECT * FROM users WHERE username = ? AND password = ?");
        pstmt.setString(1, username);
        pstmt.setString(2, md5(password));
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            HttpSession session = request.getSession();
            session.setAttribute("login_type", rs.getInt("type"));
            session.setAttribute("login_id", rs.getInt("id"));
            session.setAttribute("login_username", username);
            return 1; // login successful
        } else {
            return 3; // invalid username or password
        }
    }

    public int login2(String username, String password) throws SQLException {
        PreparedStatement pstmt = db.prepareStatement("SELECT * FROM users WHERE username = ? AND password = ?");
        pstmt.setString(1, username);
        pstmt.setString(2, md5(password));
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            HttpSession session = request.getSession();
            session.setAttribute("login_alumnus_id", rs.getInt("alumnus_id"));
            session.setAttribute("login_username", username);
            session.setAttribute("login_type", rs.getInt("type"));
            return 1; // login successful
        } else {
            return 3; // invalid username or password
        }
    }

    public void logout() throws SQLException,IOException {
        HttpSession session = request.getSession();
        session.invalidate();
        response.sendRedirect("login.jsp");
    }


    public void logout2(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("../index.jsp");
    }

    public int saveUser(String name, String username, String password, int type, int establishmentId) throws SQLException {
        PreparedStatement pstmt = db.prepareStatement("INSERT INTO users (name, username, password, type, establishment_id) VALUES (?, ?, ?, ?, ?)");
        pstmt.setString(1, name);
        pstmt.setString(2, username);
        pstmt.setString(3, md5(password));
        pstmt.setInt(4, type);
        pstmt.setInt(5, establishmentId);
        int affectedRows = pstmt.executeUpdate();
        if (affectedRows > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    public int deleteUser(int id) throws SQLException {
        PreparedStatement pstmt = db.prepareStatement("DELETE FROM users WHERE id = ?");
        pstmt.setInt(1, id);
        int affectedRows = pstmt.executeUpdate();
        if (affectedRows > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    public int signup(String firstname, String lastname, String email, String password) throws SQLException {
        PreparedStatement pstmt = db.prepareStatement("INSERT INTO users (name, username, password) VALUES (?, ?, ?)");
        pstmt.setString(1, firstname + " " + lastname);
        pstmt.setString(2, email);
        pstmt.setString(3, md5(password));
        int affectedRows = pstmt.executeUpdate();
        if (affectedRows > 0) {
            int userId = getLastInsertId();
            pstmt = db.prepareStatement("INSERT INTO alumnus_bio (user_id, name, email) VALUES (?, ?, ?)");
            pstmt.setInt(1, userId);
            pstmt.setString(2, firstname + " " + lastname);
            pstmt.setString(3, email);
            affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                return 1;
            } else {
                return 0;
            }
        } else {
            return 0;
        }
    }

    public int updateAccount(String firstname, String lastname, String email, String password) throws SQLException {
        PreparedStatement pstmt = db.prepareStatement("UPDATE users SET name = ?, username = ?, password = ? WHERE id = ?");
        pstmt.setString(1, firstname + " " + lastname);
        pstmt.setString(2, email);
        pstmt.setString(3, md5(password));
        pstmt.setInt(4, getSessionUserId());
        int affectedRows = pstmt.executeUpdate();
        if (affectedRows > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    public int saveSettings(String name, String email, String contact, String about) throws SQLException {
        PreparedStatement pstmt = db.prepareStatement("INSERT INTO system_settings (name, email, contact, about_content) VALUES (?, ?, ?, ?)");
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, contact);
        pstmt.setString(4, about);
        int affectedRows = pstmt.executeUpdate();
        if (affectedRows > 0) {
            return 1;
        } else {
            return 0;
        }
    }
    public int saveCourse(String course) throws SQLException {
        PreparedStatement pstmt = db.prepareStatement("INSERT INTO courses (course) VALUES (?)");
        pstmt.setString(1, course);
        int affectedRows = pstmt.executeUpdate();
        if (affectedRows > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    public int deleteCourse(int id) throws SQLException {
        PreparedStatement pstmt = db.prepareStatement("DELETE FROM courses WHERE id = ?");
        pstmt.setInt(1, id);
        int affectedRows = pstmt.executeUpdate();
        if (affectedRows > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    public int updateAlumniAcc(int id, int status) throws SQLException {
        PreparedStatement pstmt = db.prepareStatement("UPDATE alumnus_bio SET status = ? WHERE id = ?");
        pstmt.setInt(1, status);
        pstmt.setInt(2, id);
        int affectedRows = pstmt.executeUpdate();
        if (affectedRows > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    public int saveGallery(String about, String img) throws SQLException {
        PreparedStatement pstmt = db.prepareStatement("INSERT INTO gallery (about) VALUES (?)");
        pstmt.setString(1, about);
        int affectedRows = pstmt.executeUpdate();
        if (affectedRows > 0) {
            int id = getLastInsertId();
            pstmt = db.prepareStatement("UPDATE gallery SET img = ? WHERE id = ?");
            pstmt.setString(1, img);
            pstmt.setInt(2, id);
            affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                return 1;
            } else {
                return 0;
            }
        } else {
            return 0;
        }
    }

    public int deleteGallery(int id) throws SQLException {
        PreparedStatement pstmt = db.prepareStatement("DELETE FROM gallery WHERE id = ?");
        pstmt.setInt(1, id);
        int affectedRows = pstmt.executeUpdate();
        if (affectedRows > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    public int saveCareer(String company, String title, String location, String description) throws SQLException {
        PreparedStatement pstmt = db.prepareStatement("INSERT INTO careers (company, job_title, location, description) VALUES (?, ?, ?, ?)");
        pstmt.setString(1, company);
        pstmt.setString(2, title);
        pstmt.setString(3, location);
        pstmt.setString(4, description);
        int affectedRows = pstmt.executeUpdate();
        if (affectedRows > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    public int deleteCareer(int id) throws SQLException {
        PreparedStatement pstmt = db.prepareStatement("DELETE FROM careers WHERE id = ?");
        pstmt.setInt(1, id);
        int affectedRows = pstmt.executeUpdate();
        if (affectedRows > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    public int saveForum(String title, String description) throws SQLException {
        PreparedStatement pstmt = db.prepareStatement("INSERT INTO forum_topics (title, description) VALUES (?, ?)");
        pstmt.setString(1, title);
        pstmt.setString(2, description);
        int affectedRows = pstmt.executeUpdate();
        if (affectedRows > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    public int deleteForum(int id) throws SQLException {
        PreparedStatement pstmt = db.prepareStatement("DELETE FROM forum_topics WHERE id = ?");
        pstmt.setInt(1, id);
        int affectedRows = pstmt.executeUpdate();
        if (affectedRows > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    public int saveComment(String comment, int topicId) throws SQLException {
        PreparedStatement pstmt = db.prepareStatement("INSERT INTO forum_comments (comment, topic_id) VALUES (?, ?)");
        pstmt.setString(1, comment);
        pstmt.setInt(2, topicId);
        int affectedRows = pstmt.executeUpdate();
        if (affectedRows > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    public int deleteComment(int id) throws SQLException {
        PreparedStatement pstmt = db.prepareStatement("DELETE FROM forum_comments WHERE id = ?");
        pstmt.setInt(1, id);
        int affectedRows = pstmt.executeUpdate();
        if (affectedRows > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    public int saveEvent(String title, String schedule, String content, String banner) throws SQLException {
        PreparedStatement pstmt = db.prepareStatement("INSERT INTO events (title, schedule, content, banner) VALUES (?, ?, ?, ?)");
        pstmt.setString(1, title);
        pstmt.setString(2, schedule);
        pstmt.setString(3, content);
        pstmt.setString(4, banner);
        int affectedRows = pstmt.executeUpdate();
        if (affectedRows > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    public int deleteEvent(int id) throws SQLException {
        PreparedStatement pstmt = db.prepareStatement("DELETE FROM events WHERE id = ?");
        pstmt.setInt(1, id);
        int affectedRows = pstmt.executeUpdate();
        if (affectedRows > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    public int participate(int eventId) throws SQLException {
        PreparedStatement pstmt = db.prepareStatement("INSERT INTO event_commits (event_id, user_id) VALUES (?, ?)");
        pstmt.setInt(1, eventId);
        pstmt.setInt(2, getSessionUserId());
        int affectedRows = pstmt.executeUpdate();
        if (affectedRows > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    private int getSessionUserId() {
        HttpSession session = request.getSession();
        return (int) session.getAttribute("login_id");
    }

    private int getLastInsertId() throws SQLException {
        Statement stmt = db.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT LAST_INSERT_ID()");
        rs.next();
        return rs.getInt(1);
    }

    private String md5(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] bytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
}
%>