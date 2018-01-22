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
	
	public boolean add(java.util.Date d, String user, String pc) throws Exception {
		
	}
	
	public ArrayList<String> get_user() {
		 ArrayList<String> re =  new ArrayList<String>();
		 
		 
		 return re;
	}
	
	
	public List<String> get_pc() {
		 ArrayList<String> re =  new ArrayList<String>();
		 
		 
		 return re;
	}
	
	public void close() throws Exception{
		this.con.close();
	}
	
}
