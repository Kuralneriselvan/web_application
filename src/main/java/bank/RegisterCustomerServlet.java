package bank;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeParseException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/registerCustomerServlet")
public class RegisterCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1796381764981520343L;
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/customer?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Set headers to prevent caching
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // Retrieve form parameters
        String fullname = request.getParameter("fullname");
        String phonenumber = request.getParameter("phonenumber");
        String emailid = request.getParameter("emailid");
        String address = request.getParameter("address");
        String dob = request.getParameter("DOB");
        String typeofaccount = request.getParameter("accounttype");
        String idproof = request.getParameter("idproof");
        String username = request.getParameter("username");
        String initialbalanceStr = request.getParameter("initialbalance");

        // Convert and validate date of birth
        LocalDate dobDate = null;
        try {
            dobDate = LocalDate.parse(dob);
            int age = Period.between(dobDate, LocalDate.now()).getYears();
            if (age < 18) {
                out.write("Error: Age must be 18 or older.");
                return;
            }
        } catch (DateTimeParseException e) {
            out.write("Error: Invalid date format. Please use YYYY-MM-DD.");
            return;
        }

        // Generate account number and password
        String accountno = generateAccountNumber();
        String password = generatePassword();

        // Convert initial balance
        double initialbalance;
        try {
            initialbalance = Double.parseDouble(initialbalanceStr);
        } catch (NumberFormatException e) {
            out.write("Error: Invalid initial balance. Please enter a numeric value.");
            return;
        }

        // Database connection and insertion
        Connection conn = null;
        PreparedStatement stmt = null;
        PreparedStatement checkStmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // Check if the username already exists
            String checkSql = "SELECT COUNT(*) FROM customer2 WHERE Username = ?";
            checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, username);
            rs = checkStmt.executeQuery();
            rs.next();
            if (rs.getInt(1) > 0) {
                out.write("Error: Username already exists. Please choose a different username.");
                return;
            }

            // Insert new record
            String sql = "INSERT INTO customer2 (Fullname, Phonenumber, Emailid, Accountno, Address, DOB, Typeofaccount, Idproof, Username, Initialbalance, Password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, fullname);
            stmt.setString(2, phonenumber);
            stmt.setString(3, emailid);
            stmt.setString(4, accountno);
            stmt.setString(5, address);
            stmt.setDate(6, java.sql.Date.valueOf(dobDate));
            stmt.setString(7, typeofaccount);
            stmt.setString(8, idproof);
            stmt.setString(9, username);
            stmt.setDouble(10, initialbalance);
            stmt.setString(11, password);
            stmt.executeUpdate();

            // Forward to JSP page with success message
            request.setAttribute("accountno", accountno);
            request.setAttribute("password", password);
            request.getRequestDispatcher("/registration_success.jsp").forward(request, response);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            out.write("Error: MySQL JDBC driver not found. Please check the driver configuration.");
        } catch (SQLException e) {
            e.printStackTrace();
            out.write("Error: Database error occurred. Details: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (checkStmt != null) checkStmt.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private String generateAccountNumber() {
        // Generate a unique account number
        return String.format("%010d", (int)(Math.random() * 1_000_000_000));
    }

    private String generatePassword() {
        // Generate a shorter, unique password
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder password = new StringBuilder();
        int passwordLength = 8; // Desired password length

        for (int i = 0; i < passwordLength; i++) {
            int randomIndex = (int) (Math.random() * characters.length());
            password.append(characters.charAt(randomIndex));
        }

        return password.toString();
    }
}
