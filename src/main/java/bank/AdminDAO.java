package bank;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDAO {
    private static String jdbcURL = "jdbc:mysql://localhost:3306/admin";
    private static String jdbcUsername = "root";
    private static String jdbcPassword = "root";

    private static final String SELECT_ADMIN_SQL = "SELECT * FROM admindetails WHERE Fullname = ? AND password = ?";

    protected static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }

    public static boolean validate(String username, String password) {
        boolean status = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ADMIN_SQL)) {
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            ResultSet rs = preparedStatement.executeQuery();
            status = rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

	
	}