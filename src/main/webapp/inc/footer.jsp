<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <footer class="text-white" style="background: #0f172a;">
        <!-- CTA / Newsletter -->
        <section class="py-4" style="background: linear-gradient(90deg,#6d28d9 0%,#4f46e5 50%,#06b6d4 100%);">
          <div class="container d-flex flex-column flex-lg-row align-items-center justify-content-between gap-3">
            <h6 class="m-0 fw-bold">Nhận ưu đãi mới mỗi tuần</h6>
            <form class="d-flex gap-2" onsubmit="event.preventDefault();">
              <input type="email" class="form-control" placeholder="Nhập email của bạn" style="border-radius: 10px; min-width: 260px;">
              <button class="btn btn-dark" style="border-radius: 10px;">Đăng ký</button>
            </form>
          </div>
        </section>

        <!-- Main -->
        <section class="pt-5 pb-4">
          <div class="container text-center text-md-start">
            <div class="row g-4">
              <div class="col-md-4">
                <h5 class="fw-bold mb-3">Sport Store</h5>
                <p class="text-white-50 mb-3">Cửa hàng thể thao với sản phẩm chính hãng, giá tốt và dịch vụ tận tâm. Giao nhanh toàn quốc.</p>
                <div class="d-flex gap-3">
                  <a href="#" class="text-white-50"><i class="fab fa-facebook-f"></i></a>
                  <a href="#" class="text-white-50"><i class="fab fa-instagram"></i></a>
                  <a href="#" class="text-white-50"><i class="fab fa-tiktok"></i></a>
                  <a href="#" class="text-white-50"><i class="fab fa-youtube"></i></a>
                </div>
              </div>

              <div class="col-md-3">
                <h6 class="text-uppercase fw-bold">Danh mục</h6>
                <hr class="mt-2 mb-3" style="width:60px;height:2px;background:#7c4dff;border:0;">
                <ul class="list-unstyled m-0">
                  <c:forEach var="c" items="${listCategory}" varStatus="s">
                    <c:if test="${s.index < 6}">
                      <li class="mb-2"><a class="text-white-50 text-decoration-none" href="home?id_category=${c.id}">${c.name}</a></li>
                    </c:if>
                  </c:forEach>
                </ul>
              </div>

              <div class="col-md-3">
                <h6 class="text-uppercase fw-bold">Hỗ trợ</h6>
                <hr class="mt-2 mb-3" style="width:60px;height:2px;background:#7c4dff;border:0;">
                <ul class="list-unstyled m-0">
                  <li class="mb-2"><a class="text-white-50 text-decoration-none" href="#">Tài khoản của bạn</a></li>
                  <li class="mb-2"><a class="text-white-50 text-decoration-none" href="#">Đơn hàng</a></li>
                  <li class="mb-2"><a class="text-white-50 text-decoration-none" href="#">Vận chuyển</a></li>
                  <li class="mb-2"><a class="text-white-50 text-decoration-none" href="#">Trung tâm trợ giúp</a></li>
                </ul>
              </div>

              <div class="col-md-2">
                <h6 class="text-uppercase fw-bold">Liên hệ</h6>
                <hr class="mt-2 mb-3" style="width:60px;height:2px;background:#7c4dff;border:0;">
                <ul class="list-unstyled m-0 text-white-50">
                  <li class="mb-2"><i class="fas fa-home me-2"></i>Đại học Khoa học Huế, Thành phố Huế, Việt Nam</li>
                  <li class="mb-2"><i class="fas fa-envelope me-2"></i>22T1020774@husc.edu.vn</li>
                  <li class="mb-2"><i class="fas fa-phone me-2"></i>0702679156</li>
                </ul>
              </div>
            </div>
          </div>
        </section>

        <!-- Bottom bar -->
        <div class="text-center small text-white-50 py-3" style="background:#0b1220;">© 2024 Sport Store. All rights reserved.</div>
      </footer>

      </body>
    </html>









