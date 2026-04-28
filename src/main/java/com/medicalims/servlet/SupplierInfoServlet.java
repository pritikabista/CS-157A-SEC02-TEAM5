package com.medicalims.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/supplier-info")
public class SupplierInfoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        request.getRequestDispatcher("/pages/supplier-info.jsp")
               .forward(request, response);
    }
}