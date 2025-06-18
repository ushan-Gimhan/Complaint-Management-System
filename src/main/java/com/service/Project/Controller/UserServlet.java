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

            UserDAO userDAO = new UserDAO(this.dataSource);

            UserModel userModel= new UserModel();
            userModel.setUsername(username);
            userModel.setPassword(password);
            userModel.setRole(role);
            userModel.setEmail(email);

            if (userDAO.isUsernameExists(username)) {
                req.getSession().setAttribute("loginMessage", "error");
                req.getRequestDispatcher("View/Signup.jsp").forward(req, resp);
                return;
            }

            boolean result = new UserDAO(this.dataSource).signUp(userModel);

            if (result) {
                req.getSession().setAttribute("loginMessage", "success");
                req.getRequestDispatcher("View/Login.jsp?success=true").forward(req, resp);
            } else {
                req.getSession().setAttribute("loginMessage", "error");
                req.getRequestDispatcher("View/Signup.jsp?success=true").forward(req, resp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            req.getRequestDispatcher("View/Signup.jsp?success=true").forward(req, resp);
        }
    }
}
