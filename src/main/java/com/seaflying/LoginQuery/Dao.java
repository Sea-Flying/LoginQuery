package com.seaflying.LoginQuery;

import java.sql.*;
import java.util.*;
import java.util.Date;
import java.io.*;

public class Dao {

	private Connection con;
	private String url, user, pwd;
		
	public Dao(String p_url, String p_user, String p_pwd) throws Exception {
		this.url = p_url;
		this.user = p_user;
		this.pwd = p_pwd;
		Class.forName("com.mysql.jdbc.Driver");
		this.con = DriverManager.getConnection(url, user, pwd);
	}
	
	public void add(String table, java.util.Date d, int user_id, int pc_id) throws Exception {
		PreparedStatement preStmt = this.con.prepareStatement("Insert into "+table+" "+
				"(time,user_id,pc_id) values (?,?,?)");
		preStmt.setTimestamp(1, new java.sql.Timestamp(d.getTime()));
		preStmt.setInt(2, user_id);
		preStmt.setInt(3, pc_id);
		preStmt.executeUpdate();
		preStmt.close();
	}
		
	public Map<Integer, Integer>  get_uer_pc_map() throws Exception {
		Map<Integer, Integer> re =  new HashMap<>();
		Statement stmt = this.con.createStatement();
		String sql = "select * from map_user_pc";
		ResultSet resultSet = stmt.executeQuery(sql);
		while (resultSet.next()) {
			re.put(resultSet.getInt("user_id"), resultSet.getInt("pc_id")); 
		}
		stmt.close();
		return re;
	}
	
	public String get_user(int id) throws Exception{
		Statement stmt = this.con.createStatement();
		String sql = "select name from users where id="+id;
		ResultSet resultSet = stmt.executeQuery(sql);
		resultSet.next();
		String re = resultSet.getString("name");
		stmt.close();
		return re;
	}
	
	public String get_pc(int id) throws Exception{
		Statement stmt = this.con.createStatement();
		String sql = "select name from pcs where id="+id;
		ResultSet resultSet = stmt.executeQuery(sql);
		resultSet.next();
		String re = resultSet.getString("name");
		stmt.close();
		return re;
	}
	
	public long get_last_time() throws Exception {
		Statement stmt = this.con.createStatement();
		String sql = "select time from last_query_time";
		ResultSet resultSet = stmt.executeQuery(sql);
		resultSet.next();
		long re = resultSet.getTimestamp("time").getTime();
		stmt.close();
		return re;
	}
	
	public void set_last_time(java.util.Date d) throws Exception {
		PreparedStatement preStmt = this.con.prepareStatement("update last_query_time set time=?") ;
		preStmt.setTimestamp(1,new java.sql.Timestamp(d.getTime()));
		preStmt.executeUpdate();
		preStmt.close();
	}
	
	
	public void close() throws Exception{
		this.con.close();
	}
	
}
