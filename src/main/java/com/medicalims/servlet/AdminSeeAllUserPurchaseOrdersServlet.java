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
import com.medicalims.model.Admin;
import com.medicalims.model.OrderStatus;
import com.medicalims.model.PurchaseOrder;

@WebServlet("/admin-purchaseOrder")
public class AdminSeeAllUserPurchaseOrdersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        Admin admin = (Admin) session.getAttribute("admin");

        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        String statusString = request.getParameter("status");

        PurchaseOrderDAO purchaseOrderDAO = new PurchaseOrderDAO();
        List<PurchaseOrder> purchaseOrders;

        if (statusString == null || statusString.trim().isEmpty()) {
            statusString = "";
            purchaseOrders = purchaseOrderDAO.getAllPurchaseOrders();
        } else {
            statusString = statusString.trim().toUpperCase();

            try {
                OrderStatus status = OrderStatus.valueOf(statusString);
                purchaseOrders = purchaseOrderDAO.getPurchaseOrdersByStatusForAdmin(status);
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Invalid status!");
                statusString = "";
                purchaseOrders = purchaseOrderDAO.getAllPurchaseOrders();
            }
        }

        request.setAttribute("selectedStatus", statusString);
        request.setAttribute("purchaseOrders", purchaseOrders);

        request.getRequestDispatcher("/pages/purchase-requests.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        Admin admin = (Admin) session.getAttribute("admin");

        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String orderIDString = request.getParameter("orderID");

        if (action == null || orderIDString == null) {
            response.sendRedirect(request.getContextPath() + "/admin-purchaseOrder");
            return;
        }

        try {
            int orderID = Integer.parseInt(orderIDString);

            PurchaseOrderDAO dao = new PurchaseOrderDAO();

            if ("approve".equals(action)) {
                dao.approvePurchaseOrders(orderID, admin.getAccountID());
            } else if ("deny".equals(action)) {
                dao.denyPurchaseOrder(orderID);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid Order ID");
        }

        response.sendRedirect(request.getContextPath() + "/admin-purchaseOrder");
    }
}