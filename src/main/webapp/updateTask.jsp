<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="Model.Task" %>
<%@ page import="java.util.*" %>
<%@include file="sessionCheck.jspf"%>

<html>
    <head>
        <title>Edit Task</title>
        <style>
            body {
                margin: 0;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: url('${pageContext.request.contextPath}/images/bg_nude.jpg') no-repeat center center fixed;
                height:auto;
                width:auto;
            }



            .main-content {
                margin:auto;
                padding: 30px;
            }

            .container {
                position:relative;
                background-color: white;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
                max-width: 700px;
                margin: auto;
            }

            h1 {
                margin-bottom: 25px;
                color: #111827;
            }

            label {
                display: block;
                margin: 15px 0 5px;
                font-weight: 600;
                color: #374151;
            }

            input[type="text"],
            input[type="date"],
            select,
            textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid #d1d5db;
                border-radius: 6px;
                font-size: 15px;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;

            }

            textarea {
                resize: vertical;
            }



            .form-buttons {
                margin-top: 20px;
                display: flex;
                gap: 15px;
            }

            button {
                padding: 12px 20px;
                background-color: #c9a27e;
                color: white;
                border: none;
                border-radius: 6px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s;
                display: block;
                width: 100%;
            }



            button:hover {
                background-color: #b88c6c;
            }



            .message {
                background-color: #d1fae5;
                color: #065f46;
                padding: 12px;
                border-radius: 6px;
                margin-bottom: 20px;
                border: 1px solid #10b981;
            }

            hr {
                border: none;
                border-top: 1px solid #4b5563;
                margin: 20px 0;
            }

            @media screen and (max-width: 768px) {
                .main-content {
                    margin-left: 0;
                    padding: 20px;
                }

                .sidebar {
                    width: 100%;
                    height: auto;
                    position: relative;
                }
            }

            .close-btn {
                position: absolute;
                top: 15px;
                right: 20px;
                background-color: #F5E9DA;
                color: #4E342E;
                border: 2px solid #4E342E;
                padding: 5px 10px;
                border-radius: 50%;
                font-size: 18px;
                font-weight: bold;
                text-decoration: none;
                cursor: pointer;
                transition: background-color 0.3s, color 0.3s;
            }

            .close-btn:hover {
                background-color: #4E342E;
                color: #F5E9DA;
            }

        </style>
    </head>
    <body>

        <div class="main-content">
            <div class="container">
                <a href="${pageContext.request.contextPath}/TaskActionServlet?action=view&category=<%= request.getAttribute("current") != null ? request.getAttribute("current") : "all"%>" class="close-btn">✕</a>

                <h1>📋 Edit Task</h1>

                <% String msg = (String) request.getAttribute("message"); %>
                <% if (msg != null) {%>
                <p class="message"><%= msg%></p>
                <% } %>

                <%
                    Task task = (Task) request.getAttribute("task");
                    if (task != null) {
                %>

                <form action="${pageContext.request.contextPath}/TaskActionServlet" method="post">
                    <input type="hidden" name="id" value="<%= task.getId()%>">

                    <label>Task Name:</label>
                    <input type="text" name="name" value="<%= task.getName()%>" required>

                    <label>Start Date:</label>
                    <input type="date" name="start_date" value="<%= task.getStartDate()%>" required>

                    <label>End Date (Due Date):</label>
                    <input type="date" name="end_date" value="<%= task.getEndDate()%>" required>

                    <label>Priority:</label>
                    <select name="priority">
                        <option value="High" <%= task.getPriority().equals("High") ? "selected" : ""%>>High</option>
                        <option value="Medium" <%= task.getPriority().equals("Medium") ? "selected" : ""%>>Medium</option>
                        <option value="Low" <%= task.getPriority().equals("Low") ? "selected" : ""%>>Low</option>
                    </select>

                    <label>Category:</label>
                    <select name="category">
                        <option value="Work" <%= task.getCategory().equals("Work") ? "selected" : ""%>>Work</option>
                        <option value="Personal" <%= task.getCategory().equals("Personal") ? "selected" : ""%>>Personal</option>
                        <option value="Wishlist" <%= task.getCategory().equals("Wishlist") ? "selected" : ""%>>Wishlist</option>
                        <option value="Birthday" <%= task.getCategory().equals("Birthday") ? "selected" : ""%>>Birthday</option>
                    </select>

                    <label>Description:</label>
                    <textarea name="description" rows="4"><%= task.getDescription() != null ? task.getDescription() : ""%></textarea>


                    <div class="form-buttons">
                        <button type="submit" name="action" value="update">Update</button>

                    </div>
                </form>
                <% } else { %>
                <p style="color: red;">Task not found.</p>
                <% }%>
            </div>
        </div>


    </body>
</html>