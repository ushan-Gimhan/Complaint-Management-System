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
                    model.setTitle(rs.getString("date"));
                    model.setDescription(rs.getString("description"));
                    model.setStatus(rs.getString("status"));
                    model.setRemark(rs.getString("remark"));
                    list.add(model);
                }
            }
        }
        return list;
    }
}
