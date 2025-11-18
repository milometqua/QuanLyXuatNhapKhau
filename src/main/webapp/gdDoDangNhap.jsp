<%@ page import="model.ThanhVien, dao.ThanhVienDAO, dao.NhanVienDAO, model.NhanVien" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    request.setCharacterEncoding("UTF-8");
    String tenDangNhap = request.getParameter("tenDangNhap");
    String matKhau = request.getParameter("matKhau");

    ThanhVien tv = new ThanhVien();
    tv.setTenDangNhap(tenDangNhap);
    tv.setMatKhau(matKhau);
    session.setAttribute("thanhvien", tv);

    ThanhVienDAO tvDAO = new ThanhVienDAO();
    ThanhVien thanhVienHopLe = tvDAO.checkLogin(tv);

    if (thanhVienHopLe != null) {
        if ("NhanVien".equalsIgnoreCase(thanhVienHopLe.getVaiTro())) {
            NhanVienDAO nvDAO = new NhanVienDAO();
            NhanVien nv = nvDAO.getNhanVien(thanhVienHopLe);
            if (nv != null && "Nhân viên xuất hàng".equalsIgnoreCase(nv.getChucVu())) {
                session.setAttribute("nhanVien", nv);
                response.sendRedirect("gdChinhNVXuatHang.jsp");
                return;
            }
        }

        session.setAttribute("error", "Bạn không có quyền truy cập hệ thống xuất hàng.");
        response.sendRedirect("gdDangNhap.jsp");
    } else {
        session.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu.");
        response.sendRedirect("gdDangNhap.jsp");
    }
%>
