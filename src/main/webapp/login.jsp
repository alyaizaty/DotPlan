<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>DotPlan - Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
</head>
<body class="login-body">
    <div class="login-container">
        <div class="login-wrapper">
            <!-- Left Panel -->
            <div class="login-panel">
                <h2 class="login-title">Welcome back, Planner!</h2>

                <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
                <% if (errorMessage != null) { %>
                    <p class="login-error"><%= errorMessage %></p>
                <% } %>

                <form method="post" action="${pageContext.request.contextPath}/LoginServlet">
                    <input class="login-input" type="text" name="username" placeholder="Username" required />
                    <input class="login-input" type="password" name="password" placeholder="Password" required />
                    <button type="submit" class="login-button">Log In</button>
                </form>

                <div class="login-link">
                    Don't have an account? 
                    <a href="${pageContext.request.contextPath}/signup.jsp">Sign up</a>
                </div>
            </div>

            <!-- Right Panel -->
            <div class="login-side">
                <div class="login-prompt">What's on your mind today?</div>
                <img src="${pageContext.request.contextPath}/images/login-image.png" alt="Planner Visual" class="login-img" />
            </div>
        </div>
    </div>
</body>
</html>
