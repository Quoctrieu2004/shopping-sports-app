<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="data.utils.API" %>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
          <div class="container-fluid">
            <a class="navbar-brand" href="home">
                <img src="assets/icon/logo.png" width="70" height="70"/>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
              <ul class="navbar-nav me-auto mb-2 mb-lg-0" style="margin: 0 auto;">
                <li class="nav-item">
                  <a class="nav-link active" aria-current="page" href="home">Home</a>
                </li>
                    
                <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    Category
                  </a>
                  <ul class="dropdown-menu">
                      <c:forEach var="category" items="${listCategory}">
                    <li><a class="dropdown-item" href="home?id_category=${category.id}">
                        ${category.name}
                        </a></li>
                      </c:forEach>
                  </ul>
                </li>
                <c:if test="${sessionScope.user==null}">
                <li class="nav-item">
                    <a class="nav-link" href="login">Login</a>
                </li>
                </c:if>
                <c:if test="${sessionScope.user!=null}">
                     <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    Hi ${sessionScope.splitname}

                  </a>
                  <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#">Profile</a></li>
                    <li><a class="dropdown-item" href="logout">Logout</a></li>
                  </ul>
                </li>
                </c:if>
                <li class="nav-item">
                    <c:choose>
                        <c:when test="${sessionScope.user != null}">
                            <a class="nav-link" href="cart?action=view">
                                <i class="fas fa-shopping-cart"></i>
                                <span class="badge bg-danger rounded-pill">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.cart}">
                                            ${sessionScope.cart.size()}
                                        </c:when>
                                        <c:otherwise>
                                            0
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a class="nav-link" href="login">
                                <i class="fas fa-shopping-cart"></i>
                                <span class="badge bg-danger rounded-pill">0</span>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </li>
              </ul>
              <form class="d-flex" role="search" action="search" method="GET">
                <input class="form-control me-2" type="search" name="q" placeholder="Tìm kiếm sản phẩm..." aria-label="Search" required/>
                <button class="btn btn-outline-success" type="submit">Search</button>
              </form>
            </div>
          </div>
        </nav>









