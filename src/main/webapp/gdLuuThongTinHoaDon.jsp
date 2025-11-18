<%@ page import="dao.HoaDonBanDAO" %>
<%@ page import="model.HoaDonBan" %>

<%
    int id = Integer.parseInt(request.getParameter("idHD"));

    HoaDonBanDAO dao = new HoaDonBanDAO();
    HoaDonBan hd = dao.getHoaDonTheoID(id);

    session.setAttribute("hoaDonDangChon", hd);

    response.sendRedirect("gdChiTietDonHang.jsp");
%>
