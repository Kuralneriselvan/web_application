<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="bank.WithdrawaDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Dashboard</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: 'Open Sans', sans-serif;
            background: #f2f2f2;
            color: #444;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
        }
        .container {
            width: 100%;
            max-width: 1200px;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            align-items: flex-start;
            overflow-y: auto;
        }
        .sidebar {
            width: 25%;
            padding: 20px;
            background: #1e88e5;
            border-radius: 8px;
            color: #fff;
        }
        .sidebar h2 {
            margin-top: 0;
            font-size: 24px;
        }
        .sidebar p {
            margin: 10px 0;
            font-size: 16px;
        }
        .main-content {
            width: 70%;
            padding: 20px;
        }
        .main-content h3 {
            margin-top: 0;
            color: #1e88e5;
            font-size: 22px;
        }
        .main-content form {
            margin-top: 20px;
            display: flex;
            flex-direction: column;
        }
        .main-content form label {
            margin: 10px 0 5px;
            font-weight: bold;
        }
        .main-content form input[type="text"], .main-content form input[type="password"] {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        .main-content form input[type="submit"] {
            margin-top: 15px;
            padding: 10px;
            background: #1e88e5;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
        }
        .main-content form input[type="submit"]:hover {
            background: #1565c0;
        }
        .action-buttons {
            margin: 20px 0;
            display: flex;
            gap: 10px;
        }
        .action-buttons a {
            padding: 10px 20px;
            background: #1e88e5;
            color: #fff;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
            transition: background 0.3s;
        }
        .action-buttons a:hover {
            background: #1565c0;
        }
        .close-account {
            margin-top: 30px;
            padding: 20px;
            background: #fbe9e7;
            border: 1px solid #e57373;
            border-radius: 8px;
            text-align: center;
        }
        .close-account h3 {
            color: #e57373;
            margin: 0 0 20px;
        }
        .error-message {
            color: #d32f2f;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <h2>Welcome, <%= session.getAttribute("Username") %></h2>
            <div class="details">
                <%
                    String username = (String) session.getAttribute("Username");

                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        conn = WithdrawaDAO.getConnection();
                        String query = "SELECT * FROM customer2 WHERE Username = ?";
                        pstmt = conn.prepareStatement(query);
                        pstmt.setString(1, username);
                        rs = pstmt.executeQuery();

                        if (rs.next()) {
                            out.println("<p><strong>Full Name:</strong> " + rs.getString("Fullname") + "</p>");
                            out.println("<p><strong>Address:</strong> " + rs.getString("Address") + "</p>");
                            out.println("<p><strong>Phone Number:</strong> " + rs.getString("Phonenumber") + "</p>");
                            out.println("<p><strong>Email ID:</strong> " + rs.getString("Emailid") + "</p>");
                            out.println("<p><strong>Account Number:</strong> " + rs.getInt("Accountno") + "</p>");
                            out.println("<p><strong>Balance:</strong> &#8377;" + String.format("%.2f", rs.getDouble("Initialbalance")) + "</p>");
                        } else {
                            out.println("<p>No customer details found for username: " + username + "</p>");
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<p class='error-message'>An error occurred while fetching customer details.</p>");
                    } finally {
                        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </div>
        </div>
        <div class="main-content">
            <h3>Banking Operations</h3>
            <form action="withdrawServlet" method="post">
                <label for="amount">Amount:</label>
                <input type="text" id="amount" name="amount" placeholder="Enter amount" required>
                <label>Action:</label>
                <div class="radio-group">
                    <label><input type="radio" name="action" value="withdraw" checked> Withdraw</label>
                    <label><input type="radio" name="action" value="deposit"> Deposit</label>
                </div>
                <input type="submit" value="Process">
            </form>
            <div class="action-buttons">
                <a href="changePassword.jsp">Change Password</a>
                <a href="transactionHistory.jsp">View Transaction History</a>
                <a href="logoutServlet">Logout</a>
            </div>
            <div class="close-account">
                <h3><i class="fas fa-trash-alt"></i> Close Account</h3>
                <% 
                    String closeError = request.getParameter("error");
                    if (closeError != null) {
                        String errorMessage = "Error: " + closeError;
                        if ("balanceNotZero".equals(closeError)) {
                            errorMessage = "To close the account, your balance must be zero.";
                        }
                        out.println("<p class='error-message'>" + errorMessage + "</p>");
                    }
                %>
                <form action="closeAccountServlet" method="post">
                    <label for="confirmClose">Type <strong>"CLOSE"</strong> to confirm:</label>
                    <input type="text" id="confirmClose" name="confirmClose" placeholder="CLOSE" required>
                    <input type="submit" value="Close Account">
                </form>
            </div>
        </div>
    </div>
</body>
</html>
