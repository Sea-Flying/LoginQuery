package com.seaflying.LoginQuery;

import java.util.ArrayList;

import com.seaflying.LoginQuery.*;

public class Main {
	
	public static void main(String[] args) throws Exception{
		Powershell ps = new Powershell();
		Dao mysql = new Dao("jdbc:mysql://127.0.0.1/login", "root", "sfroot94");
		ArrayList<String> users = mysql.get_user();
		ArrayList<String> pc = mysql.get_pc();
		
	}

}
