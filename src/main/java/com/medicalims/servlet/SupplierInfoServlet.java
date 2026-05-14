package com.medicalims.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.medicalims.database.SupplierDAO;
import com.medicalims.model.Supplier;

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

        SupplierDAO supplierDAO = new SupplierDAO();

        String approved = request.getParameter("approved");
        String orderIDString = request.getParameter("orderID");

        if ("true".equals(approved) && orderIDString != null) {
            try {
                int orderID = Integer.parseInt(orderIDString);

                Supplier supplier = supplierDAO.getSupplierByOrderID(orderID);

                request.setAttribute("approvedMode", true);
                request.setAttribute("supplier", supplier);

            } catch (NumberFormatException e) {
                request.setAttribute("approvedMode", true);
                request.setAttribute("supplier", null);
            }

        } else {
            List<Supplier> suppliers = supplierDAO.getAllSuppliers();

            request.setAttribute("approvedMode", false);
            request.setAttribute("suppliers", suppliers);
        }

        request.getRequestDispatcher("/pages/supplier-info.jsp")
               .forward(request, response);
    }
}