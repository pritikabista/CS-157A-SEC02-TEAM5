package com.medicalims.model;

import java.sql.Date;

public class Item {

    private int itemReferenceNumber;
    private int categoryID;
    private int lotNumber;
    private String itemName;
    private Date expirationDate;

    public Item() {
        this.itemReferenceNumber = 0;
        this.categoryID = 0;
        this.lotNumber = 0;
        this.itemName = "";
        this.expirationDate = null;
    }

    public Item(int itemReferenceNumber, int categoryID,
                int lotNumber, String itemName, Date expirationDate) {

        this.itemReferenceNumber = itemReferenceNumber;
        this.categoryID = categoryID;
        this.lotNumber = lotNumber;
        this.itemName = itemName;
        this.expirationDate = expirationDate;
    }

    public int getItemReferenceNumber() { return itemReferenceNumber; }
    public int getCategoryID() { return categoryID; }
    public int getLotNumber() { return lotNumber; }
    public String getItemName() { return itemName; }
    public Date getExpirationDate() { return expirationDate; }

    public void setItemReferenceNumber(int itemReferenceNumber) { this.itemReferenceNumber = itemReferenceNumber; }
    public void setCategoryID(int categoryID) { this.categoryID = categoryID; }
    public void setLotNumber(int lotNumber) { this.lotNumber = lotNumber; }
    public void setItemName(String itemName) { this.itemName = itemName; }
    public void setExpirationDate(Date expirationDate) { this.expirationDate = expirationDate; }
}