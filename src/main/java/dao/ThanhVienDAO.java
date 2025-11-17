package dao;

import model.ThanhVien;
import java.sql.*;

public class ThanhVienDAO extends DAO {

    public ThanhVien checkLogin(ThanhVien tv) {
        String sql = "SELECT * FROM tblThanhVien WHERE tenDangNhap = ? AND matKhau = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, tv.getTenDangNhap());
            ps.setString(2, tv.getMatKhau());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ThanhVien result = new ThanhVien();
                result.setId(rs.getInt("id"));
                result.setTenDangNhap(rs.getString("tenDangNhap"));
                result.setTen(rs.getString("ten"));
                result.setVaiTro(rs.getString("vaiTro"));
                return result;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
