<%@ page import="model.ThanhVien, dao.ThanhVienDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String savedUser = "";
    String savedPass = "";

    ThanhVien tv = (ThanhVien) session.getAttribute("thanhvien");

    if (tv != null) {
        savedUser = tv.getTenDangNhap();
        savedPass = tv.getMatKhau();
    }

    String errorMessage = (String) session.getAttribute("error");
    session.removeAttribute("error");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập hệ thống</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary: #2563eb;
            --primary-dark: #1e40af;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --border: #e2e8f0;
            --background: #f8fafc;
            --error: #dc2626;
            --error-bg: #fee2e2;
            --error-border: #fecaca;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: var(--background);
            color: var(--text-primary);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 1rem;
        }

        .login-container {
            width: 100%;
            max-width: 500px;
            background: white;
            border-radius: 1rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
            animation: slideIn 0.5s ease-out;
            padding: 3rem 2.5rem;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }

        .login-header h1 {
            font-size: 2.25rem;
            font-weight: 700;
            margin-bottom: 0.75rem;
            color: var(--text-primary);
        }

        .login-header p {
            font-size: 0.95rem;
            color: var(--text-secondary);
            line-height: 1.5;
        }

        /* Styling cho error message container */
        .error-container {
            margin-bottom: 1.5rem;
        }

        .error-message {
            background: var(--error-bg);
            border: 1.5px solid var(--error-border);
            color: var(--error);
            padding: 1.25rem 1rem;
            border-radius: 0.5rem;
            font-size: 0.95rem;
            font-weight: 500;
            animation: shake 0.5s ease-in-out, slideDown 0.3s ease-out;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .error-icon {
            font-size: 1.25rem;
            flex-shrink: 0;
        }

        @keyframes shake {
            0%, 100% {
                transform: translateX(0);
            }
            25% {
                transform: translateX(-8px);
            }
            75% {
                transform: translateX(8px);
            }
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-group {
            margin-bottom: 1.75rem;
        }

        .form-group label {
            display: block;
            font-size: 0.875rem;
            font-weight: 600;
            margin-bottom: 0.75rem;
            color: var(--text-primary);
        }

        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            font-size: 1.25rem;
            color: var(--primary);
            pointer-events: none;
        }

        .form-group input {
            width: 100%;
            padding: 0.875rem 1rem 0.875rem 2.75rem;
            font-size: 0.95rem;
            border: 1.5px solid var(--border);
            border-radius: 0.5rem;
            background: white;
            color: var(--text-primary);
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .form-group input::placeholder {
            color: #b0b9c3;
        }

        .login-button {
            width: 100%;
            padding: 1rem;
            font-size: 1rem;
            font-weight: 600;
            color: white;
            background: var(--primary);
            border: none;
            border-radius: 0.5rem;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 1.5rem;
        }

        .login-button:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(37, 99, 235, 0.3);
        }

        .login-button:active {
            transform: translateY(0);
        }

        @media (max-width: 480px) {
            .login-container {
                padding: 2rem 1.5rem;
            }

            .login-header h1 {
                font-size: 1.875rem;
            }

            .login-header p {
                font-size: 0.875rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h1>Đăng Nhập</h1>
            <p>Hệ thống quản lý đại lý xuất nhập khẩu trung gian</p>
        </div>

        <!-- Hiển thị error message từ server-side nếu có -->
        <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
            <div class="error-container">
                <div class="error-message">
                    <span class="error-icon">⚠️</span>
                    <span><%= errorMessage %></span>
                </div>
            </div>
        <% } %>

        <form action="gdDoDangNhap.jsp" method="post">
            <div class="form-group">
                <label for="tenDangNhap">Tên đăng nhập</label>
                <div class="input-wrapper">
                    <span class="input-icon">👤</span>
                    <input 
                        type="text" 
                        id="tenDangNhap"
                        name="tenDangNhap" 
                        value="<%= savedUser %>"
                        placeholder="Nhập tên đăng nhập"
                        required
                    >
                </div>
            </div>

            <div class="form-group">
                <label for="matKhau">Mật khẩu</label>
                <div class="input-wrapper">
                    <span class="input-icon">🔒</span>
                    <input 
                        type="password" 
                        id="matKhau"
                        name="matKhau" 
                        value="<%= savedPass %>"
                        placeholder="Nhập mật khẩu"
                        required
                    >
                </div>
            </div>

            <button type="submit" class="login-button">Đăng Nhập</button>
        </form>
    </div>
</body>
</html>
