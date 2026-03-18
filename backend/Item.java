package backend;

public class Item {

    private int itemReferenceNumber;
    private int categoryID;
    private int lotNumber;
    private String itemName;
    private String expirationDate;

    public Item() {
        this.itemReferenceNumber = 0;
        this.categoryID = 0;
        this.lotNumber = 0;
        this.itemName = "";
        this.expirationDate = "";
    }

    public Item(int itemReferenceNumber, int categoryID, int lotNumber, String itemName, String expirationDate) {
        this.itemReferenceNumber = itemReferenceNumber;
        this.categoryID = categoryID;
        this.lotNumber = lotNumber;
        this.itemName = itemName;
        this.expirationDate = expirationDate;
    }

    void setItemReferenceNumber(int itemReferenceNumber) { this.itemReferenceNumber = itemReferenceNumber; }
    void setCategoryID(int categoryID) { this.categoryID = categoryID; }
    void setLotNumber(int lotNumber) { this.lotNumber = lotNumber; }
    void setItemName(String itemName) { this.itemName = itemName; }
    void setExpirationDate(String expirationDate) { this.expirationDate = expirationDate; }

    int getItemReferenceNumber() { return this.itemReferenceNumber; }
    int getCategoryID() { return this.categoryID; }
    int getLotNumber() { return this.lotNumber; }
    String getItemName() { return this.itemName; }
    String getExpirationDate() { return this.expirationDate; }
}