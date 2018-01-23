package com.seaflying.LoginQuery;

import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import com.seaflying.LoginQuery.*;

public class Main {	
	
	
	public static void main(String[] args) throws Exception{
		Powershell ps = new Powershell();
		Dao mysql = new Dao("jdbc:mysql://127.0.0.1/loginquery", "root", "sfroot94");
		Map<Integer, Integer> up_map = mysql.get_uer_pc_map(); 
		for (Map.Entry<Integer, Integer> entry : up_map.entrySet()) { 
			int user_id = entry.getKey();
			int pc_id = entry.getValue();
			Date time_s1[] = ps.getTime(user_id ,pc_id , 1);
			int len = time_s1.length;
			for (int i = 0; i < len; i++) {
				mysql.add("status_1", time_s1[i], user_id, pc_id);
			}
		}
		
		
	}

	
	




}
