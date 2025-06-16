/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package java.Controller;

import java.Dao.TaskDAO;
import java.Model.Task;


import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

public class TaskActionServlet extends HttpServlet {

    private TaskDAO dao;

    @Override
    public void init() throws ServletException {
        dao = new TaskDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String idParam = req.getParameter("id");
        String cat = req.getParameter("category");

        if (idParam == null || idParam.isEmpty()) {
            // GANTI resp.sendRedirect("tasks");
            resp.sendRedirect(req.getContextPath() + "/tasks");

            return;
        }

        int id = Integer.parseInt(idParam);

        if ("delete".equals(action)) {
            dao.deleteTask(id);
        } else if ("edit".equals(action)) {
            Task t = dao.getTaskById(id);
            req.setAttribute("task", t);
            req.setAttribute("current", cat);
            getServletContext().getRequestDispatcher("/updateTask.jsp").forward(req, resp);
            return;
        }

        // GANTI resp.sendRedirect("tasks?category=" + (cat == null ? "all" : cat));
        resp.sendRedirect(req.getContextPath() + "/tasks?category=" + (cat == null ? "all" : cat));

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        String idParam = req.getParameter("id");
        String category = req.getParameter("category");

        if (idParam == null || idParam.isEmpty()) {
            // GANTI resp.sendRedirect("tasks");
            resp.sendRedirect(req.getContextPath() + "/tasks");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
           // GANTI  resp.sendRedirect("tasks");
           resp.sendRedirect(req.getContextPath() + "/tasks");
            return;
        }

        if (category == null) {
            category = "all";
        }

        try {
            if ("delete".equals(action)) {
                dao.deleteTask(id);
                // GANTI resp.sendRedirect("tasks?category=" + category);
                resp.sendRedirect(req.getContextPath() + "/tasks?category=" + category);
                return;
            }

            if ("markDone".equals(action)) {
                dao.markDone(id);
               // GANTI  resp.sendRedirect("tasks?category=" + category);
               resp.sendRedirect(req.getContextPath() + "/tasks?category=" + category); 
               return;
            }

            // Mark with star
            if ("toggleStar".equals(action)) {
                dao.toggleStar(id);

                // Load updated task list and forward to viewTask.jsp
                HttpSession session = req.getSession();
                java.Model.User user = (java.Model.User) session.getAttribute("user");
                java.util.List<Task> taskList = dao.selectTasksByUser(user.getId(), category);

                req.setAttribute("tasks", taskList);
                req.setAttribute("current", category);
                req.getRequestDispatcher("viewTask.jsp").forward(req, resp);
                return;
            }

            // Default: update task
            String name = req.getParameter("name");
            String startDate = req.getParameter("start_date");
            String endDate = req.getParameter("end_date");
            String priority = req.getParameter("priority");
            String description = req.getParameter("description");
            boolean done = req.getParameter("done") != null;

            Task t = new Task(id, name, startDate, endDate, priority, category, description, done);

            dao.updateTask(t);

            // Redirect to viewTask.jsp after update
            // Get user from session (important!)
            HttpSession session = req.getSession();
            java.Model.User user = (java.Model.User) session.getAttribute("user");

            // Load tasks for this user and category
            java.util.List<Task> taskList = dao.selectTasksByUser(user.getId(), category);

            // Set attributes and forward to viewTask.jsp
            req.setAttribute("tasks", taskList);
            req.setAttribute("current", category);
            // Add for pop up message
            req.setAttribute("message", "Task updated successfully!");
            req.getRequestDispatcher("viewTask.jsp").forward(req, resp);
            return;

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
