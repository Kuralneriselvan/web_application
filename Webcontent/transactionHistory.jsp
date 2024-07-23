<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="bank.WithdrawaDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Transaction History</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #e0f7fa, #80deea);
            color: #333;
            margin: 0;
            padding: 0;
            text-align: center;
        }
        .container {
            width: 90%;
            max-width: 1000px;
            margin: 20px auto;
            padding: 30px;
            background: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            border: 1px solid #e0e0e0;
        }
        h2 {
            color: #00796b;
            font-size: 26px;
            margin-bottom: 20px;
            border-bottom: 2px solid #00796b;
            padding-bottom: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        table, th, td {
            border: 1px solid #00796b;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #00796b;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #d0f0f0;
        }
        .deposit {
            color: green;
        }
        .withdraw {
            color: red;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #00796b;
            color: #ffffff;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        a:hover {
            background-color: #004d40;
        }
        .btn-download {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #00796b;
            color: #ffffff;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .btn-download:hover {
            background-color: #004d40;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Transaction History for <%= session.getAttribute("Username") %></h2>
        <%
            String username = (String) session.getAttribute("Username");
            int accountNo = WithdrawaDAO.getAccountNo(username);

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                conn = WithdrawaDAO.getConnection();
                String query = "SELECT * FROM transactions WHERE accountno = ? ORDER BY transaction_date DESC";
                pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, accountNo);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    out.println("<table>");
                    out.println("<tr><th>Date</th><th>Type</th><th>Amount</th><th>Description</th></tr>");
                    do {
                        String type = rs.getString("type").toUpperCase(); // Convert to uppercase
                        double amount = rs.getDouble("amount");
                        String formattedAmount = (type.equals("DEPOSIT") ? "+" : "-") + String.format("%.2f", amount);
                        String cssClass = type.equals("DEPOSIT") ? "deposit" : "withdraw";
                        out.println("<tr>");
                        out.println("<td>" + rs.getTimestamp("transaction_date") + "</td>");
                        out.println("<td class='" + cssClass + "'>" + type + "</td>");
                        out.println("<td class='" + cssClass + "'>" + formattedAmount + "</td>");
                        out.println("<td>" + rs.getString("description") + "</td>");
                        out.println("</tr>");
                    } while (rs.next());
                    out.println("</table>");
                } else {
                    out.println("<p>No transactions found.</p>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p>An error occurred while fetching transaction history.</p>");
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
        <a href="downloadPDF" class="btn-download">Download Transaction History as PDF</a>
        <a href="welcome.jsp">Back to Welcome Page</a>
    </div>
</body>
</html>
