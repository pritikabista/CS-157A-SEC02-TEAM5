package com.medicalims.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

import com.medicalims.model.InventoryItem;
import com.medicalims.model.User;
import com.medicalims.model.Admin;

import com.medicalims.database.UserInventoryDAO;

@WebServlet("/inventory")
public class InventoryServlet extends HttpServlet {
    //doGet = handles page loading
        //user will see all the items when he first clicks view my inventory
    //doPost = handles form submissing
        //user can choose how to sort the items (by locationId or lot number or expiration date)

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null){
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return; 
        }
       
        User user = (User)session.getAttribute("user");
        Admin admin = (Admin)session.getAttribute("admin"); 

        if (user == null && admin == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        //load all the InventoryItems here
        UserInventoryDAO userInventoryDAO = new UserInventoryDAO(); 
        List<InventoryItem> inventoryItems = userInventoryDAO.getAllInventoryItemsToDisplay();

        request.setAttribute("inventoryItems", inventoryItems);
        request.getRequestDispatcher("/pages/inventory.jsp").forward(request, response);
    }

    @Override 
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null){
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return; 
        }
       
        User user = (User)session.getAttribute("user");
        Admin admin = (Admin)session.getAttribute("admin"); 

        if (user == null && admin == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        int accountID;

        if(user == null){
            accountID = admin.getAccountID();
        }else{
            accountID = user.getAccountID();
        }

        String action = request.getParameter("action");

        String userInput = request.getParameter("search");

        String filterType = request.getParameter("filterType");
        String filterValue = request.getParameter("filterValue");
        

        UserInventoryDAO userInventoryDAO = new UserInventoryDAO(); 
        List<InventoryItem> inventoryItems;

        //boolean withdrawEmpty = (withdraw == null || withdraw.trim().isEmpty());
        boolean searchEmpty = (userInput == null || userInput.trim().isEmpty());
        boolean filterTypeEmpty = (filterType == null || filterType.trim().isEmpty());
        boolean filterValueEmpty = (filterValue == null || filterValue.trim().isEmpty());

        if("withdraw".equals(action)){ //user click withdraw button 
            String itemReferenceNumberString = request.getParameter("itemReferenceNumber");
            String locationIDString = request.getParameter("locationID");
            String qtyStr = request.getParameter("qty");

            try{
                int itemReferenceNumber = Integer.parseInt(itemReferenceNumberString);
                int locationID = Integer.parseInt(locationIDString);
                int qty = Integer.parseInt(qtyStr);

                if (qty <= 0){
                    request.setAttribute("errorMessage", "Withdrawal quantity must be greater than 0");
                }
                else{
                    boolean success = userInventoryDAO.withdrawItem(itemReferenceNumber, qty, locationID, accountID); //we should call withdraw_logDAO to log the withdrawl

                    if (!success){
                        request.setAttribute("errorMessage", "Not enough stock available for withdrawl");
                    }
                }
            }catch (NumberFormatException e){
                request.setAttribute("errorMessage", "Quantity must be an integer!");
            }

              inventoryItems = userInventoryDAO.getAllInventoryItemsToDisplay(); 
        }
        else if ("update".equals(action)) {

            if (admin == null) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
        
            String itemReferenceNumberString = request.getParameter("itemReferenceNumber");
            String locationIDString = request.getParameter("locationID");
            String qtyStr = request.getParameter("qty");
        
            try {
                int itemReferenceNumber = Integer.parseInt(itemReferenceNumberString);
                int locationID = Integer.parseInt(locationIDString);
                int qty = Integer.parseInt(qtyStr);
        
                if (qty <= 0) {
                    request.setAttribute("errorMessage", "Update quantity must be greater than 0");
                } else {
                    boolean success = userInventoryDAO.updateItemStock(itemReferenceNumber, qty, locationID);
        
                    if (!success) {
                        request.setAttribute("errorMessage", "Could not update stock.");
                    }
                }
        
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Quantity must be an integer!");
            }
        
            inventoryItems = userInventoryDAO.getAllInventoryItemsToDisplay();
        }
        else if(!searchEmpty){ //user used the search bar
            userInput = userInput.trim();
            inventoryItems = userInventoryDAO.searchInventoryItems(userInput);
        }
        else if(!filterTypeEmpty){
            filterType = filterType.trim();

            switch(filterType){
                case "location":
                    if (!filterValueEmpty){
                        int locationID = Integer.parseInt(filterValue);
                        inventoryItems = userInventoryDAO.getAllInventoryItemsByLocation(locationID);
                    }
                    else {
                        inventoryItems = userInventoryDAO.getAllInventoryItemsToDisplay();
                    }
                    break;
                
                case "lot":
                    if(!filterValueEmpty){
                        try{
                            int lotNumber = Integer.parseInt(filterValue);
                            inventoryItems = userInventoryDAO.getAllInventoryItemsByLotNumber(lotNumber);
                        } catch (NumberFormatException e){
                            inventoryItems = userInventoryDAO.getAllInventoryItemsToDisplay();
                            request.setAttribute("errorMessage", "Lot number must be numeric.");
                        }
                    }
                    else{
                        inventoryItems = userInventoryDAO.getAllInventoryItemsToDisplay();
                    }
                    break; 

                case "expiration":
                    inventoryItems = userInventoryDAO.getAllInventoryItemsByNearestExpirationDate();
                    break;

                case "lowStock":
                    inventoryItems = userInventoryDAO.getInventoryItemsLowInStock();
                    break;

                default: 
                    inventoryItems = userInventoryDAO.getAllInventoryItemsToDisplay();
            }
        }

        else{
            inventoryItems = userInventoryDAO.getAllInventoryItemsToDisplay(); 
        }

        request.setAttribute("inventoryItems", inventoryItems);
        request.setAttribute("search", userInput);
        request.setAttribute("filterType", filterType);
        request.setAttribute("filterValue", filterValue);

        request.getRequestDispatcher("/pages/inventory.jsp").forward(request, response); 

    }
}