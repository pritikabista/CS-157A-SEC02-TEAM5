package backend.model;

class Account{
    private int accountID;
    private String username; 
    private String pwdHashed;

    Account(){
        this.accountID = 0;
        this.username = null;
        this.pwdHashed = null;
    }
    Account(int accountID, String username, String pwdHashed){
        this.accountID = accountID;
        this.username = username;
        this.pwdHashed = pwdHashed;
    }

    void setAccountID(int accountID){ this.accountID = accountID; }
    void setUsername(String username) {this.username = username; }
    void setpwdHashed(String pwdHashed) { this.pwdHashed = pwdHashed; }

    int getAccountID() { return this.accountID; }
    String getUsername() { return this.username; }
    String getPwdHashed() { return this.pwdHashed; }
}


