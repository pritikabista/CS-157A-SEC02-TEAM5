package com.medicalims.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.medicalims.model.Inventory;
import com.medicalims.util.DBConnection;

@WebServlet("/inventory")
public class InventoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String search = request.getParameter("search");
        if (search == null) {
            search = "";
        }

        List<Inventory> inventoryList = new ArrayList<>();

        String sql =
        		"SELECT i.item_reference_number, i.item_name, c.category_name, " +
        	    "       inv.lot_number, i.expiration_date, inv.quantity, inv.location_id " +
        	    "FROM items i, categories c, inventory inv " +
        	    "WHERE i.category_id = c.category_id " +
        	    "  AND i.item_reference_number = inv.item_reference_number " +
        	    "  AND (i.item_name LIKE ? " +
        	    "   OR CAST(i.item_reference_number AS CHAR) LIKE ? " +
        	    "   OR inv.lot_number LIKE ? " +
        	    "   OR c.category_name LIKE ?) " +
        	    "ORDER BY i.item_name ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String keyword = "%" + search + "%";
            stmt.setString(1, keyword);
            stmt.setString(2, keyword);
            stmt.setString(3, keyword);
            stmt.setString(4, keyword);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Inventory item = new Inventory(
                        rs.getInt("item_reference_number"),
                        rs.getString("item_name"),
                        rs.getString("category_name"),
                        rs.getString("lot_number"),
                        rs.getString("expiration_date"),
                        rs.getInt("quantity"),
                        rs.getInt("location_id")
                    );
                    inventoryList.add(item);
                }
            }

            request.setAttribute("inventoryList", inventoryList);
            request.setAttribute("search", search);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading inventory: " + e.getMessage());
        }

        request.getRequestDispatcher("/inventory.jsp").forward(request, response);
    }
}