package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.CTDonHang;
import model.HoaDonBan;
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
