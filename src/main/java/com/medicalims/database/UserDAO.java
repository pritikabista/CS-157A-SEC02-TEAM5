package main.java.com.medicalims.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import main.java.com.medicalims.model.User;

public class UserDAO {
    private final String url = "jdbc:mysql://localhost:3306/team5?useSSL=false&serverTimezone=UTC"; 
    private final String user = "root";
    private final String password = "CS157DeeAein"; 

    public User getUserIfExist(int accountID){
        String sql_query = "SELECT * FROM Users U JOIN Accounts A ON U.Account_ID = A.Account_ID WHERE A.Account_ID = ?";
        List<User> resultUser = executeQuery(sql_query, accountID);
        
        if(resultUser.isEmpty()){
            return null; 
        }
        return resultUser.get(0); 
    }

    private List<User> executeQuery(String sql_query, Object... params){ 
        List<User> users = new ArrayList<>(); 

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
                String username = rs.getString("Username");
                String pwdHashed = rs.getString("Pwd_hashed");
                String phNum = rs.getString("Phone_Number");


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

}
