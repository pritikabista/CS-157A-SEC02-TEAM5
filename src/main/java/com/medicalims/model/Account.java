package main.java.com.medicalims.model;

public class Account{
    private int accountID;
    private String username; 
    private String pwdHashed;

    public Account(){
        this.accountID = 0;
        this.username = null;
        this.pwdHashed = null;
    }
    public Account(int accountID, String username, String pwdHashed){
        this.accountID = accountID;
        this.username = username;
        this.pwdHashed = pwdHashed;
    }

    public void setAccountID(int accountID){ this.accountID = accountID; }
    public void setUsername(String username) {this.username = username; }
    public void setpwdHashed(String pwdHashed) { this.pwdHashed = pwdHashed; }

    public int getAccountID() { return this.accountID; }
    public String getUsername() { return this.username; }
    public String getPwdHashed() { return this.pwdHashed; }
}


