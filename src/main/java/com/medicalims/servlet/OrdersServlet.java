package com.medicalims.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

import com.medicalims.database.PurchaseOrderDAO;
import com.medicalims.model.Admin;
import com.medicalims.model.PurchaseOrder;

@WebServlet("/orders")
public class OrdersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        PurchaseOrderDAO dao = new PurchaseOrderDAO();
        List<PurchaseOrder> orders = dao.getApprovedPurchaseOrdersForOrdersPage();

        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/pages/orders.jsp").forward(request, response);
    }
}