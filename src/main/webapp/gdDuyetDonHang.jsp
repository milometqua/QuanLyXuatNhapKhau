<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.HoaDonBanDAO" %>
<%@ page import="model.HoaDonBan" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%
    Object obj = session.getAttribute("nhanVien");
    if (obj == null) {
        response.sendRedirect("gdDangNhap.jsp");
        return;
    }

    HoaDonBanDAO dao = new HoaDonBanDAO();
    List<HoaDonBan> ds = dao.getHoaDon("Chờ xác nhận");

    NumberFormat vn = NumberFormat.getInstance(new Locale("vi", "VN"));
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Duyệt Đơn Hàng</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f7f7f7;
            padding: 20px;
        }
        h1 {
            margin-bottom: 20px;
        }
        
        .back-btn {
            display: inline-block;
            padding: 10px 18px;
            background: #e2e8f0;
            color: #1e293b;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
            margin-bottom: 20px;
            border: 1px solid #cbd5e1;
        }

        .back-btn:hover {
            background: #cbd5e1;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 14px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        th {
            background: #2563eb;
            color: white;
        }

        tr:hover {
            background: #f1f5f9;
        }

        .status {
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 13px;
            color: white;
            background: #f59e0b;
        }
    </style>
</head>
<body>

<a href="gdChinhNVXuatHang.jsp" class="back-btn">← Quay lại</a>

<h1>Danh sách hóa đơn cần duyệt</h1>

<table>
    <tr>
        <th>Mã đơn</th>
        <th>Khách hàng</th>
        <th>Số lượng mặt hàng</th>
        <th>Tổng tiền</th>
        <th>Ngày đặt</th>
        <th>Trạng thái</th>
    </tr>

    <% for (HoaDonBan hd : ds) { %>
        <tr onclick="submitHD(<%= hd.getId() %>)" style="cursor:pointer;">
            <td><%= hd.getId() %></td>
            <td><%= hd.getKhachHang().getTen() %></td>
            <td><%= hd.tongMatHang() %></td>
            <td><%= vn.format(hd.tinhTongTien()) %>đ</td>
            <td><%= hd.getNgayDatHang() %></td>
            <td><span class="status"><%= hd.getTrangThai() %></span></td>
        </tr>
    <% } %>
</table>

<form id="goForm" action="gdLuuThongTinHoaDon.jsp" method="post">
    <input type="hidden" name="idHD" id="idHD">
</form>

<script>
function submitHD(idHD) {
    document.getElementById("idHD").value = idHD;
    document.getElementById("goForm").submit();
}
</script>

</body>
</html>
