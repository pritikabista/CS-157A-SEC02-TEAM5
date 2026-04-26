package com.medicalims.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

import com.medicalims.model.OrderStatus;
import com.medicalims.model.User;
import com.medicalims.database.PurchaseOrderDAO;
// import com.medicalims.model.PurchaseOrder;
import com.medicalims.database.UserInventoryDAO;

@WebServlet("/user-dashboard")
public class UserDashboardServlet extends HttpServlet{
    
    @Override 
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

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

        PurchaseOrderDAO purchaseOrderDAO = new PurchaseOrderDAO();//to get the # of pending orders 
        UserInventoryDAO userInventoryDAO = new UserInventoryDAO();//to get the # of items expiring within a week, low stocks items


        //get the number of PENDING purchaseOrders, # of items expiring soon, # of items that are low in stock 
        int pendingOrderCounts = purchaseOrderDAO.getPurchaseOrdersByUserAndStatus(user.getAccountID(), OrderStatus.PENDING).size();
        int itemsExpiringCounts = userInventoryDAO.getInventoryItemsExpiringInAWeek().size();
        int itemsLowInStockCounts = userInventoryDAO.getInventoryItemsLowInStock().size();

        request.setAttribute("myRequestsCount", pendingOrderCounts);
        request.setAttribute("expiringSoonCount", itemsExpiringCounts);
        request.setAttribute("lowStockCount", itemsLowInStockCounts);


        request.setAttribute("userID", user.getAccountID());
        request.setAttribute("departmentID", user.getDepartmentID());
        request.setAttribute("phNum", user.getPhNum());

        request.getRequestDispatcher("/pages/user-dashboard.jsp").forward(request, response);
    }
}
