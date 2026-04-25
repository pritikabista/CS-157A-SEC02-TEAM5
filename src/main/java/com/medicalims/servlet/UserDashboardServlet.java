package com.medicalims.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

import com.medicalims.model.OrderStatus;
import com.medicalims.model.User;
import com.medicalims.database.PurchaseOrderDAO;
// import com.medicalims.model.PurchaseOrder;

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

        PurchaseOrderDAO purchaseOrderDAO = new PurchaseOrderDAO();

        //get the number of PENDING purchaseOrders 
        int pendingOrderCounts = purchaseOrderDAO.getPurchaseOrdersByUserAndStatus(user.getAccountID(), OrderStatus.PENDING).size();

        request.setAttribute("pendingOrderCounts", pendingOrderCounts); //*** use this in jsp***/
        request.setAttribute("userID", user.getAccountID());
        request.setAttribute("departmentID", user.getDepartmentID());
        request.setAttribute("phNum", user.getPhNum());

        request.getRequestDispatcher("/pages/user-dashboard.jsp").forward(request, response);
    }
}
