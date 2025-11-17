package model;

import java.sql.Date;

public class HoaDonNhanVien {
	private int id;
	private String vaiTro;
	private Date ngayDamNhan;
	private NhanVien nhanVien;
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
	public Date getAssignedAt() {
		return ngayDamNhan;
	}
	public void setAssignedAt(Date assignedAt) {
		this.ngayDamNhan = assignedAt;
	}
	public NhanVien getNhanVien() {
		return nhanVien;
	}
	public void setNhanVien(NhanVien nhanVien) {
		this.nhanVien = nhanVien;
	}
	
	
}
