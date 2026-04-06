<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forgot Password</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/css/style.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="text-center">Forgot Password</h3>
                        </div>
                        <div class="card-body">
                            
                            <!-- Error Message -->
                            <c:if test="${not empty sessionScope.error_forgot}">
                                <div class="alert alert-danger" role="alert">
                                    ${sessionScope.error_forgot}
                                    <c:remove var="error_forgot" scope="session" />
                                </div>
                            </c:if>
                            
                            <!-- Success Message -->
                            <c:if test="${not empty sessionScope.success_forgot}">
                                <div class="alert alert-success" role="alert">
                                    ${sessionScope.success_forgot}
                                    <c:remove var="success_forgot" scope="session" />
                                </div>
                            </c:if>
                            
                            <form action="forgot-password" method="POST">
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" 
                                           placeholder="Enter your email" required>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="phone" class="form-label">Phone (Alternative)</label>
                                    <input type="text" class="form-control" id="phone" name="phone" 
                                           placeholder="Enter your phone number">
                                    <small class="form-text text-muted">You can use either email or phone</small>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="newPassword" class="form-label">New Password</label>
                                    <input type="password" class="form-control" id="newPassword" name="newPassword" 
                                           placeholder="Enter new password" required>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                                           placeholder="Confirm new password" required>
                                </div>
                                
                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary">Reset Password</button>
                                </div>
                            </form>
                            
                            <div class="text-center mt-3">
                                <a href="login" class="text-decoration-none">Back to Login</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script>
            // Validate password match
            document.getElementById('confirmPassword').addEventListener('input', function() {
                const password = document.getElementById('newPassword').value;
                const confirmPassword = this.value;
                
                if (password !== confirmPassword) {
                    this.setCustomValidity('Passwords do not match');
                } else {
                    this.setCustomValidity('');
                }
            });
        </script>
    </body>
</html>
