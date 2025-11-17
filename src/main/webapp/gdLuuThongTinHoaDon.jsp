<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String idHD = request.getParameter("idHD");

    if (idHD != null) {
        session.setAttribute("idHoaDon", Integer.parseInt(idHD));
        response.sendRedirect("gdChiTietDonHang.jsp");
    } else {
        out.println("Không nhận được ID hóa đơn");
    }
%>
