package dao;

import java.sql.PreparedStatement;

import model.HoaDonBan;
import model.HoaDonNhanVien;

public class HoaDonNhanVienDAO extends DAO{
	public boolean them(HoaDonNhanVien hdnv, HoaDonBan hd) throws Exception {
	    try {
	        String sql =
	          "INSERT INTO tblHoaDonNhanVien(vaiTro, ngayDamNhan, nhanVienId, HoaDonBanId) VALUES (?, ?, ?, ?)";
	        PreparedStatement ps = con.prepareStatement(sql);

	        ps.setString(1, hdnv.getVaiTro());
	        ps.setDate(2, hdnv.getNgayDamNhan());
	        ps.setInt(3, hdnv.getNhanVien().getId());
	        ps.setInt(4, hd.getId()); 

	        return ps.executeUpdate() > 0;

	    } catch (Exception e) {
	        throw new Exception("Lỗi thêm lịch sử xử lý hóa đơn: " + e.getMessage());
	    }
	}

}
