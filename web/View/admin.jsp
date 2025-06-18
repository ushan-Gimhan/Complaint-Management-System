<%@ page import="com.service.Project.Model.ComplaintModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Complaint Management System</title>
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

        .admin-info {
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

        .btn-danger {
            background: linear-gradient(45deg, #dc3545, #c82333);
            border: none;
            padding: 12px 24px;
            font-weight: 500;
            border-radius: 8px;
        }

        .btn-danger:hover {
            background: linear-gradient(45deg, #c82333, #a71e2a);
            transform: translateY(-1px);
        }

        .complaint-details {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            display: none;
        }

        .complaint-details.show {
            display: block;
        }

        .complaint-details .form-control[readonly] {
            background-color: #f8f9fa;
            border-color: #dee2e6;
            text-transform: uppercase;
            font-weight: 500;
        }

        .complaint-details .form-control[readonly]#complaintDescription {
            text-transform: uppercase;
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

        .alert-danger {
            border-radius: 10px;
            border: none;
            background: linear-gradient(45deg, #f8d7da, #f1aeb5);
        }

        .table th {
            white-space: nowrap;
            background: #000000 !important;
            color: white !important;
            border-color: #333333 !important;
        }

        .table-dark th {
            background: #000000 !important;
            border-color: #333333 !important;
        }

        .table tbody tr {
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .table tbody tr:hover {
            background-color: #f8f9fa;
        }

        .table tbody tr.selected {
            background-color: #e3f2fd !important;
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

        .description-cell {
            max-width: 200px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .description-cell:hover {
            overflow: visible;
            white-space: normal;
            word-wrap: break-word;
        }

        .status-badge {
            font-size: 0.8rem;
            padding: 0.4rem 0.8rem;
        }

        .stats-card {
            background: linear-gradient(135deg, #fff, #f8f9fa);
            border-left: 4px solid #007bff;
            padding: 1rem;
            margin-bottom: 1rem;
        }

        .stats-number {
            font-size: 2rem;
            font-weight: 700;
            color: #007bff;
        }

        .update-section {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1rem;
            margin-top: 1rem;
        }

        .button-group {
            gap: 10px;
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="fas fa-user-shield me-2"></i>
            Admin Dashboard - Complaint Management
        </a>
        <div class="navbar-nav ms-auto">
            <div class="admin-info">
                <i class="fas fa-user-circle me-1"></i>
                Admin Panel
            </div>
            <div class="navbar-nav ms-auto">
                <a href="<%= request.getContextPath() %>/View/Login.jsp" class="btn btn-outline-light">
                    <i class="fas fa-sign-out-alt me-1"></i> Logout
                </a>
            </div>
        </div>
    </div>
</nav>

<div class="container-fluid main-container">
    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="stats-card">
                <div class="stats-number">8</div>
                <div class="text-muted">Total Complaints</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stats-card" style="border-left-color: #ffc107;">
                <div class="stats-number" style="color: #ffc107;">3</div>
                <div class="text-muted">Pending</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stats-card" style="border-left-color: #17a2b8;">
                <div class="stats-number" style="color: #17a2b8;">3</div>
                <div class="text-muted">In Progress</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stats-card" style="border-left-color: #28a745;">
                <div class="stats-number" style="color: #28a745;">2</div>
                <div class="text-muted">Resolved</div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Complaints Table -->
        <div class="col-lg-7">
            <div class="card">
                <div class="card-header">
                    <h5><i class="fas fa-list me-2"></i>All Complaints</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                            <tr>
                                <th>Complaint ID</th>
                                <th>Subject</th>
                                <th>UserID</th>
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
                            <tr onclick="selectComplaint('<%= complaint.getComplaint_id() %>','<%= complaint.getUser_id() %>','<%= complaint.getDate() %>', '<%= complaint.getTitle() %>', '<%= complaint.getDescription() %>','<%= complaint.getStatus() %>','<%= complaint.getRemark() %>')">
                                <td><%= complaint.getComplaint_id() %></td>
                                <td><%= complaint.getTitle() %></td>
                                <td><%= complaint.getUser_id() %></td>
                                <td><%= complaint.getDate() %></td>
                                <td><%= complaint.getDescription() %></td>;
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

        <!-- Complaint Details & Update Form -->
        <div class="col-lg-5">
            <div class="card">
                <div class="card-header">
                    <h5><i class="fas fa-edit me-2"></i>Complaint Details & Update</h5>
                </div>
                <div class="card-body">
                    <div id="noSelectionMessage" class="text-center text-muted py-5">
                        <i class="fas fa-mouse-pointer fa-3x mb-3"></i>
                        <p>Select a complaint from the table to view details and update status</p>
                    </div>

                    <div id="complaintDetails" class="complaint-details">
                        <!-- Success Message -->
                        <div id="successAlert" class="alert alert-success d-none" role="alert">
                            <i class="fas fa-check-circle me-2"></i>
                            <strong>Success!</strong> Complaint has been updated successfully.
                        </div>

                        <!-- Delete Success Message -->
                        <div id="deleteAlert" class="alert alert-danger d-none" role="alert">
                            <i class="fas fa-trash-alt me-2"></i>
                            <strong>Deleted!</strong> Complaint has been deleted successfully.
                        </div>

                        <form action="admin" method="post" id="complaintForm">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="complaintId" class="form-label">Complaint ID</label>
                                    <input type="text" class="form-control" name="complaintId" id="complaintId" readonly>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="complaintDate" class="form-label">Date Submitted</label>
                                    <input type="text" class="form-control" id="complaintDate" readonly>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12 mb-3">
                                    <label for="userName" class="form-label">User ID</label>
                                    <input type="text" class="form-control" id="userName" readonly>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="complaintSubject" class="form-label">Subject</label>
                                <input type="text" class="form-control" id="complaintSubject" readonly>
                            </div>

                            <div class="mb-3">
                                <label for="complaintDescription" class="form-label">Description</label>
                                <textarea class="form-control" id="complaintDescription" rows="4" readonly></textarea>
                            </div>

                            <div class="update-section">
                                <h6 class="mb-3"><i class="fas fa-tools me-2"></i>Update Complaint</h6>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="complaintStatus" class="form-label required">Status</label>
                                        <select class="form-select" id="complaintStatus" required>
                                            <option value="">Select Status</option>
                                            <option value="Pending">Pending</option>
                                            <option value="In Progress">In Progress</option>
                                            <option value="Resolved">Resolved</option>
                                            <option value="Closed">Closed</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="adminRemark" class="form-label required">Admin Remark</label>
                                    <textarea class="form-control" id="adminRemark" rows="3" required placeholder="Enter your remark or update about this complaint..."></textarea>
                                    <div class="form-text">Provide detailed information about the action taken or current status</div>
                                </div>

                                <div class="d-grid gap-2 d-md-flex justify-content-md-end button-group">
                                    <button type="button" class="btn btn-outline-secondary me-md-2" onclick="clearSelection()">
                                        <i class="fas fa-times me-2"></i>Clear Selection
                                    </button>
                                    <button type="button" name="action" value="delete" class="btn btn-danger me-md-2">
                                        <i class="fas fa-trash-alt me-2"></i>Delete
                                    </button>
                                    <button type="button" name="action" value="update" class="btn btn-primary">
                                        <i class="fas fa-save me-2"></i>Update Complaint
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
    let selectedRow = null;

    function selectComplaint(id, userId,subject, date, description, status, remark) {
        // Show detail section
        document.getElementById('noSelectionMessage').style.display = 'none';
        document.getElementById('complaintDetails').classList.add('show');

        // Set form values
        document.getElementById('complaintId').value = id;
        document.getElementById('complaintDate').value = subject;
        document.getElementById('userName').value = userId;
        document.getElementById('complaintSubject').value = date;
        document.getElementById('complaintDescription').value = description;
        document.getElementById('complaintStatus').value = status;
        document.getElementById('adminRemark').value = remark === 'No remark yet' ? '' : remark;

        // Hide any alerts
        document.getElementById('successAlert').classList.add('d-none');
        document.getElementById('deleteAlert').classList.add('d-none');
    }
    function clearSelection() {

        const form = document.getElementById('complaintForm');
        if (form) {
            form.reset();
        }

        // Hide details panel, show "no selection" message
        document.getElementById('complaintDetails').classList.remove('show');
        document.getElementById('noSelectionMessage').style.display = 'block';

        // Clear selected row styling
        if (selectedRow) {
            selectedRow.classList.remove('selected');
            selectedRow = null;
        }
    }

</script>
</body>
</html>