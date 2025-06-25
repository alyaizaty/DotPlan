
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat, java.util.Date, Model.Task" %>
<%@ include file="sessionCheck.jspf" %>

<html>
    <head>
        <title>Reminders</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                margin: 0;
                padding: 0;
                background: url('${pageContext.request.contextPath}/images/bg_nude.jpg') no-repeat center center fixed;
                background-size: cover;
                display: flex;
            }

            .sidebar {
                width: 250px;
                height: 100vh;
                background-color: rgba(255, 255, 255, 0.95);
                position: fixed;
                left: 0;
                top: 0;
                padding: 20px;
                padding-bottom: 60px;
                box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
                display: flex;
                flex-direction: column;
                transition: width 0.3s ease;
            }

            .sidebar.collapsed {
                width: 60px;
            }

            .sidebar.collapsed .sidebar-item span,
            .sidebar.collapsed .sidebar-header h2 {
                display: none;
            }

            .sidebar-header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 20px;
            }

            .sidebar-header h2 {
                color: #5a4b41;
                font-size: 20px;
                margin: 0;
            }

            .toggle-btn {
                background: none;
                border: none;
                font-size: 20px;
                cursor: pointer;
                color: #c9a27e;
            }

            .toggle-btn:hover {
                color: #b88c6c;
            }

            .sidebar-item {
                display: flex;
                align-items: center;
                padding: 10px;
                margin: 5px 0;
                border-radius: 6px;
                color: #333;
                text-decoration: none;
                transition: background-color 0.3s ease;
            }

            .menu-reminder i {
                color: #facc15; /* gold/yellow */
            }
            
            .sidebar-item:hover {
                background-color: #f5f5f5;
            }

            .sidebar-item.active {
                background-color: #c9a27e;
                color: white;
            }

            .sidebar-item i {
                margin-right: 10px;
                font-size: 18px;
            }

            .sidebar-item span {
                font-size: 16px;
            }

            .logout-form {
                margin-top: auto;
                margin-bottom: 20px;
                display: flex;
                padding: 10px;
            }

            .logout-btn {
                background-color: #c9a27e;
                color: white;
                border: none;
                padding: 10px;
                width: 100%;
                text-align: left;
                font-size: 16px;
                display: flex;
                align-items: center;
                gap: 10px;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .logout-btn:hover {
                background-color: #b88c6c;
            }

            .modal {
                display: none;
                position: fixed;
                z-index: 10000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0,0,0,0.6);
            }

            .modal-content {
                background-color: #fff;
                margin: 5% auto;
                padding: 0;
                border-radius: 12px;
                width: 40%;
                height: 80%;
                position: relative;
                box-shadow: 0 0 20px rgba(0,0,0,0.3);
            }

            .modal-content iframe {
                width: 100%;
                height: 100%;
                border: none;
                border-radius: 12px;
            }

            .close-btn {
                position: absolute;
                top: 12px;
                right: 20px;
                font-size: 28px;
                font-weight: bold;
                color: #aaa;
                cursor: pointer;
                z-index: 10001;
            }

            .close-btn:hover {
                color: #000;
            }

            .menu-add-task i {
                color: #10b981;
            }
            .menu-view-tasks i {
                color: #6366f1;
            }
            .menu-starred i {
                color: #facc15;
            }

            .main-content {
                margin-left: 270px;
                padding: 40px;
                width: calc(100% - 270px);
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .sidebar.collapsed ~ .main-content {
                margin-left: 80px;
                width: calc(100% - 80px);
            }

            .container {
                background-color: rgba(255, 255, 255, 0.95);
                padding: 30px 40px;
                border-radius: 12px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
                max-width: 800px;
                width: 100%;
            }

            h1 {
                text-align: center;
                color: #5a4b41;
                margin-bottom: 25px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                padding: 12px;
                text-align: center;
                border-bottom: 1px solid #e5e7eb;
            }

            th {
                background-color: #f5f5f5;
                color: #5a4b41;
            }

            tr:hover {
                background-color: #f9fafb;
            }

            .overdue {
                background-color: #f8d7da;
            }

            .due-soon {
                background-color: #fff3cd;
            }

            .done {
                background-color: #d4edda;
                text-decoration: line-through;
                color: #6b7280;
            }

            .popup {
                position: fixed;
                top: 50px;
                right: 60px;
                max-width: 300px;
                background-color: #c9a27e;
                color: white;
                padding: 12px 18px;
                border-radius: 20px 20px 0 20px; /* bubble shape */
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
                z-index: 9999;
                opacity: 1;
                transition: opacity 0.5s ease, transform 0.3s ease;
                display: none;
                font-family: Arial, sans-serif;
                font-size: 17px;
                line-height: 1.4;
                animation: slideInUp 0.4s ease;
            }

            @keyframes slideInUp {
                from {
                    transform: translateY(20px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }

            .action-btn i {
                color: #c9a27e;
            }


            .action-btn .fa-star:hover,
            .action-btn .far.fa-star:hover {
                transform: scale(1.1);
                transition: transform 0.2s;
            }

            button:hover {
                background-color: #b88c6c;
            }
        </style>
    </head>
    <body>

        <div class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <h2>Menu</h2>
                <button class="toggle-btn" onclick="toggleSidebar()">
                    <i class="fas fa-bars"></i>
                </button>
            </div>

            <a href="javascript:void(0);" class="sidebar-item" onclick="openProfileModal()">
                <i class="fas fa-user"></i>
                <span>Profile</span>
            </a>

            <hr style="border: 1px solid #e5e7eb; margin: 15px 0;">

            <a href="${pageContext.request.contextPath}/addTask.jsp" class="sidebar-item menu-add-task">
                <i class="fas fa-plus-circle"></i>
                <span>Add Task</span>
            </a>

            <a href="${pageContext.request.contextPath}/TaskServlet" class="sidebar-item menu-view-tasks">
                <i class="fas fa-eye"></i>
                <span>View Tasks</span>
            </a>

            <a href="${pageContext.request.contextPath}/ReminderServlet" class="sidebar-item menu-reminder">
                <i class="fas fa-bell"></i>
                <span>Reminders</span>
            </a>

            <form action="${pageContext.request.contextPath}/LogoutServlet" method="post" class="sidebar-item logout-form">
                <button type="submit" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </button>
            </form>
        </div>

        <!-- Profile Modal -->
        <div id="profileModal" class="modal">
            <div class="modal-content" >
                <span class="close-btn" onclick="closeProfileModal()">&times;</span>
                <iframe src="${pageContext.request.contextPath}/profile.jsp" frameborder="0"></iframe>
            </div>
        </div>

        <div class="main-content">
            <div class="container">
                <h1>🔔 Your Reminders</h1>
                <%                    List<Task> tasks = (List<Task>) request.getAttribute("tasks");
                    if (tasks == null || tasks.isEmpty()) {
                %>
                <p style="text-align:center;">No upcoming or important tasks!</p>
                <%
                } else {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date now = new Date();
                %>
                <table>
                    <tr>
                        <th>Title</th>
                        <th>Due Date</th>
                        <th>Days Left</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                    <%
                        for (Task task : tasks) {
                            Date endDate = sdf.parse(task.getEndDate());
                            long millisDiff = endDate.getTime() - now.getTime();
                            long daysLeft = millisDiff / (1000 * 60 * 60 * 24);

                            String rowClass = "";
                            if (task.isDone()) {
                                rowClass = "done";
                            } else if (daysLeft < 0) {
                                rowClass = "overdue";
                            } else if (daysLeft <= 3) {
                                rowClass = "due-soon";
                            }
                    %>
                    <tr class="<%= rowClass%>">
                        <td><%= task.getName()%></td>
                        <td><%= task.getEndDate()%></td>
                        <td>
                            <%= task.isDone() ? "-" : (daysLeft < 0 ? "Overdue" : daysLeft + " day(s)")%>
                        </td>
                        <td><%= task.isDone() ? "Done" : "Pending"%></td>
                        <td>
                            <% if (!task.isDone()) {%>
                            <form action="${pageContext.request.contextPath}/ReminderServlet" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="markDone">
                                <input type="hidden" name="id" value="<%= task.getId()%>">
                                <input type="hidden" name="category" value="<%= task.getCategory()%>">
                                <button type="submit" class="action-btn">
                                    <i class="fas <%= task.isDone() ? "fa-undo" : "fa-check"%>"></i>
                                </button>
                            </form>


                            <% } else { %> - <% } %>
                        </td>
                    </tr>
                    <% } %>
                </table>
                <% }%>
            </div>
        </div>

        <script>
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                sidebar.classList.toggle('collapsed');
            }

            function openProfileModal() {
                document.getElementById('profileModal').style.display = 'block';
            }

            function closeProfileModal() {
                document.getElementById('profileModal').style.display = 'none';
            }
        </script>



    </body>
</html>
