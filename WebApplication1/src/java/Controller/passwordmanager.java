package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class passwordmanager extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = request.getParameter("url");
        String password = request.getParameter("password");

        // Get the username from the session
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/password_manager?characterEncoding=UTF-8", "root", "");

            String sql = "INSERT INTO passwords (user_id, website, password) VALUES ((SELECT id FROM users WHERE username=?), ?, ?)";

            try (PreparedStatement pstmt = con.prepareStatement(sql)) {
                pstmt.setString(1, username);
                pstmt.setString(2, url);
                pstmt.setString(3, password);
                pstmt.executeUpdate();
            }

            con.close();
            response.sendRedirect("passwordmanager.jsp"); // Redirect to the password management page
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
