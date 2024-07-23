package bank;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class WithdrawaDAO {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/customer";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root";

    // Method to get database connection
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Create database connection
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            System.out.println("Database connection established successfully.");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Failed to establish database connection.");
        }
        return conn;
    }

    public static boolean withdraw(int amount, int accountNo) {
        String checkBalanceQuery = "SELECT Initialbalance FROM customer2 WHERE Accountno = ?";
        String updateBalanceQuery = "UPDATE customer2 SET Initialbalance = Initialbalance - ? WHERE Accountno = ?";
        try (Connection conn = getConnection();
             PreparedStatement checkBalanceStmt = conn.prepareStatement(checkBalanceQuery);
             PreparedStatement updateBalanceStmt = conn.prepareStatement(updateBalanceQuery)) {
            
            // Check balance
            checkBalanceStmt.setInt(1, accountNo);
            ResultSet rs = checkBalanceStmt.executeQuery();
            if (rs.next()) {
                double currentBalance = rs.getDouble("Initialbalance");
                if (currentBalance >= amount) {
                    // Perform withdrawal
                    updateBalanceStmt.setInt(1, amount);
                    updateBalanceStmt.setInt(2, accountNo);
                    int rowsAffected = updateBalanceStmt.executeUpdate();
                    if (rowsAffected > 0) {
                        // Record the transaction
                        recordTransaction(accountNo, amount, "withdrawal", "Withdrawal of " + amount);
                        System.out.println("Withdrawal successful for account number: " + accountNo);
                        return true;
                    } else {
                        System.out.println("Failed to update balance for withdrawal.");
                    }
                } else {
                    System.out.println("Insufficient funds for account number: " + accountNo);
                }
            } else {
                System.out.println("Account number not found: " + accountNo);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Exception occurred during withdrawal.");
        }
        return false;
    }

    public static boolean deposit(int amount, int accountNo) {
        String updateBalanceQuery = "UPDATE customer2 SET Initialbalance = Initialbalance + ? WHERE Accountno = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(updateBalanceQuery)) {
            
            // Perform deposit
            pstmt.setInt(1, amount);
            pstmt.setInt(2, accountNo);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                // Record the transaction
                recordTransaction(accountNo, amount, "deposit", "Deposit of " + amount);
                System.out.println("Deposit successful for account number: " + accountNo);
                return true;
            } else {
                System.out.println("Failed to update balance for deposit.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Exception occurred during deposit.");
        }
        return false;
    }

    private static void recordTransaction(int accountNo, int amount, String type, String description) {
        String query = "INSERT INTO transactions (accountno, amount, type, description) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, accountNo);
            pstmt.setInt(2, amount);
            pstmt.setString(3, type);
            pstmt.setString(4, description);
            pstmt.executeUpdate();
            System.out.println("Transaction recorded successfully: " + description);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Failed to record transaction.");
        }
    }

    public static int getAccountNo(String username) {
        int accountNo = 0;
        String query = "SELECT Accountno FROM customer2 WHERE Username = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    accountNo = rs.getInt("Accountno");
                    System.out.println("Account number retrieved: " + accountNo);
                } else {
                    System.out.println("Username not found: " + username);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Exception occurred while retrieving account number.");
        }
        return accountNo;
    }

    public static double getBalance(int accountNo) {
        double balance = 0;
        String query = "SELECT Initialbalance FROM customer2 WHERE Accountno = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, accountNo);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    balance = rs.getDouble("Initialbalance");
                    System.out.println("Balance retrieved: " + balance);
                } else {
                    System.out.println("Account number not found: " + accountNo);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Exception occurred while retrieving balance.");
        }
        return balance;
    }
}
