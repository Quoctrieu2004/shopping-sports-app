<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${title}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            /* Custom CSS để đảm bảo form đăng ký hiển thị đúng */
            .form-outline {
                position: relative;
            }
            
            .form-control:focus {
                border-color: #86b7fe;
                box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
            }
            
            /* Ẩn hoàn toàn các alert trống */
            .alert:empty,
            .alert:blank,
            .alert:not(:has(*)) {
                display: none !important;
                height: 0 !important;
                padding: 0 !important;
                margin: 0 !important;
                border: none !important;
                background: none !important;
            }
            
            /* Đảm bảo alert chỉ hiển thị khi có nội dung */
            .alert {
                margin-bottom: 1rem;
                min-height: auto;
            }
            
            /* Loại bỏ các thanh màu lạ từ MDB */
            .form-outline::before,
            .form-outline::after {
                display: none !important;
                content: none !important;
            }
            
            /* Override MDB styles */
            .form-outline .form-control {
                border: 1px solid #ced4da;
                border-radius: 0.375rem;
                padding: 0.375rem 0.75rem;
                font-size: 1rem;
                line-height: 1.5;
                color: #212529;
                background-color: #fff;
                transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
            }
            
            .form-outline .form-control:focus {
                border-color: #86b7fe;
                box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
                outline: 0;
            }
            
            /* Đảm bảo input fields có style đúng */
            .form-control {
                border: 1px solid #ced4da;
                border-radius: 0.375rem;
                padding: 0.375rem 0.75rem;
                font-size: 1rem;
                line-height: 1.5;
                color: #212529;
                background-color: #fff;
            }
            
            /* Style cho icons */
            .fa-lg {
                font-size: 1.25em;
                color: #6c757d;
            }
            
            /* Style cho labels */
            .form-label {
                color: #495057;
                font-weight: 500;
                margin-bottom: 0.5rem;
            }
            
            /* Loại bỏ tất cả pseudo-elements có thể gây ra thanh màu */
            *::before,
            *::after {
                box-sizing: border-box;
            }
            
            /* Đảm bảo form không có border lạ */
            .form-outline {
                border: none !important;
                background: none !important;
            }
            
            /* Style cho card */
            .card {
                border: none;
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            }
            
            /* Style cho button */
            .btn-primary {
                background-color: #0d6efd;
                border-color: #0d6efd;
                padding: 0.75rem 1.5rem;
                font-size: 1.1rem;
                font-weight: 500;
            }
            
            .btn-primary:hover {
                background-color: #0b5ed7;
                border-color: #0a58ca;
            }
            
            /* Ẩn tất cả các element có thể gây ra thanh màu */
            .alert-danger:empty,
            .alert-success:empty,
            .alert-warning:empty,
            .alert-info:empty {
                display: none !important;
                visibility: hidden !important;
                opacity: 0 !important;
                height: 0 !important;
                width: 0 !important;
                overflow: hidden !important;
            }
        </style>
    </head>
    <body>









