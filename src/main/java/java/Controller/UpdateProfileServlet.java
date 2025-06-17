/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package java.Controller;

import java.Dao.UserDAO;
import java.Model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@MultipartConfig
public class UpdateProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            // GANTI response.sendRedirect("login.jsp");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        boolean updatePassword = false;
        boolean changesMade = false;

        if (username != null && !username.equals(user.getUsername())) {
            user.setUsername(username);
            changesMade = true;
        }

        if (password != null && !password.isEmpty()) {
            if (!password.equals(confirmPassword)) {
                session.setAttribute("error", "Passwords do not match.");
                // GANTI response.sendRedirect("profile.jsp");
                response.sendRedirect(request.getContextPath() + "/profile.jsp");
                return;
            }
            user.setPassword(password);
            updatePassword = true;
            changesMade = true;
        }

        // Handle profile picture
        Part filePart = request.getPart("profilePic");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        if (fileName != null && !fileName.isEmpty()) {
            String uploadPath = getServletContext().getRealPath("/") + "profile-pics";
            // CAN TRY THIS TOO: String uploadPath = getServletContext().getRealPath("/profile-pics");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            filePart.write(uploadPath + File.separator + fileName);

            user.setProfilePic(fileName);
            changesMade = true;
        }

        // Fallback default image
        if (user.getProfilePic() == null || user.getProfilePic().isEmpty()) {
            user.setProfilePic("userDefault.png");
        }

        if (changesMade) {
            UserDAO dao = new UserDAO();
            boolean success = dao.updateUserProfile(user, updatePassword);

            if (success) {
                // Fetch the fully updated user again from DB (including fresh profile_pic)
                User updatedUser = dao.getUserByUsername(user.getUsername());
                session.setAttribute("user", updatedUser); // Ubah sikit
                session.setAttribute("successMessage", "Profile updated successfully!");
            } else {
                session.setAttribute("errorMessage", "Update failed. Try again.");
            }
        } else {
            session.setAttribute("successMessage", "No changes were made.");
        }

        // GANTI response.sendRedirect("profile.jsp");
        response.sendRedirect(request.getContextPath() + "/profile.jsp");

    }
}
