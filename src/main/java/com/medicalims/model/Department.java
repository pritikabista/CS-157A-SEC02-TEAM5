package com.medicalims.model;

public class Department {
    private int departmentID;
    private String departmentName; 

    public Department(){
        this.departmentID = 0;
        this.departmentName = null;
    }

    public Department(int departmentID, String departmentName){
        this.departmentID = departmentID;
        this.departmentName = departmentName; 
    }

    void setDepartmentID(int departmentID) { this.departmentID = departmentID; }
    void setDepartmentName(String departmentName) { this.departmentName = departmentName; }

    int getDepartmentID() { return this.departmentID; }
    String getDepartmentName() { return this.departmentName; }
    
}
