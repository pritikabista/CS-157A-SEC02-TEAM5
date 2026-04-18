package com.medicalims.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

import com.medicalims.database.*;
import com.medicalims.model.*;
import com.medicalims.util.HashPw;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) //this request is sending data to the server to be processed
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        //invalid username or password -> return early
        if (password == null || password.isEmpty() || username == null || username.isEmpty()){
            request.setAttribute("error", "Username or Password cannot be null!");
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
            return; 
        }

        AccountDAO accountDAO = new AccountDAO(); 
        Account currAccount = accountDAO.getAccountIfExist(username); //get the account with the username (assuming usernames are unique)

        if (currAccount == null){ //no account with that username
            request.setAttribute("error", "No such account exists!");
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
            return; 
        }

        String hashedPwdFromDatabase = currAccount.getPwdHashed(); //get the account's hashedPwd stored in Database
        if (!HashPw.checkPwd(password, hashedPwdFromDatabase)){ //wrong password
            request.setAttribute("error", "Invalid Username or Password!"); // :)
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
            return; 
        }

        //Check if the current account is user or admin
        UserDAO userDAO = new UserDAO();
        User currUser = userDAO.getUserIfExist(currAccount.getAccountID());
        boolean isAdmin = false;

        Admin currAdmin = null; 

        if (currUser == null){ //rule: every verified account is either a user or an admin
            AdminDAO adminDAO = new AdminDAO();
            currAdmin = adminDAO.getAdminIfExist(currAccount.getAccountID());
            if (currAdmin != null) {isAdmin = true;}
        }

        HttpSession session = request.getSession(); //create session for the logged-in browser or gets the existing one 
        
        session.setAttribute("username", currAccount.getUsername());

        if (isAdmin){ //*****! new attribute added here, this is an Admin Object, see Admin class *****!/
            //key = "admin", value = Admin object 
            session.setAttribute("admin", currAdmin); 
            session.setAttribute("role", "admin");
            response.sendRedirect(request.getContextPath() + "/pages/admin-dashboard.jsp"); //request.getContextPath() starts from webapp root
        }
        else{
            session.setAttribute("user", currUser);
            session.setAttribute("role", "user");
            response.sendRedirect(request.getContextPath() + "/pages/user-dashboard.jsp");
        }
        
        /* 
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", rs.getString("role"));

                response.sendRedirect("/pages/dashboard.jsp");
            } else {
                request.setAttribute("error", "Invalid login.");
                request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
        */
    }
}