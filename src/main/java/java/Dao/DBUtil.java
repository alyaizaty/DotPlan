/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package java.Dao;

/**
 *
 * @author User
 */


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    //dotplan @ DotPlan (web name) that is also name for database
    //private static final String URL = "jdbc:mysql://localhost:3306/DotPlan"; 
    //private static final String USER = "root";
    //private static final String PASSWORD = "admin"; // MySQL password

    // Register dalam environment based on catalina.start
    private static final String URL = System.getenv("URL"); 
    private static final String USER = System.getenv("USER");
    private static final String PASSWORD = System.getenv("admin");

    
    
    public static Connection getConnection() throws SQLException {
        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found", e);
        }

        // Return the connection
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
