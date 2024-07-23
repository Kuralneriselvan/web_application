<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Withdraw</title>
    <style>
        /* Your existing styles */
    </style>
</head>
<body>
    <h2>Banking Operations</h2>
    <form action="withdrawServlet" method="post">
        <label for="accNo">Account Number:</label>
        <input type="text" id="accNo" name="accNo" placeholder="Enter your account number" required><br>

        <label for="amount">Amount:</label>
        <input type="text" id="amount" name="amount" placeholder="Enter the amount" required><br>

        <label>Action:</label>
        <div class="radio-label">
            <input type="radio" id="withdraw" name="action" value="withdraw" checked>
            <label for="withdraw" style="display: inline;">Withdraw</label>
        </div>
        <div class="radio-label">
            <input type="radio" id="deposit" name="action" value="deposit">
            <label for="deposit" style="display: inline;">Deposit</label>
        </div><br><br>

        <input type="submit" value="Process">
        <a href="transactionHistory">View Transaction History</a> <!-- Link to view transaction history -->
    </form>
</body>
</html>
