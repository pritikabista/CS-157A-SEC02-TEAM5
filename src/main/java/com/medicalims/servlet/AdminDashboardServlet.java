package com.medicalims.servlet;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

import com.medicalims.model.*;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        HttpSession session = request.getSession(false);

        if (session == null){
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        Admin admin = (Admin) session.getAttribute("admin"); 

        if(admin == null){
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        request.getRequestDispatcher("/pages/admin-dashboard.jsp").forward(request, response);
    }
}
