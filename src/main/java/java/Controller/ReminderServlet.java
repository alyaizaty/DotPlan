/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package java.Controller;

import java.Dao.TaskDAO;
import Model.Task;
import Model.User;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ReminderServlet extends HttpServlet {

    // GET: Load important/starred tasks for reminder.jsp
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Redirect to login if not logged in
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getId(); // Use user's ID

        TaskDAO taskDAO = new TaskDAO();
        try {
            List<Task> tasks = taskDAO.getReminderTasks(userId); // Only starred/important tasks
            request.setAttribute("tasks", tasks);
            request.getRequestDispatcher("reminder.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    // Mark task as done from reminder page
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id"); // Match the name used in reminder.jsp

        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int taskId = Integer.parseInt(idParam);

                TaskDAO taskDAO = new TaskDAO();
                taskDAO.markDone(taskId);

                response.sendRedirect("ReminderServlet");
            } catch (NumberFormatException e) {
                throw new ServletException("Invalid task ID format", e);
            } catch (Exception e) {
                throw new ServletException("Error marking task as done", e);
            }
        } else {
            throw new ServletException("Missing task ID");
        }
    }

}
