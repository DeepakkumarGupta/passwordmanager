/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
public class DeletePasswordServlet extends HttpServlet {
protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String website = request.getParameter("website");

           Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/password_manager?characterEncoding=UTF-8", "root", "");
            
            String deleteQuery = "DELETE FROM passwords WHERE user_id = (SELECT id FROM users WHERE username=?) AND website=? LIMIT 1";
            try (PreparedStatement deleteStmt = con.prepareStatement(deleteQuery)) {

                deleteStmt.setString(1, (String) request.getSession().getAttribute("username"));
                deleteStmt.setString(2, website);
                int rowsAffected = deleteStmt.executeUpdate();
                if (rowsAffected > 0) {
                    // Password deleted successfully
                    response.sendRedirect("passwordmanager.jsp");
                } else {
                    // Password not found or deletion failed
                    response.sendRedirect("error.jsp");
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception or handle it appropriately
        }
    }
  
    

}
