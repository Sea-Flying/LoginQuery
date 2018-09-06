package com.seaflying.LoginQuery;

import java.sql.*;
import java.util.*;
import java.util.Date;
import java.io.*;

public class Dao {

	private Connection con;
	private String url, user, pwd;
		
	public Dao(String p_url, String p_user, String p_pwd) {
		this.url = p_url;
		this.user = p_user;
		this.pwd = p_pwd;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			this.con = DriverManager.getConnection(url, user, pwd);
		}catch (Exception e){
			e.printStackTrace();
			System.err.println("Mysql JDBC Connection Error!");
		}
	}
	
	public void add(String table, java.util.Date d, int user_id, int pc_id, String ip) {
		try {
			PreparedStatement preStmt =this.con.prepareStatement("Insert into "+table+" "+ "(time,user_id,pc_id,ip_address) values (?,?,?,?)");
			preStmt.setTimestamp(1, new Timestamp(d.getTime()));
			preStmt.setInt(2, user_id);
			preStmt.setInt(3, pc_id);
			preStmt.setString(4,ip);
			preStmt.executeUpdate();
			preStmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println("Insert record into table "+table+" Failed!");
		}
	}
		
	public Map<Integer, Integer>  get_uer_pc_map()  {
		Map<Integer, Integer> re =  new HashMap<>();
		try {
			Statement stmt = this.con.createStatement();
			String sql = "select * from monitor_map_user_pc";
			ResultSet resultSet = stmt.executeQuery(sql);
			while (resultSet.next()) {
				re.put(resultSet.getInt("user_id"), resultSet.getInt("pc_id"));
			}
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println("Select info from table map_user_pc Failed!");
		}
		return re;
	}
	
	public String get_user(int id) {
		String re = null;
		try {
			Statement stmt = this.con.createStatement();
			String sql = "select name from monitor_users where id="+id;
			ResultSet resultSet = stmt.executeQuery(sql);
			resultSet.next();
			re = resultSet.getString("name");
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println("Select info from table users Failed");
		}
		return re;
	}
	
	public String get_pc(int id) {
		String re = null;
		try {
			Statement stmt = this.con.createStatement();
			String sql = "select name from monitor_pcs where id="+id;
			ResultSet resultSet = stmt.executeQuery(sql);
			resultSet.next();
			re = resultSet.getString("name");
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println("Select info from pcs Failed!");
		}
		return re;
	}
	
	public long get_last_time()  {
		Long re = null;
		try {
			Statement stmt = this.con.createStatement();
			String sql = "select time from monitor_last_login_query_time";
			ResultSet resultSet = stmt.executeQuery(sql);
			resultSet.next();
			re = resultSet.getTimestamp("time").getTime();
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println("Select from last_query_time Failed!");
		}
		return re;
	}
	
	public void set_last_time(java.util.Date d) {
		try {
			PreparedStatement preStmt = this.con.prepareStatement("update monitor_last_login_query_time set time=?") ;
			preStmt.setTimestamp(1,new Timestamp(d.getTime()));
			preStmt.executeUpdate();
			preStmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println("Update table last_query_time Failed");
		}
	}
	
	
	public void close() {
		try {
			this.con.close();
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println("JDBC close connection Failed!");
		}
	}
	
}
