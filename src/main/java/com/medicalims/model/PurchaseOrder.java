package com.medicalims.model;

public class PurchaseOrder {
    private int orderID; 
    private int itemReferenceNum; 
    private OrderStatus status; 
    private int approvedBy;

    private int userID;
    private String message;
    private int qty;

    // NEW FIELDS
    private String itemName;
    private String username;

    public PurchaseOrder() {
        this.orderID = 0;
        this.itemReferenceNum = 0;
        this.status = OrderStatus.PENDING;
        this.approvedBy = 0;

        this.userID = 0;
        this.message = "";
        this.qty = 0;

        this.itemName = "";
        this.username = "";
    }

    public PurchaseOrder(int orderID, int itemReferenceNum, OrderStatus status, int approvedBy, int userID, String message, int qty) {
        this.orderID = orderID;
        this.itemReferenceNum = itemReferenceNum;
        this.status = status;
        this.approvedBy = approvedBy;

        this.userID = userID;
        this.message = message;
        this.qty = qty;

        this.itemName = "";
        this.username = "";
    }

    // OPTIONAL FULL CONSTRUCTOR (for admin use)
    public PurchaseOrder(int orderID, int itemReferenceNum, String itemName,
                         OrderStatus status, int approvedBy,
                         int userID, String username,
                         String message, int qty) {

        this.orderID = orderID;
        this.itemReferenceNum = itemReferenceNum;
        this.itemName = itemName;

        this.status = status;
        this.approvedBy = approvedBy;

        this.userID = userID;
        this.username = username;

        this.message = message;
        this.qty = qty;
    }

    // SETTERS
    public void setOrderID(int orderID) { this.orderID = orderID; }
    public void setItemReferenceNum(int itemReferenceNum) { this.itemReferenceNum = itemReferenceNum; }
    public void setStatus(OrderStatus status) { this.status = status; }
    public void setApprovedBy(int approvedBy) { this.approvedBy = approvedBy; }
    public void setUserID(int userID) { this.userID = userID; }
    public void setMessage(String message) { this.message = message; }
    public void setQty(int qty) { this.qty = qty; }

    public void setItemName(String itemName) { this.itemName = itemName; }
    public void setUsername(String username) { this.username = username; }

    public int getOrderID() { return this.orderID; }
    public int getItemReferenceNum() { return this.itemReferenceNum; }
    public OrderStatus getStatus() { return this.status; }
    public int getApprovedBy() { return this.approvedBy; }
    public int getUserID() { return this.userID; }
    public String getMessage() { return this.message; }
    public int getQty() { return this.qty; }

    public String getItemName() { return this.itemName; }
    public String getUsername() { return this.username; }
}