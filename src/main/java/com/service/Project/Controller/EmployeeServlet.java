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

                ComplaintModel employeeModel = new ComplaintModel();
                employeeModel.setUser_id(userId);
                employeeModel.setDate(sqlDate);
                employeeModel.setTitle(title);
                employeeModel.setDescription(description);


                int result = employeeDao.addComplain(employeeModel);
                if (result > 0) {
                    req.getSession().setAttribute("complaintMessage", "success");
                } else {
                    req.getSession().setAttribute("complaintMessage", "error");
                }
            } else if ("update".equals(action)) {
                String empIdStr = req.getParameter("complaintId");
                String title = req.getParameter("complaintSubject");
                String description = req.getParameter("complaintDescription");
                String date = req.getParameter("signInDate");
                java.sql.Date sqlDate = java.sql.Date.valueOf(date);

                ComplaintModel employeeModel = new ComplaintModel();
                employeeModel.setComplaint_id(Integer.parseInt(empIdStr));
                employeeModel.setUser_id(userId);
                employeeModel.setDate(sqlDate);
                employeeModel.setTitle(title);
                employeeModel.setDescription(description);

                boolean isPending = employeeDao.checkStatus(Integer.parseInt(empIdStr));

                if (isPending) {
                    req.getSession().setAttribute("complaintMessage", "error");
                    req.setAttribute("message", "This complaint already in resolved state.. you can't update");
                } else {
                    int result = employeeDao.updateComplaint(employeeModel);
                    if (result > 0) {
                        req.getSession().setAttribute("complaintMessage", "updated");
                    } else {
                        req.getSession().setAttribute("complaintMessage", "error-updated");
                    }
                }


            } else if ("delete".equals(action)) {
                int complaintId = Integer.parseInt(req.getParameter("complaintId"));

                boolean isPending = employeeDao.checkStatus(complaintId);

                if (isPending) {
                    req.getSession().setAttribute("complaintMessage", "error");
//                    req.setAttribute("message", "This complaint already in resolved state.. you can't delete");
                } else {
                    int result = employeeDao.deleteComplaint(complaintId);

                    if (result > 0) {
                        req.getSession().setAttribute("complaintMessage", "deleted");
                    } else {
                        req.getSession().setAttribute("complaintMessage", "delete-error");
                    }
                }
            }

//            List<ComplaintModel> list = employeeDao.getComplaintsByUser(userId);
//            req.setAttribute("complaintList", list);
//            req.getRequestDispatcher("View/employee.jsp").forward(req, resp);
            resp.sendRedirect(req.getContextPath() + "/employee");

        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }
    }
}
