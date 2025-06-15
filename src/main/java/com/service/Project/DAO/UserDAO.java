package com.service.Project.DAO;

import com.service.Project.Model.UserModel;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UserDAO {
    private DataSource dataSource;

    public UserDAO(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public boolean signUp(UserModel user) throws SQLException {
        Connection conn = dataSource.getConnection();
        PreparedStatement preparedStatement = conn.prepareStatement(
                "INSERT INTO users (name, password, email, role) VALUES (?, ?, ?, ?)"
        );
        preparedStatement.setString(1, user.getUsername());
        preparedStatement.setString(2, user.getPassword());
        preparedStatement.setString(3, user.getEmail());
        preparedStatement.setString(4, user.getRole());
        preparedStatement.executeUpdate();
        return true;


    }
}
