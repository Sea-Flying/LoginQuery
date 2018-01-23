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
	
	public boolean add(String table, java.util.Date d, int user_id, int pc_id) throws Exception {
		Statement stmt = this.con.createStatement();
		String sql = ""
	}
	
	
	public Map<Integer, Integer>  get_uer_pc_map() {
		Map<Integer, Integer> re =  new HashMap<>();
		Statement stmt
		 
		return re;
	}
	
	
	public void close() throws Exception{
		this.con.close();
	}
	
}
