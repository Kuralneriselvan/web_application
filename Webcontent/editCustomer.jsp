<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Customer Details</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f0f8ff;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h2 {
            color: #2f4f4f;
            text-align: center;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }
        input[type="text"], input[type="email"], input[type="date"], select {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #2196F3;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #1976D2;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Customer Details</h2>
        <%
            String accountNumber = request.getParameter("Accountno");
            String fullName = "";
            String phoneNumber = "";
            String emailId = "";
            String address = "";
            String dob = "";
            String typeOfAccount = "";
            String idProof = "";
            String username = "";

            // Fetch customer details from database
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/customer", "root", "root");

                String sql = "SELECT * FROM customer2 WHERE Accountno = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, accountNumber);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    fullName = rs.getString("Fullname");
                    phoneNumber = rs.getString("Phonenumber");
                    emailId = rs.getString("Emailid");
                    address = rs.getString("Address");
                    dob = rs.getString("DOB");
                    typeOfAccount = rs.getString("Typeofaccount");
                    idProof = rs.getString("Idproof");
                    username = rs.getString("Username");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        %>

        <form action="UpdateCustomerServlet" method="post">
            <input type="hidden" name="Accountno" value="<%= accountNumber %>">
            <label for="Fullname">Full Name</label>
            <input type="text" id="Fullname" name="Fullname" value="<%= fullName %>" required>
            
            <label for="Phonenumber">Phone Number</label>
            <input type="text" id="Phonenumber" name="Phonenumber" value="<%= phoneNumber %>" required>
            
            <label for="Emailid">Email ID</label>
            <input type="email" id="Emailid" name="Emailid" value="<%= emailId %>" required>
            
            <label for="Address">Address</label>
            <input type="text" id="Address" name="Address" value="<%= address %>" required>
            
            <label for="DOB">Date of Birth</label>
            <input type="date" id="DOB" name="DOB" value="<%= dob %>" required>
            
            <label for="Typeofaccount">Type of Account</label>
            <select id="Typeofaccount" name="Typeofaccount" required>
                <option value="Savings" <%= typeOfAccount.equals("Savings") ? "selected" : "" %>>Savings</option>
                <option value="Current" <%= typeOfAccount.equals("Current") ? "selected" : "" %>>Current</option>
                <option value="Fixed Deposit" <%= typeOfAccount.equals("Fixed Deposit") ? "selected" : "" %>>Fixed Deposit</option>
            </select>
            
            <label for="Idproof">ID Proof</label>
            <input type="text" id="Idproof" name="Idproof" value="<%= idProof %>" required>
            
            <label for="Username">Username</label>
            <input type="text" id="Username" name="Username" value="<%= username %>" required>
            
            <input type="submit" value="Update">
        </form>
    </div>
</body>
</html>
