/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


document.addEventListener("DOMContentLoaded", function () {
    // Modal elements
    const modal = document.getElementById("signupModal");
    const openBtn = document.getElementById("openSignup");
    const closeBtn = document.querySelector(".close-btn");

    // Open modal
    if (openBtn && modal) {
        openBtn.addEventListener("click", () => {
            modal.style.display = "flex";

            const iframe = modal.querySelector("iframe");
            if (iframe) {
                iframe.src = "signup.jsp"; // Reload form
            }
        });
    }

    // Close modal on close button click
    if (closeBtn && modal) {
        closeBtn.addEventListener("click", () => {
            modal.style.display = "none";
        });
    }

    // Close modal if clicking outside of modal content
    window.addEventListener("click", (e) => {
        if (e.target === modal) {
            modal.style.display = "none";
        }
    });

    // Profile image preview
    const profileInput = document.getElementById("profilePicInput");
    const profilePreview = document.getElementById("previewImage");

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

// Clear iframe content on browser back/refresh to avoid cached form
window.addEventListener("pageshow", function () {
    const modal = document.getElementById("signupModal");
    if (modal) {
        modal.style.display = "none";

        const iframe = modal.querySelector("iframe");
        if (iframe) {
            iframe.src = ""; // Clear content
        }
    }
});
