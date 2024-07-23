package bank;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CustomerUtil {

    public static int getAccountNo(String username) {
        int accountNo = 0;
        String query = "SELECT Accountno FROM customer2 WHERE Username = ?";
        try (Connection conn = WithdrawaDAO.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                accountNo = rs.getInt("Accountno");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return accountNo;
    }
}
