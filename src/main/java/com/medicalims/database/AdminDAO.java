package com.medicalims.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.medicalims.model.Admin;

public class AdminDAO {
    private final String url = "jdbc:mysql://localhost:3306/team5?useSSL=false&serverTimezone=UTC"; 
    private final String user = "root";
    private final String password = "CS157DeeAein"; 


    public Admin getAdminIfExist(int accountID){
        String sql_query = "SELECT * FROM Admins ad JOIN Accounts acc ON ad.Account_ID = acc.Account_ID " +
                            "WHERE ad.Account_ID = ?";

        List<Admin> resultAdmin = executeQuery(sql_query, accountID);

        if (resultAdmin.isEmpty()){ //this account is not an admin
            return null; 
        }
        return resultAdmin.get(0);
    }     

    private List<Admin> executeQuery(String sql_query, Object... params){ 
        List<Admin> admins = new ArrayList<>(); 

        try{
            Class.forName("com.mysql.cj.jdbc.Driver"); 

            Connection con = DriverManager.getConnection(url, user, password); //create connection  *****
            PreparedStatement stmt = con.prepareStatement(sql_query); //SQL Execution //sends SQL *****

            for(int i = 0; i < params.length; i++){
                stmt.setObject(i+1, params[i]);
            }

            ResultSet rs = stmt.executeQuery();

            while(rs.next()){
                int accountID = rs.getInt("Account_ID");
                int departmentID = rs.getInt("Department_ID");
                String officeNum = rs.getString("Office_Number");
                String username = rs.getString("Username");
                String pwdHashed = rs.getString("Pwd_hashed");


                admins.add(new Admin(accountID, username, pwdHashed, departmentID, officeNum));
            }
            
            rs.close(); //clean up ***** below
            stmt.close(); 
            con.close(); 

        } catch (Exception e){
            e.printStackTrace(); 
        }
        return admins;
    } //end of executeQuery()

}
