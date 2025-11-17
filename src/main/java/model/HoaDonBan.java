package model;

import java.sql.Date;
import java.util.List;

public class HoaDonBan {
	private int id;
	private float tongTien;
	private int tongSoLuong;
	private String trangThai;
	private Date ngayDatHang;
	private KhachHang khachHang;
	private List<HoaDonNhanVien> dsHoaDonNhanVien;
	private List<CTDonHang> dsCTDonHang;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public float getTongTien() {
		return tongTien;
	}
	public void setTongTien(float tongTien) {
		this.tongTien = tongTien;
	}
	public int getTongSoLuong() {
		return tongSoLuong;
	}
	public void setTongSoLuong(int tongSoLuong) {
		this.tongSoLuong = tongSoLuong;
	}
	public String getTrangThai() {
		return trangThai;
	}
	public void setTrangThai(String trangThai) {
		this.trangThai = trangThai;
	}
	public Date getNgayDatHang() {
		return ngayDatHang;
	}
	public void setNgayDatHang(Date ngayDatHang) {
		this.ngayDatHang = ngayDatHang;
	}
	public KhachHang getKhachHang() {
		return khachHang;
	}
	public void setKhachHang(KhachHang khachHang) {
		this.khachHang = khachHang;
	}
	public List<HoaDonNhanVien> getDsHoaDonNhanVien() {
		return dsHoaDonNhanVien;
	}
	public void setDsHoaDonNhanVien(List<HoaDonNhanVien> dsHoaDonNhanVien) {
		this.dsHoaDonNhanVien = dsHoaDonNhanVien;
	}
	public List<CTDonHang> getDsCTDonHang() {
		return dsCTDonHang;
	}
	public void setDsCTDonHang(List<CTDonHang> dsCTDonHang) {
		this.dsCTDonHang = dsCTDonHang;
	}
	
}
