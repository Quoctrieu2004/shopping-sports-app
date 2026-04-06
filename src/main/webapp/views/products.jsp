<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Products Page</title>
    </head>
    <body>
        <h1>Products Page</h1>
        
        <h3>Danh sách sản phẩm</h3>
        
        <c:if test="${not empty listProduct}">
            <c:forEach var="product" items="${listProduct}">
                <div>${product.name}</div>
            </c:forEach>
        </c:if>
        
        <c:if test="${empty listProduct}">
            <div>Chưa có sản phẩm nào.</div>
        </c:if>
        
        <div style="margin-top: 30px;">
            <a href="home">â Quay láº¡i Home</a>
        </div>
    </body>
</html>









