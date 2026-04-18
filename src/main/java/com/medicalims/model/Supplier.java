package main.java.com.medicalims.model;

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

    void setSupplierID(int supplierID) { this.supplierID = supplierID; }
    void setPhNum(String phNum) { this.phNum = phNum; }
    void setUrl(String url) { this.url = url; }

    int getSupplierID() { return this.supplierID; }
    String getPhNum() { return this.phNum; }
    String getUrl() { return this.url; }
}