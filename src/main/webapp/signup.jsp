<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
        <title>DotPlan - Sign Up</title>
    </head>
    <body>
        <div class="signup-box">
            <h2>Create Your DotPlan Account</h2>

            <%-- If there's an error --%>
            <% String error = (String) request.getAttribute("errorMessage"); %>
            <% if (error != null) { %>
            <div style="color: red; margin-bottom: 10px;">
                <%= error %>
            </div>
            <% } %>

            <form method="post" action="${pageContext.request.contextPath}/SignupServlet">
                <input type="text" name="username" placeholder="Username" required />
                <input type="email" name="email" placeholder="Email" required />
                <input type="password" name="password" placeholder="Password" required />
                <input type="submit" value="Sign Up" class="signup-btn" />
            </form>

            <div class="login-link">
                Already have an account? 
                <a href="${pageContext.request.contextPath}/login.jsp" target="_top">Log in</a>
            </div>
        </div>
    </body>
</html>
