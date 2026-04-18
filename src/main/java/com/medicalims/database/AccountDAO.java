package com.medicalims.database;

import java.sql.*; 
import java.util.List;

import com.medicalims.model.Account;

import java.util.ArrayList;

import com.medicalims.util.DBConnection; 

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
        
        List<Account> resultAccount = executeQuery(sql_query, username);
        if (resultAccount.isEmpty()){
            return false; //no such username exists
        }
        return true; //such username exists
    }

    public int insertAccount(String username, String hashedPw){ //call this after checking usernameAlreadyExists and validating username *
        String sql_query = "INSERT INTO Accounts (Username, Pwd_hashed) Values (?, ?)";

        int accountID = executeInsertion(sql_query, username, hashedPw);

        return accountID; //-1 if insertion fails, accountID if inserted
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

    private int executeInsertion(String sql_query, Object ... params){
        int generatedKey = -1; //insering a new account fails
        try{
            Connection con = DBConnection.getConnection(); 
            PreparedStatement stmt = con.prepareStatement(sql_query, PreparedStatement.RETURN_GENERATED_KEYS); //SQL Execution // after excuting INSERT, get the auto-generated alues (AUTO_INCREMENT PK)

            for(int i = 0; i < params.length; i++){
                stmt.setObject(i+1, params[i]);
            }

            int rowsAffected = stmt.executeUpdate(); //1 = 1 row inserted, 0 = insertion fails

            if(rowsAffected > 0){ //successfully inserted
                ResultSet rs = stmt.getGeneratedKeys(); //get the auto-incremented accountID back (to use this to add the account to users)
                if (rs.next()) { //read the key
                    generatedKey = rs.getInt(1);
                }
                rs.close();
            }

            stmt.close();  //clean up ***** below
            con.close(); 
        } catch (Exception e){
            e.printStackTrace(); 
        }
        return generatedKey; //if -1, not inserted, else return account_ID
    }
}
