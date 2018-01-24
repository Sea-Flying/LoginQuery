package com.seaflying.LoginQuery;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
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
			List<Date> time_s1 = ps.getTime(user_id ,pc_id, 1);
			List<Date> time_s2 = ps.getTime(user_id, pc_id, 2);
			List<Date> time_s3 = ps.getTime(user_id, pc_id, 3);
			Iterator<Date> it_1 = time_s1.iterator();
			Iterator<Date> it_2 = time_s2.iterator();
			Iterator<Date> it_3 = time_s3.iterator();
			while(it_1.hasNext()){
				mysql.add("status_1",it_1.next(), user_id, pc_id);
			}
			while(it_2.hasNext()){
				mysql.add("status_2",it_2.next(), user_id, pc_id);
			}
			while(it_3.hasNext()){
				mysql.add("status_3",it_3.next(), user_id, pc_id);
			}			
		}
	}



}
