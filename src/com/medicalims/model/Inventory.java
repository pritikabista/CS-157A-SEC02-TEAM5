package com.medicalims.model;

import java.util.List;
import java.util.ArrayList;

public class Inventory {

    private int locationID;
    private int lotNumber;
    private int quantity;
    private List<Item> items;

    public Inventory() {
        this.locationID = 0;
        this.lotNumber = 0;
        this.quantity = 0;
        this.items = new ArrayList<>();
    }

    public Inventory(int locationID, int lotNumber, int quantity, ArrayList<Item> items) {
        this.locationID = locationID;
        this.lotNumber = lotNumber;
        this.quantity = quantity;
        this.items = items;
    }
    
    // Append
    public void addItem(Item item, int amount) {
        if (amount <= 0) {
            System.out.println("Invalid amount.");
            return;
        }

        items.add(item);
        quantity += amount;
        System.out.println("Item added. Quantity: " + quantity);
    }

    // Withdraw
    public boolean removeItem(Item item, int amount) {
        if (amount <= 0) {
            System.out.println("Invalid amount.");
            return false;
        }

        if (!items.contains(item)) {
            System.out.println("Item not found in inventory.");
            return false;
        }

        if (quantity < amount) {
            System.out.println("Not enough stock.");
            return false;
        }

        quantity -= amount;

        if (quantity == 0) {
            items.remove(item);
        }

        System.out.println("Item removed. Quantity: " + quantity);
        return true;
    }


    // Check current stock
    public int checkStock() {
        return quantity;
    }

    void setLocationID(int locationID) { this.locationID = locationID; }
    void setLotNumber(int lotNumber) { this.lotNumber = lotNumber; }
    void setQuantity(int quantity) { this.quantity = quantity; }
    void setItems(ArrayList<Item> items) { this.items = items; }

    int getLocationID() { return this.locationID; }
    int getLotNumber() { return this.lotNumber; }
    int getQuantity() { return this.quantity; }
    List<Item> getItems() { return this.items; }
}
