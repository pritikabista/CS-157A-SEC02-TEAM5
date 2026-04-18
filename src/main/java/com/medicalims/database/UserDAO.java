package com.medicalims.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.medicalims.model.User;
import com.medicalims.util.*;

public class UserDAO {


    public User getUserIfExist(int accountID){ //has to use JOIN because my User Object is a subclass of Account and constructor needs username and password hashed but Users table don't have them
        String sql_query = "SELECT U.Account_ID, U.Department_ID, U.Phone_Number, ACC.Username, ACC.Pwd_Hashed FROM Users U JOIN Accounts ACC ON U.Account_ID = ACC.Account_ID WHERE U.Account_ID = ?";
        List<User> resultUser = executeQuery(sql_query, accountID);
        
        if(resultUser.isEmpty()){
            return null; 
        }
        return resultUser.get(0); 
    }

    public boolean insertUser(int accountID, int departmentID, String phNum){
        String sql_query = "INSERT INTO Users (Account_ID, Department_ID, Phone_Number) VALUES (? ,? ,?)";
        return executeInsertion(sql_query, accountID, departmentID, phNum);
    }

    private List<User> executeQuery(String sql_query, Object... params){ 
        List<User> users = new ArrayList<>(); 

        try{
            Connection con = DBConnection.getConnection(); //create connection  *****
            PreparedStatement stmt = con.prepareStatement(sql_query); //SQL Execution //sends SQL *****

            for(int i = 0; i < params.length; i++){
                stmt.setObject(i+1, params[i]);
            }

            ResultSet rs = stmt.executeQuery();

            while(rs.next()){
                int accountID = rs.getInt("Account_ID");
                int departmentID = rs.getInt("Department_ID");
                String phNum = rs.getString("Phone_Number");

                String username = rs.getString("Username");
                String pwdHashed = rs.getString("Pwd_Hashed");


                users.add(new User(accountID, username, pwdHashed, departmentID, phNum));
            }

            rs.close(); //clean up ***** below
            stmt.close(); 
            con.close(); 

        } catch (Exception e){
            e.printStackTrace(); 
        }
        return  users;
    } //end of executeQuery()

    private boolean executeInsertion(String sql_query, Object ... params){
        boolean succssfulInsertion = false;

        try{
            Connection con = DBConnection.getConnection(); 
            PreparedStatement stmt = con.prepareStatement(sql_query); //SQL Execution

            for(int i = 0; i < params.length; i++){
                stmt.setObject(i+1, params[i]);
            }

            int rowsAffected = stmt.executeUpdate(); //1 = 1 row inserted, 0 = insertion fails

            if(rowsAffected > 0){ //successfully inserted
                succssfulInsertion = true;
            }

            stmt.close();  //clean up ***** below
            con.close(); 
        } catch (Exception e){
            e.printStackTrace(); 
        }
        return succssfulInsertion; 
    }

}
