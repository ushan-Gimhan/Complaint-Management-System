package com.service.Project.Controller;

import com.service.Project.DAO.EmployeeDAO;
import com.service.Project.Model.ComplaintModel;
import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin")
public class AdminServelet extends HttpServlet {
    @Resource(name = "jdbc/pool")
    private DataSource dataSource;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<ComplaintModel> list = new EmployeeDAO(dataSource).getAllComplaints();
            req.setAttribute("complaintList", list);
            req.getRequestDispatcher("View/admin.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect("View/Login.jsp?error=invalidSessionId");
        }
    }
}
