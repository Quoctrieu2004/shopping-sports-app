        <section class="vh-100" style="background-color: #eee;">
          <div class="container h-100">
            <div class="row d-flex justify-content-center align-items-center h-100">
              <div class="col-lg-12 col-xl-11">
                <div class="card text-black" style="border-radius: 25px;">
                  <div class="card-body p-md-5">
                    <div class="row justify-content-center">
                      <div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1">

                        <div class="text-center mb-4">
                            <h2>Sign up</h2>
                        </div>
                        
                        <!-- Hiển thị thông báo lỗi exist_user khi email/phone bị trùng -->
                        <c:if test="${not empty sessionScope.exist_user and sessionScope.exist_user ne ''}">
                            <div class="alert alert-danger" role="alert" style="margin-bottom: 1rem;">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                ${sessionScope.exist_user}
                            </div>
                        </c:if>
                        
                        <!-- Hiển thị thông báo lỗi từ session - chỉ khi có nội dung thực sự -->
                        <c:choose>
                            <c:when test="${not empty sessionScope.error_register and sessionScope.error_register ne ''}">
                                <div class="alert alert-danger" role="alert">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    ${sessionScope.error_register}
                                </div>
                            </c:when>
                            <c:when test="${not empty sessionScope.success_register and sessionScope.success_register ne ''}">
                                <div class="alert alert-success" role="alert">
                                    <i class="fas fa-check-circle me-2"></i>
                                    ${sessionScope.success_register}
                                </div>
                            </c:when>
                        </c:choose>

                        <form action="register" method="post">
                            <div class="d-flex flex-row align-items-center mb-4">
                                <i class="fas fa-user fa-lg me-3 fa-fw"></i>
                                <div class="form-outline flex-fill mb-0">
                                    <input type="text" id="form3Example1c" class="form-control" name="name" required />
                                    <label class="form-label" for="form3Example1c">Your Name</label>
                                </div>
                            </div>

                            <div class="d-flex flex-row align-items-center mb-4">
                                <i class="fas fa-envelope fa-lg me-3 fa-fw"></i>
                                <div class="form-outline flex-fill mb-0">
                                    <input type="email" id="form3Example3c" class="form-control" name="email" required />
                                    <label class="form-label" for="form3Example3c">Your Email</label>
                                    <span style="color: red">${sessionScope.err_email}</span>
                                </div>
                            </div>

                            <div class="d-flex flex-row align-items-center mb-4">
                                <i class="fas fa-phone fa-lg me-3 fa-fw"></i>
                                <div class="form-outline flex-fill mb-0">
                                    <input type="tel" id="form3Example4c" class="form-control" name="phone" required />
                                    <label class="form-label" for="form3Example4c">Your Phone</label>
                                    <span style="color: red">${sessionScope.err_phone}</span>
                                </div>
                            </div>

                            <div class="d-flex flex-row align-items-center mb-4">
                                <i class="fas fa-lock fa-lg me-3 fa-fw"></i>
                                <div class="form-outline flex-fill mb-0">
                                    <input type="password" id="form3Example4cd" class="form-control" name="password" required />
                                    <label class="form-label" for="form3Example4cd">Password</label>
                                </div>
                            </div>

                            <div class="d-flex flex-row align-items-center mb-4">
                                <i class="fas fa-key fa-lg me-3 fa-fw"></i>
                                <div class="form-outline flex-fill mb-0">
                                    <input type="password" id="form3Example4cde" class="form-control" name="repassword" required />
                                    <label class="form-label" for="form3Example4cde">Retype password</label>
                                    <span style="color: red">${sessionScope.err_repassword}</span>
                                </div>
                            </div>

                          <div class="form-check d-flex justify-content-center mb-3">
                            <input class="form-check-input me-2" type="checkbox" value="" id="form2Example3c" required="required" />
                            <label class="form-check-label" for="form2Example3">
                              I agree all statements in <a href="#!">Terms of service</a>
                            </label>
                          </div>

                          <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="fas fa-user-plus me-2"></i>
                                Register
                            </button>
                          </div>

                        </form>

                      </div>
                      <div class="col-md-10 col-lg-6 col-xl-7 d-flex align-items-center order-1 order-lg-2">

                        <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-registration/draw1.webp"
                          class="img-fluid" alt="Sample image">

                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
        
        <script>
            // Xóa các alert trống khi trang load
            document.addEventListener('DOMContentLoaded', function() {
                // Xóa tất cả alert trống
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(function(alert) {
                    // Kiểm tra nếu alert không có nội dung text
                    const textContent = alert.textContent || alert.innerText || '';
                    if (textContent.trim() === '') {
                        alert.style.display = 'none';
                        alert.remove();
                    }
                });
                
                // Xóa các element có thể gây ra thanh màu
                const emptyElements = document.querySelectorAll('.alert:empty, .alert:blank');
                emptyElements.forEach(function(element) {
                    element.remove();
                });
            });
        </script>









