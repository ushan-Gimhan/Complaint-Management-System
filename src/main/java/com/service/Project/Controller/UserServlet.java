package com.service.Project.Controller;

import com.service.Project.DAO.UserDAO;
import com.service.Project.Model.UserModel;
import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
    @Resource(name = "jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String username = req.getParameter("firstName");
            String password = req.getParameter("password");
            String role = req.getParameter("roleSelect");
            String email = req.getParameter("email");

            UserModel userModel = new UserModel();
            userModel.setUsername(username);
            userModel.setPassword(password);
            userModel.setRole(role);
            userModel.setEmail(email);
            System.out.println(username);
            System.out.println(password);
            System.out.println(role);
            System.out.println(email);


            boolean result = new UserDAO(this.dataSource).signUp(userModel);


            if (result) {
//            response.sendRedirect(request.getContextPath() + "/View/signin.jsp?success=true");
                req.getRequestDispatcher("View/Login.jsp?success=true").forward(req, resp);
            } else {
//            response.sendRedirect(request.getContextPath() + "/View/signup.jsp?success=true");
                req.getRequestDispatcher("View/Signup.jsp?success=true").forward(req, resp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
//            response.sendRedirect(request.getContextPath() + "/View/signup.jsp?success=true");
            req.getRequestDispatcher("View/signup.jsp?success=true").forward(req, resp);
        }
    }
}
