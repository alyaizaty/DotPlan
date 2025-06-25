/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package java.Dao;

import Model.Task;
import Model.User;

import java.sql.*;
import java.util.*;
import Dao.DBUtil;

public class TaskDAO {

    // Insert new Task
    public boolean insertTask(Task t) {
        String sql = "INSERT INTO tasks(user_id, name, start_date, end_date, priority, category, description, done, starred) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, t.getUserId());
            stmt.setString(2, t.getName());
            stmt.setString(3, t.getStartDate());
            stmt.setString(4, t.getEndDate());
            stmt.setString(5, t.getPriority());
            stmt.setString(6, t.getCategory());
            stmt.setString(7, t.getDescription());
            stmt.setBoolean(8, t.isDone());
            stmt.setBoolean(9, t.isStarred());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update Task
    public boolean updateTask(Task t) {
        String sql = "UPDATE tasks SET name=?, start_date=?, end_date=?, priority=?, category=?, description=?, done=?, starred=? WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, t.getName());
            ps.setString(2, t.getStartDate());
            ps.setString(3, t.getEndDate());
            ps.setString(4, t.getPriority());
            ps.setString(5, t.getCategory());
            ps.setString(6, t.getDescription());
            ps.setBoolean(7, t.isDone());
            ps.setBoolean(8, t.isStarred());
            ps.setInt(9, t.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete Task
    public boolean deleteTask(int id) {
        String sql = "DELETE FROM tasks WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Mark Task as Done
    public boolean markDone(int id) {
        String sql = "UPDATE tasks SET done=TRUE WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Mark with star
    public void toggleStar(int id) {
        String sql = "UPDATE tasks SET starred = NOT starred WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Select Tasks (All or by Category)
    public List<Task> selectTasksByUser(int userId, String category) {
        List<Task> list = new ArrayList<>();
        String sql = (category == null || category.equalsIgnoreCase("all"))
                ? "SELECT * FROM tasks WHERE user_id=?"
                : "SELECT * FROM tasks WHERE user_id=? AND category=?";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            if (sql.contains("AND category=?")) {
                ps.setString(2, category);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Task(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDate("start_date").toString(),
                        rs.getDate("end_date").toString(),
                        rs.getString("priority"),
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getBoolean("done"),
                        rs.getBoolean("starred"),
                        rs.getInt("user_id") // Make sure your Task constructor includes this
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // Get Task by ID
    public Task getTaskById(int id) {
        String sql = "SELECT * FROM tasks WHERE id=?";
        Task t = null;

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                t = new Task(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDate("start_date").toString(),
                        rs.getDate("end_date").toString(),
                        rs.getString("priority"),
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getBoolean("done"),
                        rs.getBoolean("starred"),
                        rs.getInt("user_id")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return t;
    }
    
    // FOR reminder.jsp — Fetch important reminder tasks
    public List<Task> getReminderTasks(int userId) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks "
                + "WHERE user_id = ? AND done = false "
                + "AND (starred = true OR end_date <= CURDATE() + INTERVAL 3 DAY) "
                + "ORDER BY end_date ASC";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Task task = new Task(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDate("start_date").toString(),
                        rs.getDate("end_date").toString(),
                        rs.getString("priority"),
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getBoolean("done"),
                        rs.getBoolean("starred"),
                        rs.getInt("user_id")
                );
                tasks.add(task);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tasks;
    }

}
