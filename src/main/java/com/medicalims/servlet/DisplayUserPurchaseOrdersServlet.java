package com.medicalims.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

import com.medicalims.model.User;
import com.medicalims.database.PurchaseOrderDAO;
import com.medicalims.model.PurchaseOrder;
import com.medicalims.model.OrderStatus;

@WebServlet("/user-myRequests")
public class DisplayUserPurchaseOrdersServlet extends HttpServlet{
    //doGet = handles page loading
        //load users'purchaseOrders in a list and pass it as myPurchaseOrders
    //doPost = handles form submissing
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null){
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return; 
        }

        User user = (User)session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        //load purchase orders here 
        PurchaseOrderDAO purchaseOrderDAO = new PurchaseOrderDAO();
        List<PurchaseOrder> purchaseOrders;

        String statusString = request.getParameter("status"); //*** get me the status, should provide user a dropdown menu that can select the values of enum OrderStatus***/
        

        if(statusString == null || statusString.trim().isEmpty()){
            purchaseOrders = purchaseOrderDAO.getPurchaseOrdersByUser(user.getAccountID());
        }
        else{
            statusString = statusString.trim().toUpperCase();

            try{
                OrderStatus status = OrderStatus.valueOf(statusString);
                purchaseOrders = purchaseOrderDAO.getPurchaseOrdersByUserAndStatus(user.getAccountID(), status);
            
            }catch (IllegalArgumentException e){
                request.setAttribute("error", "Invalid status!");
                purchaseOrders = purchaseOrderDAO.getPurchaseOrdersByUser(user.getAccountID());
            }
        }

        request.setAttribute("purchaseOrders", purchaseOrders);
        request.getRequestDispatcher("/pages/user-purchaseOrder.jsp"); 
    }

    
    

    
}
