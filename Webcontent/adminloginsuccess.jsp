<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f8ff;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            text-align: center;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 100%;
        }
        h1, h2 {
            color: #333;
            margin: 0;
        }
        h1 {
            margin-bottom: 10px;
            font-size: 2em;
        }
        h2 {
            margin-bottom: 20px;
            font-size: 1.5em;
        }
        .button {
            display: inline-block;
            margin: 10px;
            padding: 15px 25px;
            background-color: #333;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 1em;
            transition: background-color 0.3s ease;
        }
        .button:hover {
            background-color: #555;
        }
        .success-message {
            display: none;
            color: #333;
            font-size: 1.2em;
            margin-bottom: 20px;
            animation: blink 1s;
        }
        @keyframes blink {
            50% { color: rgb(141, 241, 234); }
        }
        .footer {
            text-align: center;
            padding: 10px;
            background-color: #333;
            color: white;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
    </style>
    <script>
        function showSuccessMessage() {
            var successMessage = document.getElementById('success-message');
            successMessage.style.display = 'block';
            setTimeout(function() {
                successMessage.style.display = 'none';
            }, 3000);
        }
        window.onload = showSuccessMessage;
    </script>
</head>
<body>
    <div class="container">
        <h1>Welcome Admin</h1>
        <h2>Welcome to your Dashboard</h2>
        <div id="success-message" class="success-message">Login Successfully</div>
        <a href="customerRegistration.html" class="button">Customer Registration</a>
        <a href="displaycustomerdetails.jsp" class="button">Customer Details</a>
        <a href="logoutServlet" class="button">Logout</a>
    </div>
    <div class="footer">
        &copy; WELCOME TO GENPACT BANK WEBSITE
    </div>
</body>
</html>
