package com.service.Project.Controller;

import com.service.Project.DAO.EmployeeDAO;
import com.service.Project.Model.ComplaintModel;
import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


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

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        EmployeeDAO adminDao = new EmployeeDAO(this.dataSource);

        System.out.println(action);

        if ("update".equals(action)) {
            int complaintId = Integer.parseInt(req.getParameter("complaintId"));
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            String status = req.getParameter("status");
            String remark = req.getParameter("remark");

            ComplaintModel employeeModel = new ComplaintModel();
            employeeModel.setComplaint_id(complaintId);
            employeeModel.setTitle(title);
            employeeModel.setDescription(description);
            employeeModel.setStatus(status);
            employeeModel.setRemark(remark);


            int result = 0;
            try {
                result = adminDao.updateComplaint(employeeModel);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            if (result > 0) {
                req.getSession().setAttribute("msg", "Complaint updated successfully");
            } else {
                req.getSession().setAttribute("msg", "Failed to update complaint");
            }
        } else if ("delete".equals(action)) {
            System.out.println(req.getParameter("complaint_id"));
            int complaintId = Integer.parseInt(req.getParameter("complaint_id"));
            int result = 0;
            try {
                result = adminDao.deleteComplaint(complaintId);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            if (result > 0) {
                req.getSession().setAttribute("msg", "Complaint deleted successfully");
            } else {
                req.getSession().setAttribute("msg", "Failed to delete complaint");
            }
        }
    }
}
