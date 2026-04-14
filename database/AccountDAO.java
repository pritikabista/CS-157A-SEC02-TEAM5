package database;

import backend.model.Account; 
import java.sql.*; 
import java.util.List; 
import java.util.ArrayList;


public class AccountDAO {
    
    private final String url = "jdbc:mysql://localhost:3306/team5?useSSL=false&serverTimezone=UTC"; 
    private final String user = "root";
    private final String passowrd = "CS157DeeAein"; 

    public List<Account> getAllAccounts(){
        List<Account> accounts = new ArrayList<>(); 

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");  //load MySQL driver so that we can talk to database *****

            Connection con = DriverManager.getConnection(url, user, passowrd); //create connection  *****

            String sql_query = "SELECT * FROM Accoounts";
            Statement stmt = con.createStatement(); //SQL Execution //sends SQL *****
            ResultSet rs = stmt.executeQuery(sql_query);


        } catch (Exception e){
            e.printStackTrace(); 
        }

        return accounts;
    }
}
