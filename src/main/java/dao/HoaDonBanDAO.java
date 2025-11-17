package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.CTDonHang;
import model.HoaDonBan;
import model.HoaDonNhanVien;
import model.KhachHang;
import model.MatHang;

public class HoaDonBanDAO extends DAO{
	public List<HoaDonBan> getHoaDon(String trangThai) {
        List<HoaDonBan> ds = new ArrayList<>();

        String sql = """
            SELECT h.id, h.trangThai, h.ngayDatHang,
                   k.tblThanhVienid AS khId, tv.ten AS tenKH
            FROM tblHoaDonBan h
            JOIN tblKhachHang k ON h.khachHangId = k.tblThanhVienid
            JOIN tblThanhVien tv ON tv.id = k.tblThanhVienid
            WHERE h.trangThai = ?
        """;

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, trangThai);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                HoaDonBan hd = new HoaDonBan();

                hd.setId(rs.getInt("id"));
                hd.setTrangThai(rs.getString("trangThai"));
                hd.setNgayDatHang(rs.getDate("ngayDatHang"));

                KhachHang kh = new KhachHang();
                kh.setId(rs.getInt("khId"));
                kh.setTen(rs.getString("tenKH"));

                hd.setKhachHang(kh);

                ds.add(hd);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ds;
    }
	
	public HoaDonBan getHoaDonTheoID(int id) {
	    HoaDonBan hd = null;

	    String sql = """
	        SELECT h.id, h.trangThai, h.ngayDatHang,
	               k.tblThanhVienid AS khId, k.diaChi AS diaChiKH, 
	               tv.ten AS tenKH, tv.soDienThoai AS sdtKH
	        FROM tblHoaDonBan h
	        JOIN tblKhachHang k ON h.khachHangId = k.tblThanhVienid
	        JOIN tblThanhVien tv ON tv.id = k.tblThanhVienid
	        WHERE h.id = ?
	    """;

	    try (PreparedStatement ps = con.prepareStatement(sql)) {
	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            hd = new HoaDonBan();
	            hd.setId(rs.getInt("id"));
	            hd.setTrangThai(rs.getString("trangThai"));
	            hd.setNgayDatHang(rs.getDate("ngayDatHang"));

	            KhachHang kh = new KhachHang();
	            kh.setId(rs.getInt("khId"));
	            kh.setTen(rs.getString("tenKH"));
	            kh.setSoDienThoai(rs.getString("sdtKH"));
	            kh.setDiaChi(rs.getString("diaChiKH"));
	            hd.setKhachHang(kh);

	            // *** LOAD DANH SÁCH CHI TIẾT ***
	            hd.setDsCTDonHang(getCTDonHangByHD(id));
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return hd;
	}

	public boolean capNhatTrangThai(HoaDonBan hd) throws Exception {
	    String sql = "UPDATE tblHoaDonBan SET trangThai=? WHERE id=?";
	    try (PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, hd.getTrangThai());
	        ps.setInt(2, hd.getId());

	        return ps.executeUpdate() > 0;

	    } catch (Exception e) {
	        System.err.println("Lỗi cập nhật trạng thái hóa đơn: " + e.getMessage());
	        throw e;
	    }
	}

	
	public int getSoLuongMatHang(int hoaDonId) {
	    String sql = "SELECT SUM(soLuong) AS sl FROM tblCTDonHang WHERE tblHoaDonBanid = ?";
	    try (PreparedStatement ps = con.prepareStatement(sql)) {
	        ps.setInt(1, hoaDonId);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) return rs.getInt("sl");
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return 0;
	}
	
	public boolean them(HoaDonNhanVien hdnv, int hoaDonBanId) throws Exception {
	    String sql = "INSERT INTO tblHoaDonNhanVien(vaiTro, ngayDamNhan, nhanVienId, HoaDonBanId) "
	               + "VALUES (?, ?, ?, ?)";

	    try (PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, hdnv.getVaiTro());
	        ps.setDate(2, new java.sql.Date(hdnv.getNgayDamNhan().getTime()));
	        ps.setInt(3, hdnv.getNhanVien().getId());
	        ps.setInt(4, hoaDonBanId);

	        return ps.executeUpdate() > 0;

	    } catch (Exception e) {
	        System.err.println("Lỗi thêm HoaDonNhanVien: " + e.getMessage());
	        throw e;
	    }
	}



	public double getTongTien(int hoaDonId) {
	    String sql = "SELECT SUM(donGia * soLuong) AS tong FROM tblCTDonHang WHERE tblHoaDonBanid = ?";
	    try (PreparedStatement ps = con.prepareStatement(sql)) {
	        ps.setInt(1, hoaDonId);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) return rs.getDouble("tong");
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return 0;
	}
	
	public List<CTDonHang> getCTDonHangByHD(int hoaDonId) {
	    List<CTDonHang> ds = new ArrayList<>();

	    String sql = """
	        SELECT c.id, c.soLuong, c.donGia,
	               m.id AS mhId, m.ten AS tenMH
	        FROM tblCTDonHang c
	        JOIN tblMatHang m ON c.tblMatHangid = m.id
	        WHERE c.tblHoaDonBanid = ?
	    """;

	    try (PreparedStatement ps = con.prepareStatement(sql)) {
	        ps.setInt(1, hoaDonId);
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            CTDonHang ct = new CTDonHang();
	            ct.setId(rs.getInt("id"));
	            ct.setSoLuong(rs.getInt("soLuong"));
	            ct.setDonGia(rs.getFloat("donGia"));

	            MatHang mh = new MatHang();
	            mh.setId(rs.getInt("mhId"));
	            mh.setTen(rs.getString("tenMH"));
	            ct.setMatHang(mh);

	            ds.add(ct);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return ds;
	}


}
