package com.medicalims.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.medicalims.database.PurchaseOrderDAO;
import com.medicalims.model.OrderStatus;
import com.medicalims.model.PurchaseOrder;
import com.medicalims.model.User;

@WebServlet("/user-myRequests")
public class DisplayUserPurchaseOrdersServlet extends HttpServlet {

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
        List<PurchaseOrder> purchaseOrders;

        String statusString = request.getParameter("status");

        if (statusString == null || statusString.trim().isEmpty()) {
            statusString = "";
            purchaseOrders = purchaseOrderDAO.getPurchaseOrdersByUser(user.getAccountID());
        } else {
            statusString = statusString.trim().toUpperCase();

            try {
                OrderStatus status = OrderStatus.valueOf(statusString);
                purchaseOrders = purchaseOrderDAO.getPurchaseOrdersByUserAndStatus(user.getAccountID(), status);
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Invalid status!");
                statusString = "";
                purchaseOrders = purchaseOrderDAO.getPurchaseOrdersByUser(user.getAccountID());
            }
        }

        request.setAttribute("selectedStatus", statusString);
        request.setAttribute("purchaseOrders", purchaseOrders);

        request.getRequestDispatcher("/pages/user-purchaseOrders.jsp").forward(request, response);
    }
}