package com.seaflying.LoginQuery;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.seaflying.LoginQuery.*;

public class Main {	
	
	
	public static void main(String[] args) throws Exception{
		Powershell ps = new Powershell();
		Dao mysql = new Dao("jdbc:mysql://127.0.0.1/tmp", "root", "root");
		Map<Integer, Integer> up_map = mysql.get_uer_pc_map();
		long c_time = (new Date()).getTime();
		long p_time = mysql.get_last_time();
		long t_diff = (p_time == 0) ? -77 : c_time-p_time ;	
		mysql.set_last_time(new Date());
		for (Map.Entry<Integer, Integer> entry : up_map.entrySet()) { 
			int user_id = entry.getKey();
			int pc_id = entry.getValue();
			String user = mysql.get_user(user_id);
			String pc = mysql.get_pc(pc_id);
			List<Date> time_s1 = ps.getTime(user ,pc, 1, t_diff);
			List<Date> time_s2 = ps.getTime(user, pc, 2, t_diff);
			List<Date> time_s3 = ps.getTime(user, pc, 3, t_diff);
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
		mysql.close();
	}

	
}
