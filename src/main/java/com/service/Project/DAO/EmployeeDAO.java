package com.service.Project.DAO;

import com.service.Project.Model.ComplaintModel;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {
    private DataSource dataSource;

    public EmployeeDAO(DataSource dataSource) {
        this.dataSource = dataSource;
    }
    public List<ComplaintModel> getComplaintsByUser(int userId) throws SQLException {
        List<ComplaintModel> list = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM complaints WHERE userID = ?")) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ComplaintModel model = new ComplaintModel();
                    model.setComplaint_id(rs.getInt("id"));
                    model.setUser_id(rs.getInt("userID"));
                    model.setTitle(rs.getString("subject"));
                    model.setDescription(rs.getString("description"));
                    model.setDate(rs.getDate("date"));
                    model.setStatus(rs.getString("status"));
                    model.setRemark(rs.getString("remark"));
                    list.add(model);
                }
            }
        }
        return list;
    }

    public int addComplain(ComplaintModel complaintModel) throws SQLException {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(

                     "INSERT INTO complaints (subject, description, userID,date) VALUES (?, ?, ?,?)")) {

            preparedStatement.setString(1, complaintModel.getTitle());
            preparedStatement.setString(2, complaintModel.getDescription());
            preparedStatement.setInt(3, complaintModel.getUser_id());
            preparedStatement.setDate(4, complaintModel.getDate());
            return preparedStatement.executeUpdate();
        }
    }

    public int updateComplaint(ComplaintModel complaintModel) throws SQLException {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "UPDATE complaints SET subject = ?, description = ? ,date=? WHERE id = ? AND userID = ?")) {
            preparedStatement.setString(1, complaintModel.getTitle());
            preparedStatement.setString(2, complaintModel.getDescription());
            preparedStatement.setString(3, String.valueOf(complaintModel.getDate()));
            preparedStatement.setInt(4, complaintModel.getComplaint_id());
            preparedStatement.setInt(5, complaintModel.getUser_id());
            return preparedStatement.executeUpdate();
        }
    }

    public int deleteComplaint(int complaintId) throws SQLException {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "DELETE FROM complaints WHERE id = ?")) {
            preparedStatement.setInt(1, complaintId);
            return preparedStatement.executeUpdate();
        }
    }
    public boolean checkStatus(int complaintId) throws SQLException {
            try (Connection connection = dataSource.getConnection();
                 PreparedStatement preparedStatement = connection.prepareStatement(
                         "SELECT status FROM complaints WHERE id = ?")) {

                preparedStatement.setInt(1, complaintId);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        String status = resultSet.getString("status");
                        return "RESOLVED".equalsIgnoreCase(status); // Safer string comparison
                    }
                }

            } catch (SQLException e) {
                e.printStackTrace(); // Or log the error
                throw new RuntimeException("Database error while checking complaint status", e);
            }

            return false; // If no result found
        }

    public List<ComplaintModel> getAllComplaints() {
        List<ComplaintModel> list = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM complaints")) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ComplaintModel model = new ComplaintModel();
                    model.setComplaint_id(rs.getInt("id"));
                    model.setUser_id(rs.getInt("userID"));
                    model.setTitle(rs.getString("subject"));
                    model.setDescription(rs.getString("description"));
                    model.setDate(rs.getDate("date"));
                    model.setStatus(rs.getString("status"));
                    model.setRemark(rs.getString("remark"));
                    list.add(model);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public int updateComplaintByAdmin(ComplaintModel complaintModel) {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "UPDATE complaints SET status = ?, remark = ? WHERE id = ?")) {
            preparedStatement.setString(1, complaintModel.getStatus());
            preparedStatement.setString(2, complaintModel.getRemark());
            preparedStatement.setInt(3, complaintModel.getComplaint_id());
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
