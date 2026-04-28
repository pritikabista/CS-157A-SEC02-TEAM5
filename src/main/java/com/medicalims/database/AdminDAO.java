package com.medicalims.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.medicalims.model.Admin;
import com.medicalims.util.DBConnection;

public class AdminDAO {

    public Admin getAdminIfExist(int accountID) {
        String sql_query = "SELECT * FROM Admins ad JOIN Accounts acc ON ad.Account_ID = acc.Account_ID " +
                           "WHERE ad.Account_ID = ?";

        List<Admin> resultAdmin = executeQuery(sql_query, accountID);

        if (resultAdmin.isEmpty()) {
            return null;
        }

        return resultAdmin.get(0);
    }

    private List<Admin> executeQuery(String sql_query, Object... params) {
        List<Admin> admins = new ArrayList<>();

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql_query);
        ) {
            for (int i = 0; i < params.length; i++) {
                stmt.setObject(i + 1, params[i]);
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int accountID = rs.getInt("Account_ID");
                int departmentID = rs.getInt("Department_ID");
                String officeNum = rs.getString("Office_Number");
                String username = rs.getString("Username");
                String pwdHashed = rs.getString("Pwd_Hashed");

                admins.add(new Admin(accountID, username, pwdHashed, departmentID, officeNum));
            }

            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return admins;
    }
}