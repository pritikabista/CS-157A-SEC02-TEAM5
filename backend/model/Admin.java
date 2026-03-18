package backend.model;

public class Admin extends Account{
    private int departmentID;
    private int officeNum; 

    public Admin(){
        super();
        this.departmentID = 0;
        this.officeNum = 0;
    }

    public Admin(int accountID, String username, String pwdHashed, int departmentID, int officeNum){
        super(accountID, username, pwdHashed);
        this.departmentID = departmentID;
        this.officeNum = officeNum;
    }

    void setDepartmentID(int departmentID) { this.departmentID = departmentID; }
    void setOfficeNum(int officeNum) { this.officeNum = officeNum; }

    int getDepartmentID() { return this.departmentID; }
    int getOfficeNum() { return this.officeNum; }
}
