package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO {
    public static Connection con;

    public DAO() {
        if (con == null) {
            String dbUrl = "jdbc:mysql://localhost:3306/quanlybanhang?useSSL=false&serverTimezone=UTC";

            try {
                // Load driver MySQL 8
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Kết nối
                con = DriverManager.getConnection(dbUrl, "root", "050104");
                System.out.println(">>> KẾT NỐI DATABASE THÀNH CÔNG");
            } catch (Exception e) {
                System.out.println(">>> LỖI KẾT NỐI DB");
                e.printStackTrace();
            }
        }
    }
}
