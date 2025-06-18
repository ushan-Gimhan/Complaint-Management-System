<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true"%>


<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: white;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px 0;
        }

        .signup-card {
            max-width: 500px;
            width: 100%;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            background: white;
            border: none;
        }

        .signup-title {
            text-align: center;
            margin-bottom: 2rem;
            color: #007bff;
            font-weight: 600;
        }

        .form-control:focus, .form-select:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        .btn-signup {
            width: 100%;
            background: linear-gradient(45deg, #007bff, #0056b3);
            border: none;
            padding: 12px;
            font-weight: 500;
        }

        .btn-signup:hover {
            background: linear-gradient(45deg, #0069d9, #004085);
            transform: translateY(-1px);
        }

        .form-check-input:checked {
            background-color: #007bff;
            border-color: #007bff;
        }

        a {
            color: #007bff !important;
        }

        a:hover {
            color: #0056b3 !important;
        }

        .row {
            margin: 0;
        }

        .col-md-6 {
            padding-left: 5px;
            padding-right: 5px;
        }
    </style>
</head>
<body>
<div class="signup-card">
    <h3 class="signup-title">Create Account</h3>
    <p class="text-center text-muted mb-4">Join our Complaint Management System</p>

    <form action="${pageContext.request.contextPath}/user" method="post">
        <div class="mb-3">
            <label for="firstName" class="form-label">User Name</label>
            <input type="text" name="firstName" class="form-control" id="firstName" required>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Email Address</label>
            <input type="email" name="email" class="form-control" id="email" required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" name="password" class="form-control" id="password" required>
        </div>

        <div class="mb-3">
            <label for="roleSelect" class="form-label">Select Your Role</label>
            <select class="form-select" id="roleSelect" name="roleSelect" required>
                <option value="">Choose your role...</option>
<%--                <option value="admin">admin</option>--%>
                <option value="employee">employee</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary btn-signup">Create Account</button>

        <div class="text-center mt-3">
            <span class="text-muted">Already have an account? </span>
            <a href="<%=request.getContextPath()%>/View/Login.jsp" class="text-decoration-none">Sign in here</a>
        </div>
    </form>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<%
    String loginMsg = (String) session.getAttribute("loginMessage");
    if (loginMsg != null) {
        session.removeAttribute("loginMessage"); // Clear after showing
%>
<script>
    <% if ("success".equals(loginMsg)) { %>
    Swal.fire({
        icon: 'success',
        title: 'Account Created!',
        text: 'Use user name and Password to Log...',
        showConfirmButton: false,
        timer: 2000
    });
    <% } else if ("error".equals(loginMsg)) { %>
    Swal.fire({
        icon: 'error',
        title: 'Failed to Create',
        text: 'Enter correct User Name and Password.',
        showConfirmButton: true
    });
    <% } else if ("inactive".equals(loginMsg)) { %>
    Swal.fire({
        icon: 'warning',
        title: 'Account Inactive',
        text: 'Please contact administrator.',
        showConfirmButton: true
    });
    <% } %>
</script>
<%
    }
%>
</body>
</html>