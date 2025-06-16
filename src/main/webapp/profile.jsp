
<%@page import="Model.User" %>
<%@include file="sessionCheck.jspf"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html>
<head>
    <title>User Profile</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</head>
<body class="profile-body">
    <div class="profile-container">

        <%
            String successMessage = (String) session.getAttribute("successMessage");
            if (successMessage != null) {
        %>
        <div class="alert success-alert"><%= successMessage %></div>
        <%
                session.removeAttribute("successMessage");
            }
        %>

        <!-- Update Profile Form -->
        <form id="updateForm" class="profile-form"
              action="${pageContext.request.contextPath}/UpdateProfileServlet"
              method="post" enctype="multipart/form-data">

            <!-- Profile Image -->
            <div class="profile-pic-container">
                <label for="profilePicInput">
                    <img class="profile-pic"
                         id="previewImage"
                         src="<%= (user.getProfilePic() != null && !user.getProfilePic().isEmpty())
                             ? pageContext.getRequest().getContextPath() + "/profile-pics/" + user.getProfilePic()
                             : pageContext.getRequest().getContextPath() + "/images/userDefault.png" %>" />
                </label>
                <input id="profilePicInput" class="profile-input-file" type="file"
                       name="profilePic" accept="image/*"
                       onchange="previewProfileImage(event)" />
            </div>

            <h2 class="profile-greeting">Hi, <%= user.getUsername() %>!</h2>
            <input type="hidden" name="username" value="<%= user.getUsername() %>" />

            <label>Want to change your password?</label>
            <input class="profile-input" type="password" name="password" placeholder="New Password" />
            <input class="profile-input" type="password" name="confirmPassword" placeholder="Enter the password again" />
            <input class="profile-btn profile-btn-save" type="submit" value="Save" />
        </form>

        <!-- Delete Account Button -->
        <div class="profile-delete-icon">
            <form action="${pageContext.request.contextPath}/DeleteAccountServlet"
                  method="post" target="_top"
                  onsubmit="return confirm('Are you sure you want to delete your account?');">
                <button class="delete-icon-btn" title="Delete Account" type="submit">
                    <i class="fas fa-trash-alt"></i>
                </button>
            </form>
        </div>
    </div>
</body>
</html>
