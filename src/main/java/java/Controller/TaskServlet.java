/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package java.Controller;

import java.Dao.TaskDAO;
import Model.Task;
import Model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class TaskServlet extends HttpServlet {

    private TaskDAO dao;

    public void init() {
        dao = new TaskDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Prevent browser caching
        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        resp.setHeader("Pragma", "no-cache");
        resp.setDateHeader("Expires", 0);

        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            // GANTI resp.sendRedirect("login.jsp");
            resp.sendRedirect(req.getContextPath() + "/login.jsp");

            return;
        }

        String cat = req.getParameter("category");
        if (cat == null || cat.isEmpty()) {
            cat = "all";
        }

        int userId = user.getId();
        List<Task> list = dao.selectTasksByUser(userId, cat);

        req.setAttribute("tasks", list);
        req.setAttribute("current", cat);
        // Add for pop up message
        // Show success message only if added=true is present in URL
        String added = req.getParameter("added");
        if ("true".equals(added)) {
            req.setAttribute("message", "Task added successfully!");
        }

        getServletContext().getRequestDispatcher("/viewTask.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int userId = user.getId();
        boolean starred = false; // default
        String starredParam = req.getParameter("starred");
        if (starredParam != null && (starredParam.equals("true") || starredParam.equals("on"))) {
            starred = true;
        }

        Task t = new Task(
                req.getParameter("name"),
                req.getParameter("start_date"),
                req.getParameter("end_date"),
                req.getParameter("priority"),
                req.getParameter("category"),
                req.getParameter("description"),
                userId,
                starred
        );

        dao.insertTask(t);
        // Redirect with a flag to trigger the success message
        resp.sendRedirect(req.getContextPath() + "/tasks?added=true");
    }

}
