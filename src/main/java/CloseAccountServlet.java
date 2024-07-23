import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import bank.WithdrawaDAO;

@WebServlet("/closeAccountServlet")
public class CloseAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("Username");
        String confirmClose = request.getParameter("confirmClose");
        
        if ("CLOSE".equals(confirmClose)) {
            Connection conn = null;
            PreparedStatement pstmt = null;
            try {
                conn = WithdrawaDAO.getConnection();
                // Check balance before closing account
                String checkBalanceQuery = "SELECT Initialbalance FROM customer2 WHERE Username = ?";
                pstmt = conn.prepareStatement(checkBalanceQuery);
                pstmt.setString(1, username);
                ResultSet rs = pstmt.executeQuery();
                
                if (rs.next()) {
                    double balance = rs.getDouble("Initialbalance");
                    
                    if (balance == 0) {
                        // Proceed with account deletion
                        String deleteAccountQuery = "DELETE FROM customer2 WHERE Username = ?";
                        pstmt = conn.prepareStatement(deleteAccountQuery);
                        pstmt.setString(1, username);
                        pstmt.executeUpdate();
                        
                        // Invalidate session and redirect to a success page
                        request.getSession().invalidate();
                        response.sendRedirect("accountClosed.jsp");
                        return;
                    } else {
                        // Balance is not zero
                        response.sendRedirect("welcome.jsp?error=To close the account, your balance should be zero.");
                        return;
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("welcome.jsp?error=An error occurred while closing your account.");
            } finally {
                try { if (pstmt != null) pstmt.close(); } catch (SQLException ignore) {}
                try { if (conn != null) conn.close(); } catch (SQLException ignore) {}
            }
        } else {
            response.sendRedirect("welcome.jsp?error=Invalid confirmation input.");
        }
    }
}
