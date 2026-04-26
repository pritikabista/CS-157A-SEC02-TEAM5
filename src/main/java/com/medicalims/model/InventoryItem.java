package com.medicalims.model;

import java.sql.Date;

public class InventoryItem {
    private int itemReferenceNumber;
    private String categoryName;
    private int lotNumber;
    private String itemName;
    private Date expirationDate;

    private int locationID;
    private String location; // B1-R101 format
    private int stock;

    public InventoryItem() {
        this.itemReferenceNumber = 0;
        this.categoryName = "";
        this.lotNumber = 0;
        this.itemName = "";
        this.expirationDate = null;
        this.locationID = 0;
        this.location = "";
        this.stock = 0;
    }

    public InventoryItem(int itemReferenceNumber, String categoryName, int lotNumber,
                         String itemName, Date expirationDate,
                         int locationID, String location, int stock) {

        this.itemReferenceNumber = itemReferenceNumber;
        this.categoryName = categoryName;
        this.lotNumber = lotNumber;
        this.itemName = itemName;
        this.expirationDate = expirationDate;
        this.locationID = locationID;
        this.location = location;
        this.stock = stock;
    }

    public int getItemReferenceNumber() { return itemReferenceNumber; }
    public String getCategoryName() { return categoryName; }
    public int getLotNumber() { return lotNumber; }
    public String getItemName() { return itemName; }
    public Date getExpirationDate() { return expirationDate; }
    public int getLocationID() { return locationID; }
    public String getLocation() { return location; }
    public int getStock() { return stock; }

    public void setItemReferenceNumber(int itemReferenceNumber) { this.itemReferenceNumber = itemReferenceNumber; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    public void setLotNumber(int lotNumber) { this.lotNumber = lotNumber; }
    public void setItemName(String itemName) { this.itemName = itemName; }
    public void setExpirationDate(Date expirationDate) { this.expirationDate = expirationDate; }
    public void setLocationID(int locationID) { this.locationID = locationID; }
    public void setLocation(String location) { this.location = location; }
    public void setStock(int stock) { this.stock = stock; }
}