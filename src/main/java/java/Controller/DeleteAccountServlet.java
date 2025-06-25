/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.UserDAO;
import Model.User;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class DeleteAccountServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            UserDAO dao = new UserDAO();
            boolean deleted = dao.deleteUserByUsername(user.getUsername());

            if (deleted) {
                session.invalidate(); // Logout user
                // GANTI response.sendRedirect("index.html?deleted=true");
                response.sendRedirect(request.getContextPath() + "/index.html?deleted=true");
            } else {
                request.setAttribute("error", "Account deletion failed. Please try again.");
                request.getRequestDispatcher("/profile.jsp").forward(request, response);
            }
        } else {
            // No user in session — redirect to login or homepage
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/profile.jsp");
    }
}
