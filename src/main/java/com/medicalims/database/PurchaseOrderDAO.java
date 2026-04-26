package com.medicalims.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.medicalims.model.PurchaseOrder;
import com.medicalims.util.DBConnection;

import com.medicalims.model.OrderStatus;

public class PurchaseOrderDAO {
    //DONE === admin can see all the purchaseorder and their info (who made them)
    //DONE === admin can approve the request
        //which will then take to supplier page ...more in Servlet class ***
    //DONE === admin can deny a request

    //DONE === user create a new purcharseorder (insert it into the database, purchaseOrder table and Requests table)
    //DONE == user can see the requests he made 
    //user can see the number of requests he made (NOT here but I count the size of the list of purchase order returned by getPurchaseOrdersByUser)
    //DONE == user can see the requests he made by specific status "PENDING", "APPROVED", "DENIED"

    public List<PurchaseOrder> getAllPurchaseOrders(){ //admin can see all the purchaseorder and their info (who made them)
        String sql_query = "SELECT * FROM Purchase_orders p JOIN Requests r ON p.Order_ID = r.Order_ID";
        return executeQuery(sql_query); 
    }

    public boolean approvePurchaseOrders(int orderID, int accountID){ // //admin can approve the request (accountID here is an Admin ID )
        //orderID must be validated in servlet class
        String sql_query = "UPDATE Purchase_orders SET Status = 'APPROVED', Approved_By = ? WHERE Order_ID = ? AND Status = 'PENDING'"; //only update if the purchase order was initially pending  
        return executeUpdate(sql_query, accountID, orderID); //take this admin to orderPage where he will submit order to supplier
    }

    public boolean denyPurchaseOrder(int orderID){
        String sql_query = "UPDATE Purchase_orders SET Status = 'DENIED' WHERE Order_ID = ? AND Status = 'PENDING'";
        return executeUpdate(sql_query, orderID);
    }
            
    public boolean insertPurchaseOrder(int itemReferenceNum,String message, int qty, int userID){ //user create a new purcharseorder (insert it into the database, purchaseOrder table and Requests table
        //int approvedBy = 0; don't insert anything, allow Null 
        String status = "PENDING";

        String sql_query = "INSERT INTO Purchase_orders (Item_Reference_Number, Status, Message, Qty) Values (?, ?, ?, ?)";
        int orderID = executeInsertion(sql_query, itemReferenceNum, status, message, qty);

        if (orderID == -1){ //insertion to the Purchase Order fails
            return false;
        }

        String sql_query2 = "INSERT INTO Requests (User_ID, Order_ID) Values (?, ?)";
        return executeUpdate(sql_query2, userID, orderID);
    }

    public List<PurchaseOrder> getPurchaseOrdersByUser(int userID){ //user can see the requests he made 
        String sql_query = "SELECT * FROM Purchase_orders p JOIN Requests r ON p.Order_ID = r.Order_ID WHERE r.User_ID = ?"; //get the purchase orders that the user made
        return executeQuery(sql_query, userID); 
    }

    public List<PurchaseOrder> getPurchaseOrdersByUserAndStatus(int userID, OrderStatus status){ //user can see specific requests
        String sql_query = "SELECT * FROM Purchase_orders p JOIN Requests r ON p.Order_ID = r.Order_ID WHERE r.User_ID = ? AND p.Status = ?";
        return executeQuery(sql_query, userID, status.toString());
    }

    
    private List<PurchaseOrder> executeQuery(String sql_query, Object... params){ //Object = variable number of parameters
        List<PurchaseOrder> purchaseOrders = new ArrayList<>(); 

        try{
            Connection con = DBConnection.getConnection(); 
            PreparedStatement stmt = con.prepareStatement(sql_query); //SQL Execution //sends SQL *****

            for(int i = 0; i < params.length; i++){
                stmt.setObject(i+1, params[i]);
            }

            ResultSet rs = stmt.executeQuery();

            while(rs.next()){
                int orderID = rs.getInt("Order_ID");
                int itemReferenceNum = rs.getInt("Item_Reference_Number");
                OrderStatus status = OrderStatus.valueOf(rs.getString("Status"));
                int approvedBy = rs.getInt("Approved_By");
                
                int userID = rs.getInt("User_ID");
                String message = rs.getString("Message");
                int qty = rs.getInt("Qty");

                purchaseOrders.add(new PurchaseOrder(orderID, itemReferenceNum, status, approvedBy, userID, message, qty));

            }

            rs.close(); //clean up ***** below
            stmt.close(); 
            con.close(); 

        } catch (Exception e){
            e.printStackTrace(); 
        }
        return purchaseOrders;
    } //end of executeQuery()

    private boolean executeUpdate(String sql_query, Object ... params){ //use for updating attributes
        boolean successfulUpdate= false;

        try{
            Connection con = DBConnection.getConnection(); 
            PreparedStatement stmt = con.prepareStatement(sql_query); //SQL Execution

            for(int i = 0; i < params.length; i++){
                stmt.setObject(i+1, params[i]);
            }

            int rowsAffected = stmt.executeUpdate(); //1 = 1 row updated, 0 = update fails

            if(rowsAffected > 0){ //successfully updated a row 
                successfulUpdate= true;
            }

            stmt.close();  //clean up ***** below
            con.close(); 
        } catch (Exception e){
            e.printStackTrace(); 
        }
        return successfulUpdate;
    }

    private int executeInsertion(String sql_query, Object ... params){
        int generatedKey = -1; //insering a new purchase order fails
        try{
            Connection con = DBConnection.getConnection(); 
            PreparedStatement stmt = con.prepareStatement(sql_query, PreparedStatement.RETURN_GENERATED_KEYS); //SQL Execution // after excuting INSERT, get the auto-generated values (AUTO_INCREMENT PK)

            for(int i = 0; i < params.length; i++){
                stmt.setObject(i+1, params[i]);
            }

            int rowsAffected = stmt.executeUpdate(); //1 = 1 row inserted, 0 = insertion fails

            if(rowsAffected > 0){ //successfully inserted
                ResultSet rs = stmt.getGeneratedKeys(); //get the auto-incremented orderID back 
                if (rs.next()) { //read the key
                    generatedKey = rs.getInt(1);
                }
                rs.close();
            }

            stmt.close();  //clean up ***** below
            con.close(); 
        } catch (Exception e){
            e.printStackTrace(); 
        }
        return generatedKey; //if -1, not inserted, else return orderID
    }

}

