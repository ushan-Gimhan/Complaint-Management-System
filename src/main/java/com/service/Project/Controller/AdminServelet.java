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

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        HttpSession session = req.getSession();
        session.getAttribute("userId");

        EmployeeDAO adminDao = new EmployeeDAO(this.dataSource);
        System.out.println(action);

        if ("update".equals(action)) {
            int complaintId = Integer.parseInt(req.getParameter("complaintId"));

            String status = req.getParameter("complaintStatus");
            String remark = req.getParameter("adminRemark");

            ComplaintModel employeeModel = new ComplaintModel();
            employeeModel.setComplaint_id(complaintId);
            employeeModel.setStatus(status);
            employeeModel.setRemark(remark);

            int result = 0;
            result = adminDao.updateComplaintByAdmin(employeeModel);
            if (result > 0) {
//                resp.getWriter().println("<script>alert('Complaint updated successfully!'); window.location.href='admin';</script>");
                req.getSession().setAttribute("complaintMessage", "updated");
            } else {
                req.getSession().setAttribute("complaintMessage", "update-error");
            }
        } else if ("delete".equals(action)) {
            System.out.println(req.getParameter("complaintId"));
            int complaintId = Integer.parseInt(req.getParameter("complaintId"));
            int result = 0;
            try {
                result = adminDao.deleteComplaint(complaintId);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            if (result > 0) {
//                resp.getWriter().println("<script>alert('Complaint deleted successfully!'); window.location.href='admin';</script>");
                req.getSession().setAttribute("complaintMessage", "deleted");
            } else {
                req.getSession().setAttribute("complaintMessage", "delete-error");
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin");
    }
}
