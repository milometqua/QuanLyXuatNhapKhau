package model;

import java.sql.Date;
import java.util.List;

public class HoaDonBan {
	private int id;
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
	public void duyet() {
        this.trangThai = "Đã duyệt";
    }

    public void huy() {
        this.trangThai = "Đã hủy";
    }
    
    public void nhan() {
    	this.trangThai = "Đã nhận";
    }
    
    public float tinhTongTien() {
        float sum = 0;
        if (this.dsCTDonHang != null) {
            for (CTDonHang ct : this.dsCTDonHang) {
                sum += ct.getDonGia() * ct.getSoLuong();
            }
        }
        return sum;
    }

    public int tongMatHang() {
        int sl = 0;
        if (this.dsCTDonHang != null) {
            for (CTDonHang ct : this.dsCTDonHang) {
                sl += ct.getSoLuong();
            }
        }
        return sl;
    }
}
