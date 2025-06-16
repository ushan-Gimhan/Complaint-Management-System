package com.service.Project.Controller;

import com.service.Project.DAO.UserDAO;
import com.service.Project.Model.UserModel;
import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/signIn")
public class SignInServlet extends HttpServlet {
    @Resource(name = "jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        UserModel login= new UserDAO(this.dataSource).login(username, password);

        if (login != null) {
            req.getSession().setAttribute("user", login);
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write("Login successful" +
                    "\nWelcome " + login +
                    "\nYour role is " + login.getRole());
            if ("admin".equals(login.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/employee");
            } else if ("employee".equals(login.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/employee");
            }
        } else {
            req.setAttribute("error", "Invalid username or password");
            try {
                req.getRequestDispatcher("view/Login.jsp").forward(req, resp);
            } catch (ServletException e) {
                throw new RuntimeException(e);
            }

        }
    }
}
