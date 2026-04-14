package com.medicalims.model;

public class Item {

    private int itemReferenceNumber;
    private int categoryID;
    private String itemName;
    private String expirationDate;

    public Item() {
        this.itemReferenceNumber = 0;
        this.categoryID = 0;
        this.itemName = "";
        this.expirationDate = "";
    }

    public Item(int itemReferenceNumber, int categoryID,
                String itemName, String expirationDate) {

        this.itemReferenceNumber = itemReferenceNumber;
        this.categoryID = categoryID;
        this.itemName = itemName;
        this.expirationDate = expirationDate;
    }

    public int getItemReferenceNumber() {
        return itemReferenceNumber;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public String getItemName() {
        return itemName;
    }

    public String getExpirationDate() {
        return expirationDate;
    }
}