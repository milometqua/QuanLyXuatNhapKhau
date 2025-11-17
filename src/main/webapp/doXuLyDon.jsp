<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.Date" %>
<%@ page import="dao.HoaDonBanDAO" %>
<%@ page import="dao.HoaDonNhanVienDAO" %>
<%@ page import="model.HoaDonBan" %>
<%@ page import="model.HoaDonNhanVien" %>
<%@ page import="model.NhanVien" %>

<%
    int idHD = Integer.parseInt(request.getParameter("idHD"));
    String action = request.getParameter("action");

    HoaDonBanDAO hdDAO = new HoaDonBanDAO();
    HoaDonNhanVienDAO hdnvDAO = new HoaDonNhanVienDAO();

    HoaDonBan hd = hdDAO.getHoaDonTheoID(idHD);

    if (action.equals("duyet")) {
        hd.duyet();
    } else {
        hd.huy();
    }

    boolean ok1 = hdDAO.capNhatTrangThai(hd);

    HoaDonNhanVien hdnv = new HoaDonNhanVien();
    hdnv.setVaiTro(action.equals("duyet") ? "Người duyệt đơn" : "Người hủy đơn");
    hdnv.setNgayDamNhan(new java.sql.Date(new java.util.Date().getTime()));
    hdnv.setNhanVien((NhanVien) session.getAttribute("nhanVien"));

    boolean ok2 = hdnvDAO.them(hdnv, idHD);

    if (ok1 && ok2) {
        session.setAttribute("msg", "Thành công!");
    } else {
        session.setAttribute("msg", "Thất bại!");
    }

    response.sendRedirect("gdDuyetDonHang.jsp");
%>
