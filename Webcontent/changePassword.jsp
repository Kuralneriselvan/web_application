<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(to right, #f0f4f8, #d9e2ec);
            margin: 0;
            padding: 0;
        }
        .container {
            width: 90%;
            max-width: 600px;
            margin: 40px auto;
            padding: 30px;
            background: #ffffff;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            border-radius: 10px;
            border: 1px solid #e0e0e0;
        }
        h2 {
            color: #005f73;
            font-size: 28px;
            margin-bottom: 20px;
            border-bottom: 2px solid #005f73;
            padding-bottom: 10px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #005f73;
            font-weight: 600;
        }
        input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #b0bec5;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #0288d1;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        input[type="submit"]:hover {
            background-color: #01579b;
            transform: scale(1.05);
        }
        .message {
            color: #d32f2f;
            margin-bottom: 20px;
            font-size: 16px;
        }
        .back-button {
            display: inline-block;
            padding: 12px 20px;
            background-color: #b3e5fc;
            color: #0277bd;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            text-align: center;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease, transform 0.2s ease;
            margin-top: 20px;
        }
        .back-button:hover {
            background-color: #81d4fa;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Change Password</h2>
        <form action="changePasswordServlet" method="post">
            <label for="newPassword">New Password:</label>
            <input type="password" id="newPassword" name="newPassword" placeholder="Enter new password" required><br>
            <label for="confirmPassword">Confirm New Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Re-enter new password" required><br>
            <input type="submit" value="Change Password" class="change-password-submit">
        </form>
        <%
            String message = (String) request.getAttribute("message");
            if (message != null) {
                out.println("<p class='message'>" + message + "</p>");
            }
        %>
        <a href="login.jsp" class="back-button">Back to Welcome Page</a>
    </div>
</body>
</html>
