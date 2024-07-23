package bank;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateCustomerServlet")
public class UpdateCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNumber = request.getParameter("Accountno");
        String fullName = request.getParameter("Fullname");
        String phoneNumber = request.getParameter("Phonenumber");
        String emailId = request.getParameter("Emailid");
        String address = request.getParameter("Address");
        String dob = request.getParameter("DOB");
        String typeOfAccount = request.getParameter("Typeofaccount");
        String idProof = request.getParameter("Idproof");
        String username = request.getParameter("Username");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/customer", "root", "root");

            String sql = "UPDATE customer2 SET Fullname = ?, Phonenumber = ?, Emailid = ?, Address = ?, DOB = ?, Typeofaccount = ?, Idproof = ?, Username = ? WHERE Accountno = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, fullName);
            stmt.setString(2, phoneNumber);
            stmt.setString(3, emailId);
            stmt.setString(4, address);
            stmt.setString(5, dob);
            stmt.setString(6, typeOfAccount);
            stmt.setString(7, idProof);
            stmt.setString(8, username);
            stmt.setString(9, accountNumber);

            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                response.sendRedirect("editSuccess.jsp");
            } else {
                response.sendRedirect("editFailure.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editFailure.jsp");
        } finally {
            if (stmt != null) try { stmt.close(); } catch (Exception e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}
