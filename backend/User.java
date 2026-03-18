package backend;

public class User extends Account {
    private int departmentID;
    private int phNum; 

    public User(){
        super();
        this.departmentID = 0;
        this.phNum = 0;
    }

    public User(int accountID, String username, String pwdHashed, int departmentID, int phNum){
        super(accountID, username, pwdHashed);
        this.departmentID = departmentID;
        this.phNum = phNum;
    }

    void setDepartmentID(int departmentID) { this.departmentID = departmentID; }
    void setPhNum(int phNum) { this.phNum = phNum; }

    int getDepartmentID() { return this.departmentID; }
    int getPhNum() { return this.phNum; }
}
