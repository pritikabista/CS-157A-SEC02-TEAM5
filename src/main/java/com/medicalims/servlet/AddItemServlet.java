package com.medicalims.servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.medicalims.database.UserInventoryDAO;

@WebServlet("/add-item")
public class AddItemServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        request.getRequestDispatcher("/pages/add-item.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        try {
            String itemName = request.getParameter("itemName");

            int referenceNumber = Integer.parseInt(request.getParameter("referenceNumber"));
            int lotNumber = Integer.parseInt(request.getParameter("lotNumber"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            int categoryID = Integer.parseInt(request.getParameter("category"));
            int supplierID = Integer.parseInt(request.getParameter("supplierID"));
            int locationID = Integer.parseInt(request.getParameter("location"));

            Date expirationDate = Date.valueOf(request.getParameter("expirationDate"));

            UserInventoryDAO dao = new UserInventoryDAO();

            boolean success = dao.addInventoryItem(
                    referenceNumber,
                    itemName,
                    categoryID,
                    lotNumber,
                    expirationDate,
                    quantity,
                    locationID,
                    supplierID
            );

            if (success) {
                request.setAttribute("success", "Item added successfully.");
            } else {
                request.setAttribute("error", "Unable to add item. Please check the item/location information.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid input. Please check all fields.");
        }

        request.getRequestDispatcher("/pages/add-item.jsp").forward(request, response);
    }
}