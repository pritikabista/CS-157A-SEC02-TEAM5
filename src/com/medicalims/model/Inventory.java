package com.medicalims.model;

public class Inventory {

    private int itemReferenceNumber;   
    private int locationID;
    private String lotNumber;          
    private int quantity;
    private String itemName;           
    private String categoryName;       
    private String expirationDate;     

    public Inventory() {
        this.itemReferenceNumber = 0;
        this.locationID = 0;
        this.lotNumber = "";
        this.quantity = 0;
        this.itemName = "";
        this.categoryName = "";
        this.expirationDate = "";
    }

    public Inventory(int itemReferenceNumber, String itemName, String categoryName,
                     String lotNumber, String expirationDate, int quantity, int locationID) {

        this.itemReferenceNumber = itemReferenceNumber;
        this.itemName = itemName;
        this.categoryName = categoryName;
        this.lotNumber = lotNumber;
        this.expirationDate = expirationDate;
        this.quantity = quantity;
        this.locationID = locationID;
    }

    public int getItemReferenceNumber() {
        return itemReferenceNumber;
    }

    public String getItemName() {
        return itemName;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public String getLotNumber() {
        return lotNumber;
    }

    public String getExpirationDate() {
        return expirationDate;
    }

    public int getQuantity() {
        return quantity;
    }

    public int getLocationID() {
        return locationID;
    }
}