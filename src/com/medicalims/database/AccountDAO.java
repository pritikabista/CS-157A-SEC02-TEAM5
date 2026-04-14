package com.medicalims.database;

import com.medicalims.model.Account; 
import java.sql.*; 
import java.util.List; 
import java.util.ArrayList;


public class AccountDAO {
    
    private final String url = "jdbc:mysql://localhost:3306/team5?useSSL=false&serverTimezone=UTC"; 
    private final String user = "root";
    private final String password = "CS157DeeAein"; 

    public List<Account> getAllAccounts(){
        String sql_query = "SELECT * FROM Accounts";
        return executeQuery(sql_query);
    }

    public Account getAccountIfExist(String username, String pwdHashed){ //for login feature
        if (pwdHashed.isEmpty()){
            return null; 
        }

        String sql_query = "SELECT * FROM Accounts WHERE username = ?"; //using preparedStatement to avoid SQL injection risk
        List<Account> resultAccount = executeQuery(sql_query, username);

        //result is empty (no users with that username exists)
        if (resultAccount.isEmpty()) { 
            return null;
        }

        //confirm the pwd matches *****assuming username is unique //Java Serverlet should handle this logic instead 
        if (resultAccount.get(0).getPwdHashed().equals(pwdHashed)){
            return resultAccount.get(0);
        }

        return null; //pwd don't match
    }

    //abstraction on loading MySQL Driver, creating DB connection, running SQL query, returning the result as a list
    private List<Account> executeQuery(String sql_query, Object... params){ //Object = variable number of parameters
        List<Account> accounts = new ArrayList<>(); 

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");  //load MySQL driver so that we can talk to database *****

            Connection con = DriverManager.getConnection(url, user, password); //create connection  *****
            PreparedStatement stmt = con.prepareStatement(sql_query); //SQL Execution //sends SQL *****

            for(int i = 0; i < params.length; i++){
                stmt.setObject(i+1, params[i]);
            }

            ResultSet rs = stmt.executeQuery();

            while(rs.next()){
                int accountID = rs.getInt("Account_ID");
                String username = rs.getString("Username");
                String pwdHashed = rs.getString("Pwd_hashed");

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
}
