import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfWriter;

import bank.WithdrawaDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/downloadPDF")
public class DownloadPDFServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("Username");
        int accountNo = WithdrawaDAO.getAccountNo(username);

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment;filename=transaction_history.pdf");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        OutputStream out = response.getOutputStream();
        
        try {
            conn = WithdrawaDAO.getConnection();
            String query = "SELECT * FROM transactions WHERE accountno = ? ORDER BY transaction_date DESC";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, accountNo);
            rs = pstmt.executeQuery();

            Document document = new Document();
            PdfWriter.getInstance(document, out);
            document.open();

            document.add(new Paragraph("Transaction History for " + username));
            document.add(new Paragraph(" ")); // Add some space between title and table

            PdfPTable table = new PdfPTable(4);
            table.setWidths(new float[] {1.5f, 2f, 1.5f, 3f}); // Adjust column widths as needed

            // Adding table headers
            addCell(table, "Date", true);
            addCell(table, "Type", true);
            addCell(table, "Amount", true);
            addCell(table, "Description", true);

            while (rs.next()) {
                addCell(table, rs.getTimestamp("transaction_date").toString(), false);
                addCell(table, rs.getString("type"), false);
                addCell(table, String.format("%.2f", rs.getDouble("amount")), false);
                addCell(table, rs.getString("description"), false);
            }

            document.add(table);
            document.close();
        } catch (SQLException e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<p>An error occurred while generating the PDF.</p>");
        } catch (DocumentException e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<p>An error occurred while generating the PDF.</p>");
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (out != null) out.close(); } catch (IOException e) { e.printStackTrace(); }
        }
    }

    private void addCell(PdfPTable table, String text, boolean isHeader) {
        PdfPCell cell = new PdfPCell(new Paragraph(text));
        if (isHeader) {
            cell.setBackgroundColor(com.itextpdf.text.BaseColor.LIGHT_GRAY);
            cell.setHorizontalAlignment(PdfPCell.ALIGN_CENTER);
        }
        cell.setPadding(5);
        table.addCell(cell);
    }
}
