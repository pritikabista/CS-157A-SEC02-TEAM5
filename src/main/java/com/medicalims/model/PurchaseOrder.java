package com.medicalims.model;

public class PurchaseOrder {
    private int orderID; 
    private int itemReferenceNum; 
    private OrderStatus status; 
    private int approvedBy;

    private int userID;
    private String message;
    private int qty;

    public PurchaseOrder() {
        this.orderID = 0;
        this.itemReferenceNum = 0;
        this.status = OrderStatus.PENDING;
        this.approvedBy = 0;

        this.userID = 0;
        this.message = "";
        this.qty = 0;

    }

    public PurchaseOrder(int orderID, int itemReferenceNum, OrderStatus status, int approvedBy, int userID, String message, int qty) {
        this.orderID = orderID;
        this.itemReferenceNum = itemReferenceNum;
        this.status = status;
        this.approvedBy = approvedBy;

        this.userID = userID;
        this.message = message;
        this.qty = qty;
    }

    public void setOrderID(int orderID) { this.orderID = orderID; }
    public void setItemReferenceNum(int itemReferenceNum) { this.itemReferenceNum = itemReferenceNum; }
    public void setStatus(OrderStatus status) { this.status = status; }
    public void setApprovedBy(int approvedBy) { this.approvedBy = approvedBy; }
    public void setUserID(int userID){this.userID=userID;}
    public void setMessage(String message){this.message=message;}
    public void setQty(int qty){this.qty=qty;}

    public int getOrderID() { return this.orderID; }
    public int getItemReferenceNum() { return this.itemReferenceNum; }
    public OrderStatus getStatus() { return this.status; }
    public int getApprovedBy() { return this.approvedBy; }
    public int getUserID(){return userID;}
    public String getMessage(){return message;}
    public int getQty(){return qty;}
}
