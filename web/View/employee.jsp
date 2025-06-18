<%@ page import="com.service.Project.Model.ComplaintModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
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

        .btn-success {
            background: linear-gradient(45deg, #28a745, #1e7e34);
            border: none;
            padding: 12px 24px;
            font-weight: 500;
            border-radius: 8px;
        }

        .btn-success:hover {
            background: linear-gradient(45deg, #218838, #1c7430);
            transform: translateY(-1px);
        }

        .btn-danger {
            background: linear-gradient(45deg, #dc3545, #c82333);
            border: none;
            padding: 12px 24px;
            font-weight: 500;
            border-radius: 8px;
        }

        .btn-danger:hover {
            background: linear-gradient(45deg, #c82333, #bd2130);
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

        .action-buttons {
            gap: 10px;
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
            <a href="<%= request.getContextPath() %>/View/Login.jsp" class="btn btn-outline-light">
                <i class="fas fa-sign-out-alt me-1"></i> Logout
            </a>
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

                    <form method="post" action="employee" id="complaintForm" >
                        <% String message = (String) request.getAttribute("message"); %>
                        <% if (message != null) { %>
                        <div class="message <%= message.contains("successfully") ? "success" : "error" %>">
                            <%= message %>
                        </div>
                        <% } %>
                        <div class="message success">
                            Complaint updated successfully!
                        </div>
                        <div class="user-details">
                            <h6 class="mb-3"><i class="fas fa-user me-2"></i>User Information</h6>
                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label for="userName" class="form-label">Full Name</label>
                                    <input type="text" class="form-control" id="userName" name="userName"
                                           value="<%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "" %>"
                                           readonly>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label for="userId" class="form-label">User ID</label>
                                    <input type="text" class="form-control" id="userId" name="userId"
                                           value="<%= session.getAttribute("userId") != null ? session.getAttribute("userId") : "" %>"
                                           readonly>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <%
                                        String today = LocalDate.now().toString(); // yyyy-MM-dd format
                                    %>
                                    <label for="signInDate" class="form-label">Date</label>
                                    <input type="date" class="form-control" id="signInDate" name="signInDate"
                                           value="<%= today %>" readonly>
                                </div>
                            </div>

                        </div>
                        <h6 class="mb-3"><i class="fas fa-exclamation-circle me-2"></i>Complaint Details</h6>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="complaintSubject" class="form-label required">Subject</label>
                                <input type="text" class="form-control" id="complaintSubject" name="complaintSubject" placeholder="Brief description of your complaint" required>
                            </div>

                        </div>

                        <div class="mb-4">
                            <label for="complaintDescription" class="form-label required">Detailed Description</label>
                            <textarea class="form-control" id="complaintDescription" name="complaintDescription" rows="8" required placeholder="Please provide detailed information about your complaint. Include when the issue occurred, what happened, and any steps you've already taken to resolve it."></textarea>
                            <div class="form-text">Minimum 50 characters required</div>
                        </div>

                        <!-- Hidden field for complaint ID (used for update/delete operations) -->
                        <input type="hidden" id="complaintId" name="complaintId" value="<%= request.getAttribute("complaintId") != null ? request.getAttribute("complaintId") : "" %>">

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end action-buttons">
                            <button type="button" class="btn btn-outline-secondary me-md-2" onclick="resetForm()">
                                <i class="fas fa-undo me-2"></i>Reset Form
                            </button>
                            <button type="submit" name="action" value="add" class="btn btn-primary" id="submitBtn">
                                <i class="fas fa-paper-plane me-2"></i>Submit Complaint
                            </button>
                            <button type="submit" name="action" value="update" class="btn btn-success" id="updateBtn">
                                <i class="fas fa-edit me-2"></i>Update Complaint
                            </button>
                            <button type="submit" name="action" value="delete" class="btn btn-danger" id="deleteBtn" onclick="return confirmDelete()">
                                <i class="fas fa-trash me-2"></i>Delete Complaint
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
                            <%
                                List<ComplaintModel> complaintList = (List<ComplaintModel>) request.getAttribute("complaintList");
                                if (complaintList != null && !complaintList.isEmpty()) {
                                    for (ComplaintModel complaint : complaintList) {
                            %>
                            <tr onclick="selectComplaint('<%= complaint.getTitle() %>', '<%= complaint.getDescription() %>',<%= complaint.getComplaint_id() %>)">
                                <td><%= complaint.getComplaint_id() %></td>
                                <td><%= complaint.getUser_id() %></td>
                                <td><%= complaint.getTitle() %></td>
                                <td><%= complaint.getDescription() %></td>
                                <td>
        <span class="badge
            <%= "Pending".equals(complaint.getStatus()) ? "bg-warning" :
                "Resolved".equals(complaint.getStatus()) ? "bg-success" :
                "In Progress".equals(complaint.getStatus()) ? "bg-info" : "bg-secondary" %>">
            <%= complaint.getStatus() != null ? complaint.getStatus() : "Pending" %>
        </span>
                                </td>
                                <td class="remark-cell" title="<%= complaint.getRemark() %>">
                                    <%= complaint.getRemark() != null ? complaint.getRemark() : "No remark yet" %>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary"
                                            onclick="event.stopPropagation(); selectComplaint('<%= complaint.getComplaint_id() %>', '<%= complaint.getTitle() %>', '<%= complaint.getDescription() %>')">
                                        Select
                                    </button>
                                </td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="9" class="text-center text-muted">No complaints found.</td>
                            </tr>
                            <%
                                }
                            %>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<%
    String msg = (String) session.getAttribute("complaintMessage");
    if (msg != null) {
        session.removeAttribute("complaintMessage"); // clear after showing
%>
<script>
    <% if ("success".equals(msg)) { %>
    Swal.fire({
        icon: 'success',
        title: 'Complaint submitted!',
        showConfirmButton: false,
        timer: 2000
    });
    <% } else if ("error".equals(msg)) { %>
    Swal.fire({
        icon: 'error',
        title: 'This complaint already in resolved state..!!!,',
        text: 'Please try again.',
        showConfirmButton: true
    });
    <% } else if ("updated".equals(msg)) { %>
    Swal.fire({
        icon: 'success',
        title: 'Updated!',
        text: 'Complaint updated successfully.',
        showConfirmButton: false,
        timer: 2000
    });
    <% } else if ("update-error".equals(msg)) { %>
    Swal.fire({
        icon: 'error',
        title: 'Update Failed!',
        text: 'Could not update complaint.',
        showConfirmButton: true
    });
    <% } else if ("deleted".equals(msg)) { %>
    Swal.fire({
        icon: 'success',
        title: 'Deleted!',
        text: 'Complaint deleted successfully.',
        showConfirmButton: false,
        timer: 2000
    });
    <% } else if ("delete-error".equals(msg)) { %>
    Swal.fire({
        icon: 'error',
        title: 'Delete Failed!',
        text: 'Something went wrong. Try again.',
        showConfirmButton: true
    });
    <% } %>
</script>
<% } %>

<script>
    let selectedRow = null;

    function selectComplaint(title,description,selectedComplaintId) {
        document.getElementById("submitBtn").disabled = true;
        // Set form values
        document.getElementById('complaintSubject').value = title;
        document.getElementById('complaintDescription').value = description;
        document.getElementById("complaintId").value = selectedComplaintId;

    }
    function resetForm() {
        document.getElementById("submitBtn").disabled =false;
        document.getElementById('complaintSubject').value = '';
        document.getElementById('complaintDescription').value = '';
    }
    const messages = document.querySelectorAll('.message');
    messages.forEach(message => {
        setTimeout(() => {
            message.style.opacity = '0';
            message.style.transform = 'translateX(-20px)';
            setTimeout(() => message.remove(), 300);
        }, 5000);
    });
</script>
</body>
</html>