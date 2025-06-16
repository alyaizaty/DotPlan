/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.UserDAO;
import Model.User;

import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

//@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Debug: Print received values
        System.out.println("Received signup request:");
        System.out.println("Username: " + username);
        System.out.println("Email: " + email);
        System.out.println("Password: " + password);

        User user = new User(username, email, password);
        UserDAO userDAO = new UserDAO();

        // Check if username already exists
        if (userDAO.usernameExists(username)) {
            System.out.println("Username already exists: " + username);
            // Error if already exists
            request.setAttribute("errorMessage", "Username already exists!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } else {
            // Display message if successfuly registered
            boolean success = userDAO.registerUser(user);
            System.out.println("Register success: " + success);

            // Bring to login page
            if (success) {
                //break out of the iframe
                response.setContentType("text/html");
                //GANTI BARU response.getWriter().println("<script>window.top.location.href='login.jsp';</script>");
                response.sendRedirect(request.getContextPath() + "/login.jsp");

            } else {
                System.out.println("Failed to register user: " + username);
                request.setAttribute("errorMessage", "Signup failed. Try again.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // GANTI BARU response.sendRedirect("signup.jsp");
        response.sendRedirect(request.getContextPath() + "/signup.jsp");

    }
}
