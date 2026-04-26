package com.medicalims.model;

public class Inventory {

    private int locationID;
    private int itemReferenceNumber;
    private int stock;

    public Inventory() {
        this.locationID = 0;
        this.itemReferenceNumber = 0;
        this.stock = 0;
    }

    public Inventory(int locationID, int itemReferenceNumber, int stock) {
        this.locationID = locationID;
        this.itemReferenceNumber = itemReferenceNumber;
        this.stock = stock;
    }

    public int getLocationID() { return locationID; }
    public int getItemReferenceNumber() { return itemReferenceNumber; }
    public int getStock() { return stock; }

    public void setLocationID(int locationID) { this.locationID = locationID; }
    public void setItemReferenceNumber(int itemReferenceNumber) { this.itemReferenceNumber = itemReferenceNumber; }
    public void setStock(int stock) { this.stock = stock; }
}