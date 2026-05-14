package com.medicalims.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.medicalims.model.Supplier;
import com.medicalims.util.DBConnection;

public class SupplierDAO {

    // GET ALL SUPPLIERS
    public List<Supplier> getAllSuppliers() {

        List<Supplier> suppliers = new ArrayList<>();

        String sql =
            "SELECT Supplier_ID, Phone_Number, Url " +
            "FROM Suppliers";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement stmt = con.prepareStatement(sql);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                int supplierID = rs.getInt("Supplier_ID");

                String phNum = rs.getString("Phone_Number");

                String url = rs.getString("Url");

                Supplier supplier =
                    new Supplier(supplierID, phNum, url);

                suppliers.add(supplier);
            }

            rs.close();
            stmt.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return suppliers;
    }

    // GET SUPPLIER BASED ON APPROVED ORDER
    public Supplier getSupplierByOrderID(int orderID) {

        Supplier supplier = null;

        String sql = "SELECT s.Supplier_ID, s.Phone_Number, s.Url " +
                    "FROM Purchase_orders p " +
                    "JOIN Supplies sp ON p.Item_Reference_Number = sp.Item_Reference_Number " +
                    "JOIN Suppliers s ON sp.Supplier_ID = s.Supplier_ID " +
                    "WHERE p.Order_ID = ?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setInt(1, orderID);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {

                int supplierID = rs.getInt("Supplier_ID");

                String phNum = rs.getString("Phone_Number");

                String url = rs.getString("Url");

                supplier =
                    new Supplier(supplierID, phNum, url);
            }

            rs.close();
            stmt.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return supplier;
    }
}