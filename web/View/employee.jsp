
<%@ page import="com.service.Project.Model.ComplaintModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Complaint - Complaint Management System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            min-height: 100vh;
        }

        .navbar {
            background: linear-gradient(45deg, #007bff, #0056b3) !important;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-weight: 600;
            font-size: 1.5rem;
        }

        .user-info {
            background: rgba(255, 255, 255, 0.1);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            margin-right: 1rem;
        }

        .main-container {
            margin-top: 2rem;
            margin-bottom: 2rem;
        }

        .card {
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            border: none;
            margin-bottom: 2rem;
        }

        .card-header {
            background: linear-gradient(45deg, #007bff, #0056b3);
            color: white;
            border-radius: 15px 15px 0 0 !important;
            padding: 1.5rem;
            border: none;
        }

        .card-header h5 {
            margin: 0;
            font-weight: 600;
        }

        .form-control:focus, .form-select:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        .btn-primary {
            background: linear-gradient(45deg, #007bff, #0056b3);
            border: none;
            padding: 12px 24px;
            font-weight: 500;
            border-radius: 8px;
        }

        .btn-primary:hover {
            background: linear-gradient(45deg, #0069d9, #004085);
            transform: translateY(-1px);
        }

        .user-details {
            background: #e3f2fd;
            border: 1px solid #90caf9;
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 1.5rem;
        }

        .user-details .form-control {
            background-color: #f5f5f5;
        }

        .form-label {
            font-weight: 500;
            color: #495057;
        }

        .required::after {
            content: " *";
            color: #dc3545;
        }

        .alert-success {
            border-radius: 10px;
            border: none;
            background: linear-gradient(45deg, #d4edda, #c3e6cb);
        }

        .table th {
            white-space: nowrap;
        }

        .remark-cell {
            max-width: 150px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .remark-cell:hover {
            overflow: visible;
            white-space: normal;
            word-wrap: break-word;
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="fas fa-clipboard-list me-2"></i>
            Complaint Management System
        </a>
        <div class="navbar-nav ms-auto">
            <button class="btn btn-outline-light" href="#">
                <i class="fas fa-sign-out-alt me-1"></i> Logout
            </button>
        </div>
    </div>
</nav>

<div class="container main-container">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card">
                <div class="card-header">
                    <h5><i class="fas fa-plus me-2"></i>Submit New Complaint</h5>
                </div>
                <div class="card-body">
                    <!-- Success Message -->
                    <div id="successAlert" class="alert alert-success d-none" role="alert">
                        <i class="fas fa-check-circle me-2"></i>
                        <strong>Success!</strong> Your complaint has been submitted successfully.
                        <br>Complaint ID: <span id="generatedComplaintId"></span>
                    </div>

                    <form id="complaintForm">
                        <div class="user-details">
                            <h6 class="mb-3"><i class="fas fa-user me-2"></i>User Information</h6>
                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label for="userName" class="form-label">Full Name</label>
                                    <input type="text" class="form-control" id="userName" name="userName" value="<%= session.getAttribute("userName") %>" readonly>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label for="userId" class="form-label">User ID</label>
                                    <input type="text" class="form-control" id="userId" name="userId" value="userId" readonly>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label for="signInDate" class="form-label">Date</label>
                                    <input type="date" class="form-control" id="signInDate" readonly>
                                </div>
                            </div>

                        </div>
                        <h6 class="mb-3"><i class="fas fa-exclamation-circle me-2"></i>Complaint Details</h6>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="complaintSubject" class="form-label required">Subject</label>
                                <input type="text" class="form-control" id="complaintSubject" placeholder="Brief description of your complaint" required>
                            </div>

                        </div>

                        <div class="mb-4">
                            <label for="complaintDescription" class="form-label required">Detailed Description</label>
                            <textarea class="form-control" id="complaintDescription" rows="8" required placeholder="Please provide detailed information about your complaint. Include when the issue occurred, what happened, and any steps you've already taken to resolve it."></textarea>
                            <div class="form-text">Minimum 50 characters required</div>
                        </div>


                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <button type="button" class="btn btn-outline-secondary me-md-2" onclick="resetForm()">
                                <i class="fas fa-undo me-2"></i>Reset Form
                            </button>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-paper-plane me-2"></i>Submit Complaint
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-lg-10">
            <div class="card">
                <div class="card-header">
                    <h5><i class="fas fa-list me-2"></i>MY Complaints</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                            <tr>
                                <th>Complaint ID</th>
                                <th>Subject</th>
                                <th>Date</th>
                                <th>Description</th>
                                <th>Status</th>
                                <th>Remark</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody id="complaintsTable">
<%--                            <%--%>
<%--                                List<ComplaintModel> complaintList = (List<ComplaintModel>) request.getAttribute("complaintList");--%>
<%--                                if (complaintList != null) {--%>
<%--                                    for (ComplaintModel complaint : complaintList) {--%>
<%--                            %>--%>
<%--                            <tr>--%>
<%--                                <td><%= complaint.getComplaint_id() %></td>--%>
<%--                                <td><%= complaint.getTitle() %></td>--%>
<%--                                <td><%= complaint.getRemark() %></td>--%>
<%--                                <td><%= complaint.getDescription() %></td>--%>
<%--                                <td>--%>
<%--            <span class="badge--%>
<%--                <%= "Pending".equals(complaint.getStatus()) ? "bg-warning" :--%>
<%--                    "Resolved".equals(complaint.getStatus()) ? "bg-success" :--%>
<%--                    "In Progress".equals(complaint.getStatus()) ? "bg-info" : "bg-secondary" %>">--%>
<%--                <%= complaint.getStatus() %>--%>
<%--            </span>--%>
<%--                                </td>--%>
<%--                                <td class="remark-cell" title="<%= complaint.getRemark() %>">--%>
<%--                                    <%= complaint.getRemark() != null ? complaint.getRemark() : "No remark yet" %>--%>
<%--                                </td>--%>
<%--                                <td>--%>
<%--                                    <button class="btn btn-sm btn-outline-warning me-1" onclick="editComplaint('<%= complaint.getId() %>')">--%>
<%--                                        <i class="fas fa-edit"></i> Update--%>
<%--                                    </button>--%>
<%--                                    <button class="btn btn-sm btn-outline-danger" onclick="deleteComplaint('<%= complaint.getId() %>')">--%>
<%--                                        <i class="fas fa-trash"></i> Delete--%>
<%--                                    </button>--%>
<%--                                </td>--%>
<%--                            </tr>--%>
<%--                            <%--%>
<%--                                }--%>
<%--                            } else {--%>
<%--                            %>--%>
<%--                            <tr>--%>
<%--                                <td colspan="7" class="text-center text-muted">No complaints submitted yet.</td>--%>
<%--                            </tr>--%>
<%--                            <%--%>
<%--                                }--%>
<%--                            %>--%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>