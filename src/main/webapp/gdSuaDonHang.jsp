<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.HoaDonBanDAO" %>
<%@ page import="model.HoaDonBan" %>
<%@ page import="model.CTDonHang" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%
    HoaDonBanDAO dao = new HoaDonBanDAO();
    HoaDonBan hd = (HoaDonBan) session.getAttribute("hoaDonDangChon");

    if (hd == null) {
        out.println("Không tìm thấy hóa đơn!");
        return;
    }

    List<CTDonHang> dsCT = hd.getDsCTDonHang();
    NumberFormat vn = NumberFormat.getInstance(new Locale("vi", "VN"));
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa đơn hàng</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f1f5f9;
            padding: 20px;
        }

        .container {
            max-width: 900px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.08);
        }

        h1 {
            font-size: 22px;
            margin-bottom: 20px;
            color: #1e293b;
        }

        .back-btn {
            background: #e2e8f0;
            color: #1e293b;
            padding: 8px 14px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
        }

        .section-box {
            padding: 15px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .info-label {
            font-weight: bold;
            display: block;
            margin-top: 10px;
            color: #334155;
        }

        .info-input {
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #cbd5e1;
            margin-top: 5px;
            margin-bottom: 10px;
            font-size: 15px;
        }

        table {
            width: 100%;
            margin-top: 12px;
            border-collapse: separate;
            border-spacing: 0;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        th {
            background: #2563eb;
            color: white;
            padding: 12px;
            font-weight: 600;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #e2e8f0;
            text-align: center;
            font-size: 15px;
        }

        .soLuong {
            width: 70px;
            padding: 6px;
            border-radius: 6px;
            border: 1px solid #cbd5e1;
            text-align: center;
        }

        td.gia, td.thanhTien {
            font-weight: 600;
            color: #0f172a;
        }

        .delete-btn {
            background: #fee2e2;
            color: #b91c1c;
            border: 1px solid #fecaca;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn.save-btn {
            background: #16a34a;
            padding: 10px 20px;
            font-size: 15px;
            color: white;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            margin-top: 18px;
        }
        
        /* Sửa cách ẩn row - thêm height để ẩn mượt hơn */
        tr.hidden {
            display: none !important;
        }
    </style>
</head>

<body>

<div class="container">

    <a href="gdChiTietDonHang.jsp" class="back-btn">← Quay lại</a>

    <h1>Sửa hóa đơn #<%= hd.getId() %></h1>

    <form action="doSuaDonHang.jsp" method="post">

        <input type="hidden" name="idHD" value="<%= hd.getId() %>">

        <!-- Thông tin khách hàng -->
        <div class="section-box">
            <h3>Thông tin khách hàng</h3>

            <label class="info-label">Tên khách hàng</label>
            <input class="info-input" type="text" name="tenKH"
                   value="<%= hd.getKhachHang().getTen() %>">

            <label class="info-label">Số điện thoại</label>
            <input class="info-input" type="text" name="sdt"
                   value="<%= hd.getKhachHang().getSoDienThoai() %>">

            <label class="info-label">Địa chỉ</label>
            <input class="info-input" type="text" name="diaChi"
                   value="<%= hd.getKhachHang().getDiaChi() %>">
        </div>

        <h3>Chi tiết mặt hàng</h3>

        <table id="tableCT">
		    <tr>
		        <th>STT</th>
		        <th>Sản phẩm</th>
		        <th>Đơn giá</th>
		        <th>Tồn kho</th>
		        <th>Số lượng</th>
		        <th>Thành tiền</th>
		        <th>Xóa</th>
		    </tr>
		
		    <% 
		        int stt = 1;
		        for (CTDonHang ct : dsCT) { 
		            int tonKho = ct.getMatHang().getSoLuongTonKho();
		    %>
		        <tr data-id="<%= ct.getId() %>">
		            <td><%= stt++ %></td>
		
		            <td><%= ct.getMatHang().getTen() %></td>
		
		            <td class="gia"><%= vn.format(ct.getDonGia()) %> đ</td>
		
		            <td class="tonKho"><%= tonKho %></td>
		
		            <td>
		                <input type="number" class="soLuong"
		                       name="soLuong_<%= ct.getId() %>"
		                       value="<%= ct.getSoLuong() %>"
		                       min="1" max="<%= tonKho %>">
		            </td>
		
		            <td class="thanhTien">
		                <%= vn.format(ct.getSoLuong() * ct.getDonGia()) %> đ
		            </td>
		
		            <td>
		                <button type="button" class="delete-btn"
		                        onclick="xoaMatHang(<%= ct.getId() %>); return false;">X</button>
		
		                <input class="flagXoa" type="hidden" 
		                       name="xoa_<%= ct.getId() %>"
		                       data-id="<%= ct.getId() %>"
		                       value="0">
		            </td>
		        </tr>
		    <% } %>
		</table>


        <br>
        <h3>Tổng tiền: <span id="tongTienText">0</span> đ</h3>
        <input type="hidden" name="tongTien" id="tongTienInput" value="0">

        <button type="submit" class="btn save-btn">Lưu thay đổi</button>
    </form>

    <script>
        function tinhTong() {
            let tong = 0;

            const rows = document.querySelectorAll("#tableCT tr[data-id]");

            rows.forEach(row => {
                const isHidden = row.classList.contains("hidden");
                
                if (isHidden) {
                    return; // Skip this row
                }

                const giaText = row.querySelector(".gia").textContent;
                const gia = Number(giaText.replace(/[^\d]/g, ""));

                const soLuong = Number(row.querySelector(".soLuong").value);
                const thanhTien = gia * soLuong;


                row.querySelector(".thanhTien").textContent = thanhTien.toLocaleString("vi-VN") + " đ";

                tong += thanhTien;
            });

            document.getElementById("tongTienText").textContent = tong.toLocaleString("vi-VN");
            document.getElementById("tongTienInput").value = tong;
        }

        function xoaMatHang(id) {
            
            const rows = document.querySelectorAll("#tableCT tr[data-id]");
            let row = null;
            
            for (let r of rows) {
                if (r.dataset.id == id) {
                    row = r;
                    break;
                }
            }
            

            if (!row) {
                return false;
            }

            const flagInput = row.querySelector(`input[name="xoa_${id}"]`);
            
            if (flagInput) {
                flagInput.value = "1";
            }

            row.classList.add("hidden");

            const allRows = document.querySelectorAll("#tableCT tr[data-id]");
            let newStt = 1;
            allRows.forEach(r => {
                if (!r.classList.contains("hidden")) {
                    r.querySelector("td").textContent = newStt++;
                }
            });

            tinhTong();
            
            return false;
        }

        document.querySelectorAll(".soLuong").forEach(input => {
            input.addEventListener("input", function() {
                let row = input.closest("tr");
                let tonKho = Number(row.querySelector(".tonKho").textContent);
                let sl = Number(input.value);

                if (sl > tonKho) {
                    alert("Số lượng vượt quá tồn kho (" + tonKho + ")!");
                    input.value = tonKho;
                    sl = tonKho;
                }
                else if (sl < 1){
                	input.value = 1;
                	sl = 1;
                }

                tinhTong();
            });
        });

        tinhTong();
    </script>

</div>

</body>
</html>
