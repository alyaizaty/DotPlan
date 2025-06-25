
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="sessionCheck.jspf"%>
<%@ page import="Model.User" %>


<html>
    <head>
        <title>Add Your Task</title>
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

            .layout-container {
                display: flex;
                padding-top: 70px; /* offset for fixed header */
            }


            .sidebar {
                width: 250px;
                height: 100vh;
                background-color: rgba(255, 255, 255, 0.95);
                position: fixed;
                left: 0;
                top: 0;
                padding: 20px;
                padding-bottom: 60px; /* Add extra space at the bottom */
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
                margin-bottom: 20px; /* Give space above the very bottom */
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
            
            .menu-reminder i {
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
                max-width: 600px;
                width: 100%;
            }

            h1 {
                text-align: center;
                color: #5a4b41;
                margin-bottom: 25px;
            }

            label {
                font-weight: bold;
                color: #333;
            }

            input[type="text"],
            input[type="date"],
            select,
            textarea {
                width: 100%;
                padding: 10px;
                margin: 8px 0 20px 0;
                border: 1px solid #ccc;
                border-radius: 6px;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;

            }

            input[type="submit"] {
                background-color: #c9a27e;
                color: white;
                border: none;
                padding: 12px 20px;
                font-size: 16px;
                cursor: pointer;
                border-radius: 6px;
                width: 100%;
                transition: background-color 0.3s ease;
            }
            input[type="submit"]:hover {
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

            <a href="javascript:void(0);" class="sidebar-item category-all" onclick="openProfileModal()">
                <i class="fas fa-user"></i>
                <span>Profile</span>
            </a>


            <hr style="border: 1px solid #e5e7eb; margin: 15px 0;">

            <a href="${pageContext.request.contextPath}/addTask.jsp" class="sidebar-item menu-add-task" onclick="selectCategory('add-task')">
                <i class="fas fa-plus-circle"></i>
                <span>Add Task</span>
            </a>

            <a href="${pageContext.request.contextPath}/TaskServlet" class="sidebar-item menu-view-tasks">
                <i class="fas fa-eye"></i>
                <span>View Tasks</span>
            </a>

            <!-- Reminder nav -->
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
                <h1>📋 Add New Task</h1>
                <form action="${pageContext.request.contextPath}/TaskServlet" method="post">


                    <label>Task Name:</label>
                    <input type="text" name="name" required>

                    <label>Start Date:</label>
                    <input type="date" name="start_date" required>

                    <label>End                                                                                                                                              Date (Due Date):</label>
                    <input type="date" name="end_date" required>

                    <label>Priority:</label>
                    <select name="priority">
                        <option value="High">High</option>
                        <option value="Medium">Medium</option>
                        <option value="Low">Low</option>
                    </select>

                    <label>Category:</label>
                    <select name="category">
                        <option value="Work">Work</option>
                        <option value="Personal">Personal</option>
                        <option value="Wishlist">Wishlist</option>
                        <option value="Birthday">Birthday</option>
                    </select>

                    <label>Description:</label>
                    <textarea name="description" rows="4"></textarea>

                    <input type="submit" value="Add Task">
                    <a href="viewTask.jsp"></a>
                </form>

            </div>
        </div>
        <script>
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                sidebar.classList.toggle('collapsed');
            }

            function selectCategory(category) {
                document.querySelectorAll('.sidebar-item').forEach(item => {
                    item.classList.remove('active');
                });
                const selected = document.querySelector(`.category-${category}, .menu-${category}`);
                if (selected) {
                    selected.classList.add('active');
                }
            }

            function openProfileModal() {
                document.getElementById('profileModal').style.display = 'block';
            }

            function closeProfileModal() {
                document.getElementById('profileModal').style.display = 'none';
            }


            // Highlight Add Task as active on this page
            selectCategory('add-task');
        </script>
    </body>
</html>
