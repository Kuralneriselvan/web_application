<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Banking Application</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background: linear-gradient(to right, #8A2BE2, #7B68EE); /* Violet gradient */
            color: #fff; /* Text color set to white for better contrast */
        }

        .container {
            text-align: center;
            background: rgba(255, 255, 255, 0.1);
            padding: 50px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            max-width: 600px; /* Increased max-width for better layout on larger screens */
            width: 100%;
        }

        h1 {
            margin-bottom: 30px;
            font-size: 3em;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }

        .options {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px; /* Increased margin-top for better spacing */
        }

        .button {
            display: inline-block;
            padding: 15px 40px; /* Increased padding for larger buttons */
            text-decoration: none;
            color: #1E90FF;
            background-color: #fff;
            border-radius: 5px;
            font-size: 1.5em;
            border: 2px solid #1E90FF;
            transition: background-color 0.3s ease, color 0.3s ease, transform 0.3s ease, border-color 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Added box-shadow for depth */
        }

        .button:hover {
            background-color: #1E90FF;
            color: #fff;
            transform: scale(1.05); /* Slightly increased scale on hover */
            box-shadow: 0 6px 8px rgba(0, 0, 0, 0.2); /* Enhanced box-shadow on hover */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to GENPACKT BANK</h1>
        <div class="options">
            <a href="adminlogin.jsp" class="button">Admin Login</a>
            <a href="login.jsp" class="button">Customer Login</a>
        </div>
    </div>
</body>
</html>
