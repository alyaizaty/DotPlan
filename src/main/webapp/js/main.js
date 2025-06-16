/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


document.addEventListener("DOMContentLoaded", function () {
    const modal = document.getElementById("signupModal");
    const openBtn = document.getElementById("openSignup");
    const closeBtn = document.querySelector(".close-btn");

    openBtn.addEventListener("click", () => {
        modal.style.display = "flex";

        // Reload the form every time modal is opened
        const iframe = modal.querySelector("iframe");
        if (iframe) {
            iframe.src = "/DotPlan/signup.jsp";
        }
    });

    closeBtn.addEventListener("click", () => {
        modal.style.display = "none";
    });

    window.addEventListener("click", (e) => {
        if (e.target === modal) {
            modal.style.display = "none";
        }
    });
});

// outside the DOMContentLoaded block:
window.addEventListener("pageshow", function () {
    const modal = document.getElementById("signupModal");
    if (modal) {
        modal.style.display = "none";

        // Clear iframe content to prevent showing blank form on back
        const iframe = modal.querySelector("iframe");
        if (iframe) {
            iframe.src = "";
        }
    }
});



// User Profile
document.addEventListener("DOMContentLoaded", function () {
    const profileInput = document.getElementById("profilePicInput");
    const profilePreview = document.getElementById("previewImage"); // 

    if (profileInput && profilePreview) {
        profileInput.addEventListener("change", function (event) {
            const file = event.target.files[0];
            if (file && file.type.startsWith("image/")) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    profilePreview.src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        });
    }
});
