package bank;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/withdrawServlet")
public class WithdrawServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String amountStr = request.getParameter("amount");
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("Username");

        int accountNo = WithdrawaDAO.getAccountNo(username);
        System.out.println("Account number for username " + username + " is " + accountNo);

        try {
            int amount = Integer.parseInt(amountStr);
            boolean result = false;

            if ("withdraw".equals(action)) {
                result = WithdrawaDAO.withdraw(amount, accountNo);
            } else if ("deposit".equals(action)) {
                result = WithdrawaDAO.deposit(amount, accountNo);
            }

            response.setContentType("text/html");
            response.getWriter().println("<html><head><meta charset='UTF-8'><title>Transaction Result</title></head><body>");
            response.getWriter().println("<h1>" + (action.equals("withdraw") ? "Withdrawal" : "Deposit") + " " + (result ? "Successful" : "Failed") + "</h1>");
            
            if (result) {
                double newBalance = WithdrawaDAO.getBalance(accountNo);
                response.getWriter().println("<p>Updated Balance: &#8377;" + String.format("%.2f", newBalance) + "</p>");
            }
            
            response.getWriter().println("<a href='welcome.jsp'>Back to Home</a>");
            response.getWriter().println("</body></html>");
        } catch (NumberFormatException e) {
            response.setContentType("text/html");
            response.getWriter().println("<html><head><meta charset='UTF-8'><title>Error</title></head><body>");
            response.getWriter().println("<h1>Invalid Input</h1>");
            response.getWriter().println("<p>Please enter a valid numeric amount.</p>");
            response.getWriter().println("<a href='welcome.jsp'>Back to Home</a>");
            response.getWriter().println("</body></html>");
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<html><head><meta charset='UTF-8'><title>Error</title></head><body>");
            response.getWriter().println("<h1>An Error Occurred</h1>");
            response.getWriter().println("<p>There was a problem processing your request. Please try again later.</p>");
            response.getWriter().println("<a href='welcome.jsp'>Back to Home</a>");
            response.getWriter().println("</body></html>");
        }
    }
}
