package com.medicalims.model;

public class User extends Account {
    private int departmentID;
    private String phNum; 

    public User(){
        super();
        this.departmentID = 0;
        this.phNum = "";
    }

    public User(int accountID, String username, String pwdHashed, int departmentID, String phNum){
        super(accountID, username, pwdHashed);
        this.departmentID = departmentID;
        this.phNum = phNum;
    }

    void setDepartmentID(int departmentID) { this.departmentID = departmentID; }
    void setPhNum(String phNum) { this.phNum = phNum; }

    public int getDepartmentID() { return this.departmentID; }
    public String getPhNum() { return this.phNum; }
}
