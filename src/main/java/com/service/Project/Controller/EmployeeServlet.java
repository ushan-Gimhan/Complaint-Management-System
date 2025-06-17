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
import java.util.Date;
import java.util.List;

@WebServlet("/employee")
public class EmployeeServlet extends HttpServlet {

    @Resource(name = "jdbc/pool")
    private DataSource dataSource;


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        try {
            HttpSession session = req.getSession();
            Integer userId = (Integer) session.getAttribute("userId");
            String userName = (String) session.getAttribute("userName");
            System.out.println(userName);

            if (userId == null) {
                resp.sendRedirect("View/Login.jsp?error=sessionExpired");
                return;
            }
            List<ComplaintModel> list = new EmployeeDAO(dataSource).getComplaintsByUser(userId);
            req.setAttribute("complaintList", list);
            req.getRequestDispatcher("View/employee.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect("View/Login.jsp?error=invalidSessionId");
        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            HttpSession session = req.getSession();
            EmployeeDAO employeeDao = new EmployeeDAO(dataSource);
            Integer userIdObj = (Integer) session.getAttribute("userId");
            if (userIdObj == null) {
                resp.sendRedirect("View/Login.jsp?error=sessionExpired");
                return;
            }
            int userId = userIdObj;

            if ("add".equals(action)) {
                String title = req.getParameter("complaintSubject");
                String description = req.getParameter("complaintDescription");
                String date = req.getParameter("signInDate");
                java.sql.Date sqlDate = java.sql.Date.valueOf(date);
                System.out.println(date);

                ComplaintModel employeeModel = new ComplaintModel();
                employeeModel.setUser_id(userId);
                employeeModel.setDate(sqlDate);
                employeeModel.setTitle(title);
                employeeModel.setDescription(description);


                int result = employeeDao.addComplain(employeeModel);
                if (result > 0) {
                    req.setAttribute("message", "Complain added successfully");
                } else {
                    req.setAttribute("message", "Failed to add complaint");
                }
            } else if ("update".equals(action)) {
                int complaintId = Integer.parseInt(req.getParameter("complaint_id"));
                String title = req.getParameter("title");
                String description = req.getParameter("description");

                ComplaintModel employeeModel = new ComplaintModel();
                employeeModel.setComplaint_id(complaintId);
                employeeModel.setTitle(title);
                employeeModel.setDescription(description);
                employeeModel.setUser_id(userId);

                boolean isPending = employeeDao.checkStatus(complaintId);

                if (isPending) {
                    req.setAttribute("message", "This complaint already in resolved state.. you can't update");
                } else {
                    int result = employeeDao.updateComplaint(employeeModel);
                    if (result > 0) {
                        req.setAttribute("message", "Complaint updated successfully");
                    } else {
                        req.setAttribute("message", "Failed to update complaint");
                    }
                }


            } else if ("delete".equals(action)) {
                int complaintId = Integer.parseInt(req.getParameter("complaint_id"));

                boolean isPending = employeeDao.checkStatus(complaintId);

                if (isPending) {
                    req.setAttribute("message", "This complaint already in resolved state.. you can't delete");
                } else {
                    int result = employeeDao.deleteComplaint(complaintId);

                    if (result > 0) {
                        req.setAttribute("message", "Complaint deleted successfully");
                    } else {
                        req.setAttribute("message", "Failed to delete complaint");
                    }
                }
            }

            List<ComplaintModel> list = employeeDao.getComplaintsByUser(userId);
            req.setAttribute("complaintList", list);
            req.getRequestDispatcher("View/employee.jsp").forward(req, resp);

        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }
    }
}
