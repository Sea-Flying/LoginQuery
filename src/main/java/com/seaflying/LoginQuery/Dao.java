package com.seaflying.LoginQuery;

import java.sql.*;
import java.util.*;
import java.util.Date;

import javax.swing.text.DefaultEditorKit.InsertBreakAction;

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
		PreparedStatement preStmt = this.con.prepareStatement("Insert into ? "+
				"(time,user_id,pc_id) values (?,?,?)");
		preStmt.setString(1, table);
		preStmt.setDate(2, new java.sql.Date(d.getTime()));
		preStmt.setInt(3, user_id);
		preStmt.setInt(4, pc_id);
		preStmt.executeQuery();
		preStmt.close();
	}
		
	public Map<Integer, Integer>  get_uer_pc_map() throws Exception {
		Map<Integer, Integer> re =  new HashMap<>();
		Statement stmt = this.con.createStatement();
		String sql = "select * from map_user_pc";
		ResultSet resultSet = stmt.executeQuery(sql);
		while (resultSet.next()) {
			re.put(resultSet.getInt(1), resultSet.getInt(2)); 
		}
		stmt.close();
		return re;
	}
	 	
	public void close() throws Exception{
		this.con.close();
	}
	
}
