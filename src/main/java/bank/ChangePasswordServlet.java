package bank;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/changePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("Username");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        String message = null;

        if (username == null || newPassword == null || confirmPassword == null) {
            message = "Please log in and provide all required information.";
        } else if (!newPassword.equals(confirmPassword)) {
            message = "New passwords do not match.";
        } else {
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                conn = WithdrawaDAO.getConnection();
                
                // Update the new password
                String query = "UPDATE customer2 SET Password = ? WHERE Username = ?";
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, newPassword);
                pstmt.setString(2, username);
                
                int rowsUpdated = pstmt.executeUpdate();
                
                if (rowsUpdated > 0) {
                    message = "Password updated successfully.";
                } else {
                    message = "Error updating password.";
                }
            } catch (SQLException e) {
                e.printStackTrace();
                message = "An error occurred while changing the password.";
            } finally {
                try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }

        request.setAttribute("message", message);
        request.getRequestDispatcher("changePassword.jsp").forward(request, response);
    }
}
