package com.medicalims.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.medicalims.model.Account;
import com.medicalims.util.DBConnection;

public class AccountDAO {

    public List<Account> getAllAccounts() {
        String sql_query = "SELECT * FROM Accounts";
        return executeQuery(sql_query);
    }

    public Account getAccountIfExist(String username) {
        String sql_query = "SELECT * FROM Accounts WHERE LOWER(TRIM(Username)) = LOWER(TRIM(?))";

        List<Account> resultAccount = executeQuery(sql_query, username);
        if (resultAccount.isEmpty()) {
            return null;
        }
        return resultAccount.get(0);
    }

    public boolean usernameAlreadyExists(String username) {
        String sql_query = "SELECT * FROM Accounts WHERE LOWER(TRIM(Username)) = LOWER(TRIM(?))";

        List<Account> resultAccount = executeQuery(sql_query, username);
        return !resultAccount.isEmpty();
    }

    public int insertAccount(String username, String hashedPw) {
        String sql_query = "INSERT INTO Accounts (Username, Pwd_Hashed) VALUES (?, ?)";
        return executeInsertion(sql_query, username, hashedPw);
    }

    private List<Account> executeQuery(String sql_query, Object... params) {
        List<Account> accounts = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql_query);

            for (int i = 0; i < params.length; i++) {
                stmt.setObject(i + 1, params[i]);
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int accountID = rs.getInt("Account_ID");
                String username = rs.getString("Username");
                String pwdHashed = rs.getString("Pwd_Hashed");

                accounts.add(new Account(accountID, username, pwdHashed));
            }

            rs.close();
            stmt.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return accounts;
    }

    private int executeInsertion(String sql_query, Object... params) {
        int generatedKey = -1;

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement stmt = con.prepareStatement(
                sql_query,
                Statement.RETURN_GENERATED_KEYS
            );

            for (int i = 0; i < params.length; i++) {
                stmt.setObject(i + 1, params[i]);
            }

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                ResultSet rs = stmt.getGeneratedKeys();

                if (rs.next()) {
                    generatedKey = rs.getInt(1);
                }

                rs.close();
            }

            stmt.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return generatedKey;
    }
}