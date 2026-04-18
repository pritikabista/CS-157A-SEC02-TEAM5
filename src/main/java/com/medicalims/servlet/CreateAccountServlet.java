package com.medicalims.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

import com.medicalims.database.*;
import com.medicalims.model.*;
import com.medicalims.util.HashPw;

@WebServlet("/create-account")
public class CreateAccountServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String departmentIDString = request.getParameter("departmentId");
        String phNum = request.getParameter("phoneNumber");

        //invalid input -> return early
        if (password == null || password.isEmpty() || username == null || username.isEmpty() || phNum == null || phNum.isEmpty() || departmentIDString == null || departmentIDString.isEmpty()){
            request.setAttribute("error", "Username or Password or Phone Number or Department ID cannot be null!");
            request.getRequestDispatcher("/pages/create-account.jsp").forward(request, response);
            return; 
        }

        int departmentID;
        
        try{
            departmentID = Integer.parseInt(departmentIDString);
        }catch(NumberFormatException e){
            request.setAttribute("error", "Department ID must be an integer!");
            request.getRequestDispatcher("/pages/create-account.jsp").forward(request, response);
            return;
        }

        if (departmentID <= 0){
            request.setAttribute("error", "Invalid Department ID!");
            request.getRequestDispatcher("/pages/create-account.jsp").forward(request, response);
            return; 
        }

        AccountDAO accountDAO = new AccountDAO();
        boolean usernameInvalid = accountDAO.usernameAlreadyExists(username); //invalid if username already exists

        if (usernameInvalid){ //username must be unique
            request.setAttribute("error", "Username already exists!");
            request.getRequestDispatcher("/pages/create-account.jsp").forward(request, response);
            return; 
        }

        String hashedPw = HashPw.hashedPwd(password); // hash the password
        int addedAccountID = accountDAO.insertAccount(username, hashedPw); 

        if (addedAccountID == -1){ //insertion fails
            request.setAttribute("error", "Account Creation fails, please try again!");
            request.getRequestDispatcher("/pages/create-account.jsp").forward(request, response);
            return; 
        }

        //inserted into Accounts table, now insert into Users table
        UserDAO userDAO = new UserDAO();
        boolean addedUser = userDAO.insertUser(addedAccountID, departmentID, phNum);

        if (!addedUser){
            request.setAttribute("error", "Account successful created, adding to the users table fails!"); //for devs only
            request.getRequestDispatcher("/pages/create-account.jsp").forward(request, response);
            return; 
        }

        //successfully added to Users table -> make the user login again
        response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
    
    }
}
