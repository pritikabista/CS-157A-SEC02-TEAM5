package com.medicalims.model;

import java.sql.Date;

public class InventoryItem {
    private int itemReferenceNumber;
    private int categoryID;
    private int lotNumber;
    private String itemName;
    private Date expirationDate;

    private int locationID;
    private int stock;

    public InventoryItem() {
        this.itemReferenceNumber = 0;
        this.categoryID = 0;
        this.lotNumber = 0;
        this.itemName = "";
        this.expirationDate = null;
        this.locationID = 0;
        this.stock = 0;
    }

    public InventoryItem(int itemReferenceNumber, int categoryID, int lotNumber,
                         String itemName, Date expirationDate,
                         int locationID, int stock) {

        this.itemReferenceNumber = itemReferenceNumber;
        this.categoryID = categoryID;
        this.lotNumber = lotNumber;
        this.itemName = itemName;
        this.expirationDate = expirationDate;
        this.locationID = locationID;
        this.stock = stock;
    }

    public int getItemReferenceNumber() { return itemReferenceNumber; }
    public int getCategoryID() { return categoryID; }
    public int getLotNumber() { return lotNumber; }
    public String getItemName() { return itemName; }
    public Date getExpirationDate() { return expirationDate; }
    public int getLocationID() { return locationID; }
    public int getStock() { return stock; }

    public void setItemReferenceNumber(int itemReferenceNumber) { this.itemReferenceNumber = itemReferenceNumber; }
    public void setCategoryID(int categoryID) { this.categoryID = categoryID; }
    public void setLotNumber(int lotNumber) { this.lotNumber = lotNumber; }
    public void setItemName(String itemName) { this.itemName = itemName; }
    public void setExpirationDate(Date expirationDate) { this.expirationDate = expirationDate; }
    public void setLocationID(int locationID) { this.locationID = locationID; }
    public void setStock(int stock) { this.stock = stock; }
}
