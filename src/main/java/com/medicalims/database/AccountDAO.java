package com.medicalims.database;

import java.sql.*; 
import java.util.List;

import com.medicalims.model.Account;

import java.util.ArrayList;

import com.medicalims.util.DBConnection; 
//import com.medicalims.util.HashPw;
import com.medicalims.util.HashPw;

public class AccountDAO {
    
    public List<Account> getAllAccounts(){
        String sql_query = "SELECT * FROM Accounts";

        return executeQuery(sql_query);
    }

    public Account getAccountIfExist(String username){ //for login
        String sql_query = "SELECT * FROM Accounts WHERE username = ?"; //using preparedStatement to avoid SQL injection risk

        List<Account> resultAccount = executeQuery(sql_query, username);
        if (resultAccount.isEmpty()) { //result is empty (no users with that username exists)
            return null;
        }
        return resultAccount.get(0); 
    }

    public boolean usernameAlreadyExists(String username){ //for sign up
        String sql_query = "SELECT * FROM Accounts WHERE username = ?";
        
        if (username == null || username.isEmpty()){ //*
            return true; //don't allow empty username
        }

        List<Account> resultAccount = executeQuery(sql_query, username);

        if (resultAccount.isEmpty()){
            return false; //no such username exists
        }
        return true; //such username exists
    }

    public boolean insertAccount(String username, String pwd){ //call this after checking usernameAlreadyExists and validating username *
        String sql_query = "INSERT INTO Accounts (Username, Pwd_hashed) Values (?, ?)";

        if (pwd == null || pwd.isEmpty() || username == null || username.isEmpty()){
            return false; 
        }
        
        String hashedPw = HashPw.hashedPwd(pwd);
        int result = executeUpdate(sql_query, username, hashedPw);

        if (result == 0){
            return false; //insertion fails
        }
        else{
            return true; //successfully inserted
        }
    }

    //abstraction on loading MySQL Driver, creating DB connection, running SQL query, returning the result as a list
    private List<Account> executeQuery(String sql_query, Object... params){ //Object = variable number of parameters
        List<Account> accounts = new ArrayList<>(); 

        try{
            Connection con = DBConnection.getConnection(); 
            PreparedStatement stmt = con.prepareStatement(sql_query); //SQL Execution //sends SQL *****

            for(int i = 0; i < params.length; i++){
                stmt.setObject(i+1, params[i]);
            }

            ResultSet rs = stmt.executeQuery();

            while(rs.next()){
                int accountID = rs.getInt("Account_ID");
                String username = rs.getString("Username");
                String pwdHashed = rs.getString("Pwd_Hashed");

                accounts.add(new Account(accountID, username, pwdHashed));
            }

            rs.close(); //clean up ***** below
            stmt.close(); 
            con.close(); 

        } catch (Exception e){
            e.printStackTrace(); 
        }
        return accounts;
    } //end of executeQuery()

    private int executeUpdate(String sql_query, Object ... params){
        int rs = 0; //updating fails
        try{
            Connection con = DBConnection.getConnection(); 
            PreparedStatement stmt = con.prepareStatement(sql_query); //SQL Execution //sends SQL *****

            for(int i = 0; i < params.length; i++){
                stmt.setObject(i+1, params[i]);
            }

            rs = stmt.executeUpdate();

            //clean up ***** below
            stmt.close(); 
            con.close(); 
        } catch (Exception e){
            e.printStackTrace(); 
        }
        return rs; //1 -> 1 row inserted, >1 multiple row affected 
    }
}
