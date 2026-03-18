package backend;

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

    void setLocationID(int locationID) { this.locationID = locationID; }
    void setLotNumber(int lotNumber) { this.lotNumber = lotNumber; }
    void setQuantity(int quantity) { this.quantity = quantity; }
    void setItems(ArrayList<Item> items) { this.items = items; }

    int getLocationID() { return this.locationID; }
    int getLotNumber() { return this.lotNumber; }
    int getQuantity() { return this.quantity; }
    List<Item> getItems() { return this.items; }
}
