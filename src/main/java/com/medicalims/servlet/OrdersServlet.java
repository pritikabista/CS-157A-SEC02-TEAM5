package com.medicalims.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

import com.medicalims.model.Admin;

@WebServlet("/orders")
public class OrdersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // 🔐 Check login
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        Admin admin = (Admin) session.getAttribute("admin");

        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        // ✅ Forward to JSP
        request.getRequestDispatcher("/pages/orders.jsp")
               .forward(request, response);
    }
}