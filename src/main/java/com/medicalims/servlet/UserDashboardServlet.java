package com.medicalims.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.medicalims.database.PurchaseOrderDAO;
import com.medicalims.database.UserInventoryDAO;
import com.medicalims.model.OrderStatus;
import com.medicalims.model.User;
import com.medicalims.util.DBConnection;

@WebServlet("/user-dashboard")
public class UserDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        PurchaseOrderDAO purchaseOrderDAO = new PurchaseOrderDAO();
        UserInventoryDAO userInventoryDAO = new UserInventoryDAO();

        int pendingOrderCounts =
                purchaseOrderDAO.getPurchaseOrdersByUserAndStatus(user.getAccountID(), OrderStatus.PENDING).size();

        int itemsExpiringCounts =
                userInventoryDAO.getInventoryItemsExpiringInAWeek().size();

        int itemsLowInStockCounts =
                userInventoryDAO.getInventoryItemsLowInStock().size();

        String departmentName = getDepartmentNameById(user.getDepartmentID());

        request.setAttribute("myRequestsCount", pendingOrderCounts);
        request.setAttribute("expiringSoonCount", itemsExpiringCounts);
        request.setAttribute("lowStockCount", itemsLowInStockCounts);

        request.setAttribute("userID", user.getAccountID());
        request.setAttribute("departmentID", user.getDepartmentID());
        request.setAttribute("departmentName", departmentName);
        request.setAttribute("phNum", user.getPhNum());

        request.getRequestDispatcher("/pages/user-dashboard.jsp").forward(request, response);
    }

    private String getDepartmentNameById(int departmentID) {
        String sql = "SELECT Department_Name FROM Departments WHERE Department_ID = ?";

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setInt(1, departmentID);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String departmentName = rs.getString("Department_Name");

                rs.close();
                stmt.close();
                con.close();

                return departmentName;
            }

            rs.close();
            stmt.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "Unknown Department";
    }
}