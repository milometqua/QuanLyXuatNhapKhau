package model;

public class CTDonHang {
	private int id;
	private float donGia;
	private int soLuong;
	private MatHang matHang;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public float getDonGia() {
		return donGia;
	}
	public void setDonGia(float d) {
		this.donGia = d;
	}
	public int getSoLuong() {
		return soLuong;
	}
	public void setSoLuong(int soLuong) {
		this.soLuong = soLuong;
	}
	public MatHang getMatHang() {
		return matHang;
	}
	public void setMatHang(MatHang matHang) {
		this.matHang = matHang;
	}
	
	
}
