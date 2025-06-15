<%--
  Created by IntelliJ IDEA.
  User: ushan
  Date: 15-Jun-25
  Time: 1:06 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: white;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-card {
            max-width: 400px;
            width: 100%;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            background: white;
            border: none;
        }

        .login-title {
            text-align: center;
            margin-bottom: 2rem;
            color: #007bff;
            font-weight: 600;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        .btn-login {
            background: linear-gradient(45deg, #007bff, #0056b3);
            border: none;
            padding: 12px;
            font-weight: 500;
        }

        .btn-login:hover {
            background: linear-gradient(45deg, #0069d9, #004085);
            transform: translateY(-1px);
        }

        .btn-signup {
            background: linear-gradient(45deg, #28a745, #1e7e34);
            border: none;
            padding: 12px;
            font-weight: 500;
        }

        .btn-signup:hover {
            background: linear-gradient(45deg, #218838, #155724);
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
    </style>
</head>
<body>
<div class="login-card">
    <h3 class="login-title">Complaint Management System</h3>

    <form>
        <div class="mb-3">
            <label for="username" class="form-label">User Name</label>
            <input type="text" class="form-control" id="username" required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" required>
        </div>

        <div class="mb-3 form-check">
            <input type="checkbox" class="form-check-input" id="remember">
            <label class="form-check-label" for="remember">
                Remember me
            </label>
        </div>

        <div class="row mb-3">
            <div class="col-6">
                <button type="submit" class="btn btn-primary btn-login w-100">Login</button>
            </div>
            <div class="col-6">
                <button type="button" class="btn btn-success btn-signup w-100">Sign Up</button>
            </div>
        </div>
    </form>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>