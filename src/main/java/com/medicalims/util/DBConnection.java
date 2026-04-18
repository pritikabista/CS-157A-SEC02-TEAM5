package com.medicalims.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/team5?useSSL=false&serverTimezone=UTC"; 
    private static final String USER = "root";
    private static final String PASSWORD = "CS157DeeAein";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); //load MySQL driver so that we can talk to database *****
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL Driver not found.", e);
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);  //create connection  *****
    }
}