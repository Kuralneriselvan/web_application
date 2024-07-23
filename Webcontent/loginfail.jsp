<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Failed</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8d7da;
            color: #721c24;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            text-align: center;
            background: #ffffff;
            padding: 40px;
            border: 1px solid #f5c6cb;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            font-size: 2em;
            margin-bottom: 20px;
        }
        p {
            font-size: 1.2em;
            margin-bottom: 20px;
        }
        a.button {
            display: inline-block;
            padding: 10px 20px;
            background: #f5c6cb;
            color: #721c24;
            text-decoration: none;
            border-radius: 5px;
            border: 1px solid #721c24;
            transition: background 0.3s ease, color 0.3s ease;
        }
        a.button:hover {
            background: #721c24;
            color: #ffffff;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Login Failed</h1>
        <p>The username or password you entered is incorrect. Please try again.</p>
        <a href="login.jsp" class="button">Back to Login</a>
    </div>
</body>
</html>
