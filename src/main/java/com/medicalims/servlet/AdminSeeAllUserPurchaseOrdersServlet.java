package com.medicalims.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

import com.medicalims.model.InventoryItem;
import com.medicalims.model.OrderStatus;
import com.medicalims.model.Admin;
import com.medicalims.model.PurchaseOrder;
import com.medicalims.database.PurchaseOrderDAO;
import com.medicalims.database.UserInventoryDAO;

@WebServlet("/admin-purchaseOrder")
public class AdminSeeAllUserPurchaseOrdersServlet extends HttpServlet {
    @Override 
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        Admin admin = (Admin) session.getAttribute("admin");
        String statusString = request.getParameter("status"); 

        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }
        
        PurchaseOrderDAO purchaseOrderDAO = new PurchaseOrderDAO(); 
        List<PurchaseOrder> purchaseOrders;

        if(statusString == null || statusString.trim().isEmpty()){
            statusString = "";
            purchaseOrders = purchaseOrderDAO.getAllPurchaseOrders();
        }
        else{
            statusString = statusString.trim().toUpperCase();

            try{
                OrderStatus status = OrderStatus.valueOf(statusString);
                purchaseOrders = purchaseOrderDAO.getPurchaseOrdersByStatusForAdmin(status);
            
            }catch (IllegalArgumentException e){
                request.setAttribute("error", "Invalid status!");
                purchaseOrders = purchaseOrderDAO.getAllPurchaseOrders();
            }
        }

        request.setAttribute("selectedStatus", statusString);
        request.setAttribute("purchaseOrders", purchaseOrders);
        request.getRequestDispatcher("/pages/purchase-requests.jsp").forward(request, response); 
    }

    @Override 
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

   
    }
}
