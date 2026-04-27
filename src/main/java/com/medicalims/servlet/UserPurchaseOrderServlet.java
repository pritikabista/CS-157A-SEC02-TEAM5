package com.medicalims.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

import com.medicalims.model.InventoryItem;
import com.medicalims.model.User;
import com.medicalims.database.PurchaseOrderDAO;
import com.medicalims.database.UserInventoryDAO;

@WebServlet("/user-purchaseOrder")
public class UserPurchaseOrderServlet extends HttpServlet{
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
        UserInventoryDAO userInventoryDAO = new UserInventoryDAO(); 
        List<InventoryItem> inventoryItems;

        String userInput = request.getParameter("search");

        if (userInput == null || userInput.trim().isEmpty()){
            inventoryItems = null; //when search is empty, user won't see the table 
        }
        else{
            userInput = userInput.trim();
            inventoryItems = userInventoryDAO.searchInventoryItems(userInput);
        }

        request.setAttribute("search", userInput);
        request.setAttribute("items", inventoryItems);
        request.getRequestDispatcher("/pages/user-request-purchaseOrder.jsp").forward(request, response); 
    
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
        String userInput = request.getParameter("search");

        UserInventoryDAO userInventoryDAO = new UserInventoryDAO(); 
        List<InventoryItem> inventoryItems;
        if (userInput == null || userInput.trim().isEmpty()){
            inventoryItems = null; //when search is empty, user won't see the table 
        }
        else{
            userInput = userInput.trim();
            inventoryItems = userInventoryDAO.searchInventoryItems(userInput);
        }

        request.setAttribute("search", userInput);
        request.setAttribute("items", inventoryItems);



        String itemReferenceNumString = request.getParameter("itemReferenceNum");
        String qtyString = request.getParameter("quantity");
        String message = request.getParameter("message");


        if (itemReferenceNumString == null || qtyString == null || message == null){
            request.setAttribute("error", "Input cannot be null!");
            request.getRequestDispatcher("/pages/user-request-purchaseOrder.jsp").forward(request, response);
            return;
        }

        itemReferenceNumString = itemReferenceNumString.trim();
        qtyString = qtyString.trim();
        message = message.trim(); 

        if (itemReferenceNumString.isEmpty() || qtyString.isEmpty() || message.isEmpty()){
            request.setAttribute("error", "Input cannot be empty!");
            request.getRequestDispatcher("/pages/user-request-purchaseOrder.jsp").forward(request, response);
            return;
        }

        int itemReferenceNum;
        int qty;

        try{
            itemReferenceNum= Integer.parseInt(itemReferenceNumString);
            qty = Integer.parseInt(qtyString);
        }catch (NumberFormatException e) {
            request.setAttribute("error", "Item reference number and quantity must be integers");
            request.getRequestDispatcher("/pages/user-request-purchaseOrder.jsp").forward(request, response);
            return;
        }

        //check if the quantity is valid
        if(qty <=0){
            request.setAttribute("error", "Quantity must be greater than 0!");
            request.getRequestDispatcher("/pages/user-request-purchaseOrder.jsp").forward(request, response);
            return;
        }

        //check if item exists in the inventory using InventoryDAO  (LATER)
            //we know that item exists since we make the user choose an item from the tale 
       

        //call PurchaseOrderDAO and insert a new purchase order using insertPurchaseOrder()
        PurchaseOrderDAO purchaseOrderDAO = new PurchaseOrderDAO();
        boolean inserted = purchaseOrderDAO.insertPurchaseOrder(itemReferenceNum, message, qty, user.getAccountID());

        if (!inserted){
            request.setAttribute("error", "Error submitting the request, Please try again!");
            request.getRequestDispatcher("/pages/user-request-purchaseOrder.jsp").forward(request, response);
            return;
        }


        response.sendRedirect(request.getContextPath() + "/user-dashboard");
        //POST -> insert -> REDIRECT so that user can't do duplicate insert 

    }
}
