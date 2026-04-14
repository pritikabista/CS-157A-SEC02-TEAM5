package com.medicalims.model;

public class Location {

    private int locationID;
    private int roomNumber;
    private int buildingNumber;

    public Location() {
        this.locationID = 0;
        this.roomNumber = 0;
        this.buildingNumber = 0;
    }

    public Location(int locationID, int roomNumber, int buildingNumber) {
        this.locationID = locationID;
        this.roomNumber = roomNumber;
        this.buildingNumber = buildingNumber;
    }

    void setLocationID(int locationID) { this.locationID = locationID; }
    void setRoomNumber(int roomNumber) { this.roomNumber = roomNumber; }
    void setBuildingNumber(int buildingNumber) { this.buildingNumber = buildingNumber; }

    int getLocationID() { return this.locationID; }
    int getRoomNumber() { return this.roomNumber; }
    int getBuildingNumber() { return this.buildingNumber; }
}