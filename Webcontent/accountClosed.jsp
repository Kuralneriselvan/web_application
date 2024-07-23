<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Account Closed</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(to right, #e0f7fa, #80deea);
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            text-align: center;
        }
        h2 {
            color: #00796b;
            font-size: 28px;
            margin-bottom: 20px;
        }
        p {
            font-size: 18px;
            margin: 15px 0;
        }
        a.button {
            display: inline-block;
            padding: 14px 20px;
            background: #00796b;
            color: #ffffff;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
            margin-top: 10px;
        }
        a.button:hover {
            background: #004d40;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Account Closed</h2>
        <p>Your account has been successfully closed.</p>
        <a href="index.jsp" class="button">Back to Home</a>
    </div>
</body>
</html>
