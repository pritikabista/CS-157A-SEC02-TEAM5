package com.medicalims.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

import com.medicalims.model.OrderStatus;
import com.medicalims.model.User;
import com.medicalims.database.PurchaseOrderDAO;

@WebServlet("/user-purchaseOrder")
public class PurchaseOrderServlet extends HttpServlet{
    //doGet = handles page loading
        //load items so user can see/search and choose items from dropdown menu
    //doPost = handles form submissing
        //call PurchaseOrderDAO and insert a new purchase order using insertPurchaseOrder()


    @Override 
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

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

        //load items here to let the user pick from dropdown menu and forward it
        //use request.getRequestDispatcher("/jsp/user-request-purchaseOrder.jsp").forward(request, response); 
    
    }

    @Override 
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

        //get form submission
        //call PurchaseOrderDAO and insert a new purchase order using insertPurchaseOrder()

        //reload the items again (because if we don't set it after POST, dropdown will break)
        //POST -> insert -> REDIRECT so that user can't do duplicate insert 
    }
}
