package dao;

import model.NhanVien;
import model.ThanhVien;
import java.sql.*;

public class NhanVienDAO extends DAO {

    public NhanVien getNhanVien(ThanhVien tv) {
        String sql = "SELECT n.tblThanhVienid, n.chucVu, t.ten " +
                     "FROM tblNhanVien n JOIN tblThanhVien t ON n.tblThanhVienid = t.id " +
                     "WHERE t.id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, tv.getId());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                NhanVien nv = new NhanVien();
                nv.setId(rs.getInt("tblThanhVienid"));
                nv.setTen(rs.getString("ten"));
                nv.setChucVu(rs.getString("chucVu"));
                return nv;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
