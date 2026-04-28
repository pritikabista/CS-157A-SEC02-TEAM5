package com.medicalims.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {

    private static String URL;
    private static String USER;
    private static String PASSWORD;

    static {
        try {
            Properties props = new Properties();

            InputStream input = DBConnection.class
                    .getClassLoader()
                    .getResourceAsStream("db.properties");

            if (input == null) {
                throw new RuntimeException("db.properties file not found in src/main/resources");
            }

            props.load(input);

            URL = props.getProperty("db.url");
            USER = props.getProperty("db.user");
            PASSWORD = props.getProperty("db.password");

        } catch (Exception e) {
            throw new RuntimeException("Failed to load database configuration.", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); //load MySQL driver so that we can talk to database *****
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL Driver not found.", e);
        }

        System.out.println("DB URL: " + URL);
        System.out.println("DB_USER = " + USER);

        return DriverManager.getConnection(URL, USER, PASSWORD);  //create connection  *****
    }
}