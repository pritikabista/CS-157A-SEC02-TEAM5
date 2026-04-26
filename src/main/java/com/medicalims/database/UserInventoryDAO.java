package com.medicalims.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

import com.medicalims.util.DBConnection;

import com.medicalims.model.Item;
import com.medicalims.model.Inventory;
import com.medicalims.model.InventoryItem;



public class UserInventoryDAO {
    //DONE == User will view all the items in the inventory when he first click "View the inventory"
    //DONE == User can sort the items with specified locations
    //DONE == User can see the items with lot number 
    //DONE == Users will see the items with the nearest expiration date first

    //Users can use the searchbar that accepts string (can be either item name or item ref num or category name)

    //DONE == User will be able to withdraw items //a method that first check whether the item 

    //user will view all the items when he first click "View the inventory"
    public List<InventoryItem> getAllInventoryItemsToDisplay() {
        String sql_query = "SELECT * FROM Inventory v JOIN Items t ON v.Item_Reference_Number = t.Item_Reference_Number";
        return executeQuery(sql_query);
    }

    //User can sort the items with specified locations
    public List<InventoryItem> getAllInventoryItemsByLocation(int locationID) {
        String sql_query = "SELECT * FROM Inventory v JOIN Items t ON v.Item_Reference_Number = t.Item_Reference_Number WHERE v.Location_ID = ?";
        return executeQuery(sql_query, locationID);
    }

    //User can see the items with lot number 
    public List<InventoryItem> getAllInventoryItemsByLotNumber(int lotNumber){
        String sql_query = "SELECT * FROM Inventory v JOIN Items t ON v.Item_Reference_Number = t.Item_Reference_Number WHERE t.Lot_Number = ?";
        return executeQuery(sql_query, lotNumber);
    }

    //Users will see the items with the nearest expiration date first
    public List<InventoryItem> getAllInventoryItemsByNearestExpirationDate(){
        String sql_query = "SELECT * From Inventory v JOIN Items t ON v.Item_Reference_Number = t.Item_Reference_Number ORDER BY t.Expiration_Date ASC"; //earliest expiration date at the top, later dates at the bottom
        return executeQuery(sql_query);
    }

    //User will be able to withdraw items //a method that first check whether the item 
    public boolean withdrawItem(int itemReferenceNum, int qty, int locationID){ //had to use locationID because items can exist in multiple locations
        String sql_query = "UPDATE Inventory SET Stock = Stock - ?" +
                            "WHERE Location_ID = ? AND Item_Reference_Number = ? AND Stock >= ?";
        return executeUpdate(sql_query, qty, locationID, itemReferenceNum, qty);
    }

    //Users can use the searchbar that accepts string (CAN BE EITHER item name or item ref num or category name)
    public List<InventoryItem> searchInventoryItems(String userInput){
        //determine if the userinput is int meaning it is the item ref number
        try{
            int itemReferenceNum = Integer.parseInt(userInput);
            String sql_query = "SELECT * FROM Inventory v JOIN Items t ON v.Item_Reference_Number = t.Item_Reference_Number " +
                                "WHERE t.Item_Reference_Number = ?";
            return executeQuery(sql_query, itemReferenceNum);
        }catch (NumberFormatException e){
            //userInput is not an item ref number but a string
        }

        String userInputString = "%" + userInput + "%"; 
        String sql_query = "SELECT * FROM Inventory v JOIN Items t ON v.Item_Reference_Number = t.Item_Reference_Number " +
                            "JOIN Categories c ON c.Category_ID = t.Category_ID " + 
                            "WHERE t.Item_Name LIKE ? " +
                            "OR c.Category_Name LIKE ? ";
        return executeQuery(sql_query, userInputString, userInputString);
    }


    private List<InventoryItem> executeQuery(String sql_query, Object... params){ //Object = variable number of parameters
        List<InventoryItem> inventoryItems = new ArrayList<>(); 

        try{
            Connection con = DBConnection.getConnection(); 
            PreparedStatement stmt = con.prepareStatement(sql_query); //SQL Execution //sends SQL *****

            for(int i = 0; i < params.length; i++){
                stmt.setObject(i+1, params[i]);
            }

            ResultSet rs = stmt.executeQuery();

            while(rs.next()){
                int locationID = rs.getInt("Location_ID");
                int itemReferenceNum = rs.getInt("Item_Reference_Number");
                int stock = rs.getInt("Stock");

                int categoryID = rs.getInt("Category_ID");
                int lotNumber = rs.getInt("Lot_Number");
                String itemName = rs.getString("Item_Name");
                Date expirationDate = rs.getDate("Expiration_Date");
            
                inventoryItems.add(new InventoryItem(itemReferenceNum, categoryID, lotNumber, itemName, expirationDate, locationID, stock));
            }

            rs.close(); //clean up ***** below
            stmt.close(); 
            con.close(); 

        } catch (Exception e){
            e.printStackTrace(); 
        }
        return inventoryItems;
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
}
