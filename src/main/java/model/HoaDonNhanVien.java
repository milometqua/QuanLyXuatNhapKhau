package model;

import java.sql.Date;

public class HoaDonNhanVien {
	private int id;
	private String vaiTro;
	private Date ngayDamNhan;
	private NhanVien nhanVien;
	
	public HoaDonNhanVien() {
		super();
	}

	public HoaDonNhanVien(String vaiTro, Date ngay, NhanVien nv) {
        this.vaiTro = vaiTro;
        this.ngayDamNhan = ngay;
        this.nhanVien = nv;
    }
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getVaiTro() {
		return vaiTro;
	}
	public void setVaiTro(String vaiTro) {
		this.vaiTro = vaiTro;
	}
	public Date getNgayDamNhan() {
		return ngayDamNhan;
	}
	public void setNgayDamNhan(Date ngayDamNhan) {
		this.ngayDamNhan = ngayDamNhan;
	}
	public NhanVien getNhanVien() {
		return nhanVien;
	}
	public void setNhanVien(NhanVien nhanVien) {
		this.nhanVien = nhanVien;
	}
	
	
}
