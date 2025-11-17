<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.HoaDonBanDAO" %>
<%@ page import="model.HoaDonBan" %>
<%@ page import="model.CTDonHang" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%
    // Kiểm tra đăng nhập
    if (session.getAttribute("nhanVien") == null) {
        response.sendRedirect("gdDangNhap.jsp");
        return;
    }

	int idHD = (Integer) session.getAttribute("idHoaDon");

    HoaDonBanDAO dao = new HoaDonBanDAO();

    HoaDonBan hd = dao.getHoaDonTheoID(idHD);
    List<CTDonHang> dsCT = hd.getDsCTDonHang();

    NumberFormat vn = NumberFormat.getInstance(new Locale("vi", "VN"));
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết hóa đơn</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f1f5f9;
            padding: 20px;
        }

        .container {
            max-width: 900px;
            margin: auto;
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        h1 {
            margin-bottom: 20px;
            color: #1e293b;
        }

        .info-box {
            margin-bottom: 25px;
            padding: 15px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
        }

        .info-box p {
            margin: 6px 0;
            font-size: 16px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #e2e8f0;
            text-align: left;
        }

        th {
            background: #2563eb;
            color: white;
        }

        tr:hover {
            background: #f1f5f9;
        }

        .btn-back {
            display: inline-block;
            margin-right: 10px;
            padding: 10px 16px;
            background: #e2e8f0;
            border-radius: 6px;
            color: #1e293b;
            text-decoration: none;
            border: 1px solid #cbd5e1;
        }

        .btn-back:hover {
            background: #cbd5e1;
        }

        .btn-approve {
            padding: 10px 20px;
            background: #16a34a;
            color: white;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-size: 15px;
        }

        .btn-approve:hover {
            background: #15803d;
        }

        .total {
            text-align: right;
            font-size: 18px;
            margin-top: 15px;
            font-weight: bold;
        }

        .status {
            display: inline-block;
            padding: 6px 10px;
            background: #f59e0b;
            color: white;
            border-radius: 20px;
            font-size: 13px;
        }
    </style>
</head>

<body>

<div class="container">
    <a href="gdDuyetDonHang.jsp" class="btn-back">← Quay lại</a>

    <h1>Chi tiết hóa đơn #<%= hd.getId() %></h1>

    <div class="info-box">
        <p><b>Khách hàng:</b> <%= hd.getKhachHang().getTen() %></p>
        <p><b>Số điện thoại:</b> <%= hd.getKhachHang().getSoDienThoai() %></p>
        <p><b>Địa chỉ:</b> <%= hd.getKhachHang().getDiaChi() %></p>
        <p><b>Ngày đặt:</b> <%= hd.getNgayDatHang() %></p>
        <p><b>Trạng thái:</b> <span class="status"><%= hd.getTrangThai() %></span></p>
    </div>

    <h2>Chi tiết mặt hàng</h2>

    <table>
        <tr>
            <th>STT</th>
            <th>Sản phẩm</th>
            <th>Số lượng</th>
            <th>Đơn giá</th>
            <th>Thành tiền</th>
        </tr>

        <% int i = 1;
        for (CTDonHang ct : dsCT) { %>
            <tr>
                <td><%= i++ %></td>
                <td><%= ct.getMatHang().getTen() %></td>
                <td><%= ct.getSoLuong() %></td>
                <td><%= vn.format(ct.getDonGia()) %> đ</td>
                <td><%= vn.format(ct.getSoLuong() * ct.getDonGia()) %> đ</td>
            </tr>
        <% } %>
    </table>

    <p class="total">Tổng tiền: <%= vn.format(dao.getTongTien(idHD)) %> đ</p>

    <form action="gdXacNhanDuyet.jsp" method="post">
        <input type="hidden" name="idHD" value="<%= idHD %>">
        <button class="btn-approve">Duyệt đơn hàng</button>
    </form>
</div>

</body>
</html>
