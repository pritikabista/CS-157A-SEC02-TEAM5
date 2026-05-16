package com.medicalims.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

import com.medicalims.database.PurchaseOrderDAO;
import com.medicalims.model.OrderStatus;
import com.medicalims.model.PurchaseOrder;

@WebServlet("/orders")
public class OrdersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        String status = request.getParameter("status");

        PurchaseOrderDAO dao = new PurchaseOrderDAO();
        List<PurchaseOrder> orders;

        if (status == null || status.trim().isEmpty()) {
            status = "";
            orders = dao.getApprovedPurchaseOrdersForOrdersPage();
        } else {
            status = status.trim().toUpperCase();

            if ("APPROVED".equals(status)) {
                orders = dao.getPurchaseOrdersByStatusForAdmin(OrderStatus.APPROVED);
            } else if ("DENIED".equals(status)) {
                orders = dao.getPurchaseOrdersByStatusForAdmin(OrderStatus.DENIED);
            } else if ("COMPLETED".equals(status)) {
                orders = dao.getPurchaseOrdersByStatusForAdmin(OrderStatus.COMPLETED);
            } else {
                status = "";
                orders = dao.getApprovedPurchaseOrdersForOrdersPage();
            }
        }

        request.setAttribute("selectedStatus", status);
        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/pages/orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String orderIDString = request.getParameter("orderID");

        if ("complete".equals(action) && orderIDString != null) {
            try {
                int orderID = Integer.parseInt(orderIDString);

                PurchaseOrderDAO dao = new PurchaseOrderDAO();
                dao.completePurchaseOrder(orderID);

            } catch (NumberFormatException e) {
                // invalid order id
            }
        }

        response.sendRedirect(request.getContextPath() + "/orders");
    }
}