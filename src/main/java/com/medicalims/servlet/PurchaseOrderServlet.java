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
    
    @Override 
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
    //make a new purchaseOrder 
    //use purhcaseorderDAO's insertPurchaseOrder 
    
    }
}
