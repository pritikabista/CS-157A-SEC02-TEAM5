package backend;

public class PurchaseOrder {
    private int orderID; 
    private int itemReferenceNum; 
    private int supplierID;
    private OrderStatus status; 
    private String approvedBy;

    public PurchaseOrder() {
        this.orderID = 0;
        this.itemReferenceNum = 0;
        this.supplierID = 0;
        this.status = OrderStatus.PENDING;
        this.approvedBy = "";
    }

    public PurchaseOrder(int orderID, int itemReferenceNum, int supplierID, OrderStatus status, String approvedBy) {
        this.orderID = orderID;
        this.itemReferenceNum = itemReferenceNum;
        this.supplierID = supplierID;
        this.status = status;
        this.approvedBy = approvedBy;
    }

    void setOrderID(int orderID) { this.orderID = orderID; }
    void setItemReferenceNum(int itemReferenceNum) { this.itemReferenceNum = itemReferenceNum; }
    void setSupplierID(int supplierID) { this.supplierID = supplierID; }
    void setStatus(OrderStatus status) { this.status = status; }
    void setApprovedBy(String approvedBy) { this.approvedBy = approvedBy; }

    int getOrderID() { return this.orderID; }
    int getItemReferenceNum() { return this.itemReferenceNum; }
    int getSupplierID() { return this.supplierID; }
    OrderStatus getStatus() { return this.status; }
    String getApprovedBy() { return this.approvedBy; }
    
}
