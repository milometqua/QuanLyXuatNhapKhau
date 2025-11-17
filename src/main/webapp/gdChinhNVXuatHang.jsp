<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.NhanVien" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Nhân viên xuất hàng</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background-color: #f8f9fa;
            color: #1a202c;
        }

        /* Header */
        .header {
            background: white;
            border-bottom: 1px solid #e0e0e0;
            padding: 16px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-greeting {
            font-size: 16px;
        }

        .header-greeting strong {
            color: #2563eb;
            font-weight: 600;
        }

        .logout-btn {
            display: flex;
            align-items: center;
            gap: 8px;
            background-color: #fef2f2;
            color: #dc2626;
            border: 1px solid #fecaca;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s ease;
            text-decoration: none;
        }

        .logout-btn:hover {
            background-color: #fee2e2;
            border-color: #fca5a5;
        }

        /* Main Container */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 32px 24px;
        }

        /* Cards Grid */
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 24px;
        }

        /* Card */
        .card {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 24px;
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .card:hover {
            box-shadow: 0 10px 24px rgba(0, 0, 0, 0.08);
            border-color: #d1d5db;
            transform: translateY(-2px);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 16px;
        }

        .card-icon {
            width: 48px;
            height: 48px;
            background: #dbeafe;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }

        .card-badge {
            background-color: #fef3c7;
            color: #b45309;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .card-title {
            font-size: 20px;
            font-weight: 600;
            color: #1a202c;
            margin-bottom: 8px;
        }

        .card-description {
            font-size: 14px;
            color: #6b7280;
            line-height: 1.5;
            margin-bottom: 20px;
        }

        .card-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: #2563eb;
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
            transition: gap 0.2s ease;
        }

        .card-link:hover {
            gap: 10px;
        }

        .card-link-arrow {
            transition: transform 0.2s ease;
        }

        .card:hover .card-link-arrow {
            transform: translateX(4px);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 12px;
                text-align: center;
            }

            .container {
                padding: 20px 16px;
            }

            .cards-grid {
                grid-template-columns: 1fr;
            }

            .card-header {
                justify-content: center;
            }

            .card {
                text-align: center;
            }

            .card-link {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<%
    NhanVien nv = (NhanVien) session.getAttribute("nhanVien");
    if (nv == null) {
        response.sendRedirect("gdDangNhap.jsp");
        return;
    }
%>

<!-- Header -->
<div class="header">
    <div class="header-greeting">
        Xin chào, <strong><%= nv.getTen() %></strong>
    </div>
    <form action="gdDangNhap.jsp" method="post" style="margin: 0;">
        <button type="submit" class="logout-btn">
            <span>📤</span>
            Đăng Xuất
        </button>
    </form>
</div>

<!-- Main Content -->
<div class="container">
    <div class="cards-grid">
        <!-- Duyệt Đơn Hàng Card -->
        <div class="card">
            <div class="card-header">
                <div class="card-icon">📋</div>
                <div class="card-badge">5 mới</div>
            </div>
            <h2 class="card-title">Duyệt Đơn Hàng</h2>
            <p class="card-description">Xem và phê duyệt các đơn hàng trực tuyến</p>
            <form action="gdDuyetDonHang.jsp" method="get" style="margin: 0;">
                <button type="submit" style="background: none; border: none; padding: 0;">
                    <span class="card-link">
                        Bắt đầu
                        <span class="card-link-arrow">→</span>
                    </span>
                </button>
            </form>
        </div>
    </div>
</div>

</body>
</html>
