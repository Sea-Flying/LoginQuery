package com.seaflying.LoginQuery;

import java.io.*;
import java.text.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Powershell {
	
	private Process ps;
	
	public List<Date> getTime(int user_id, int pc_id, int status) throws Exception {
		List<Date> date = new ArrayList<>();
		DateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String cmd = "";
		this.ps = Runtime.getRuntime().exec(cmd+" "+user_id+" "+pc_id+" "+status);
		BufferedReader re = new BufferedReader(new InputStreamReader(ps.getInputStream(),"GBK"));
		re.readLine();
		String str = null;
	    while((str = re.readLine()) != null){
	    	Date d = sdf.parse(str);
			date.add(d);
	    }
		re.close();
		ps.destroy();
		return date;
	}
	
}
