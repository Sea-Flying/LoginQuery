package com.seaflying.LoginQuery;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import com.seaflying.LoginQuery.LoginResultPO;

public class Main {	
	
	
	public static void main(String[] args) throws Exception{
		Powershell ps = new Powershell();
		Dao mysql = new Dao("jdbc:mysql://10.141.222.158:3306/manageplatform", "root", "123456");
		List<IntPairPO> up_map = mysql.get_uer_pc_map();
		long c_time = (new Date()).getTime();
		long p_time = mysql.get_last_time();
		long t_diff = (p_time == 0) ? -77 : c_time-p_time ;	
		mysql.set_last_time(new Date());
		for (IntPairPO entry : up_map) {
			int user_id = entry.getA();
			int pc_id = entry.getB();
			String user = mysql.get_user(user_id);
			String pc = mysql.get_pc(pc_id);
			String domain = "";
			System.out.println("user :"+user+" pc:"+pc+" begin");
			List<LoginResultPO> time_s1 = ps.getLoginResult(domain+user ,pc, 1, t_diff);
			System.out.println("status 1 query completed, total:"+time_s1.size());
			List<LoginResultPO> time_s2 = ps.getLoginResult(domain+user, pc, 2, t_diff);
			System.out.println("status 2 query completed, total:"+time_s2.size());
			List<LoginResultPO> time_s3 = ps.getLoginResult(domain+user, pc, 3, t_diff);
			System.out.println("status 3 query completed total:"+time_s3.size());
			Iterator<LoginResultPO> it_1 = time_s1.iterator();
			Iterator<LoginResultPO> it_2 = time_s2.iterator();
			Iterator<LoginResultPO> it_3 = time_s3.iterator();
			while(it_1.hasNext()){
				LoginResultPO tmp = it_1.next();
				mysql.add("monitor_status_1",tmp.getTimestamp(), user_id, pc_id, tmp.getIpAddress());
			}
			while(it_2.hasNext()){
				LoginResultPO tmp = it_2.next();
				mysql.add("monitor_status_2",tmp.getTimestamp(), user_id, pc_id, tmp.getIpAddress());
			}
			while(it_3.hasNext()){
				LoginResultPO tmp = it_3.next();
				mysql.add("monitor_status_3",tmp.getTimestamp(), user_id, pc_id, tmp.getIpAddress());
			}
			System.out.println("user :"+user+" pc:"+pc+" end");
			System.out.println();
		} 
		mysql.close();
	}

	
}
