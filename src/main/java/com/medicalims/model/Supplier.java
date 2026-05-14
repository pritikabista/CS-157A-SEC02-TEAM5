package com.medicalims.model;

public class Supplier {

    private int supplierID;
    private String phNum;
    private String url;

    public Supplier() {
        this.supplierID = 0;
        this.phNum = "";
        this.url = "";
    }

    public Supplier(int supplierID, String phNum, String url) {
        this.supplierID = supplierID;
        this.phNum = phNum;
        this.url = url;
    }

    public void setSupplierID(int supplierID) {
        this.supplierID = supplierID;
    }

    public void setPhNum(String phNum) {
        this.phNum = phNum;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getSupplierID() {
        return this.supplierID;
    }

    public String getPhNum() {
        return this.phNum;
    }

    public String getUrl() {
        return this.url;
    }
}