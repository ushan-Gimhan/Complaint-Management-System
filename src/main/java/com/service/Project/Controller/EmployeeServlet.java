package com.service.Project.Controller;

import com.service.Project.DAO.EmployeeDAO;
import com.service.Project.DAO.UserDAO;
import com.service.Project.Model.ComplaintModel; // <-- use correct model
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
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/employee")
public class EmployeeServlet extends HttpServlet {

    @Resource(name = "jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        HttpSession session = req.getSession(false);
        UserModel currentUser = (UserModel) session.getAttribute("user");

        if (currentUser == null || !"employee".equals(currentUser.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/View/Login.jsp");
            return;
        }

        int userId = currentUser.getId();

        List<ComplaintModel> complaints = null;
        try {
            complaints = new EmployeeDAO(dataSource).getComplaintsByUser(userId);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        req.setAttribute("complaints", complaints);

        req.getRequestDispatcher("/View/employee.jsp").forward(req, resp);
    }
}
