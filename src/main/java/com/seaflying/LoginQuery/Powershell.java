package com.seaflying.LoginQuery;

import java.io.*;
import java.text.*;  
import java.util.Date;

public class Powershell {
	
	private Process ps;
	
	public Date[] getTime(int user_id, int pc_id, int status) throws Exception {
		this.ps = Runtime.getRuntime().exec(cmd);
		BufferedReader re = new BufferedReader(new InputStreamReader(ps.getInputStream(),"GBK"));
		
		String line = re.readLine();
		re.close();
		
		ps.waitFor();
		ps.destroy();
		DateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = sdf.parse(line);
		return date;
	}
	
}
