package com.medicalims.model;

public class Admin extends Account{
    private int departmentID;
    private String officeNum; 

    public Admin(){
        super();
        this.departmentID = 0;
        this.officeNum = "";
    }

    public Admin(int accountID, String username, String pwdHashed, int departmentID, String officeNum){
        super(accountID, username, pwdHashed);
        this.departmentID = departmentID;
        this.officeNum = officeNum;
    }

    void setDepartmentID(int departmentID) { this.departmentID = departmentID; }
    void setOfficeNum(String officeNum) { this.officeNum = officeNum; }

    int getDepartmentID() { return this.departmentID; }
    String getOfficeNum() { return this.officeNum; }
}