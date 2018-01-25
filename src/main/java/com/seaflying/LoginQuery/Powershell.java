package com.seaflying.LoginQuery;

import java.io.*;
import java.text.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Powershell {
	
	private Process ps;
	
	public List<Date> getTime(String user, String pc, int status, long t_diff) throws Exception {
		List<Date> date = new ArrayList<>();
		DateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String script = "D:\\Develop\\project\\LoginQuery\\scripts\\b.ps1";
		String cmd ="";
		if(t_diff == -77) {			
			cmd = "powershell "+ script +" "+"songqq-PC\\songqq"+" "+pc+" "+status;
		}
		else if (t_diff > 0) {
			cmd = "powershell "+ script +" "+"songqq-PC\\songqq"+" "+pc+" "+t_diff+" "+status;
		}
		this.ps = Runtime.getRuntime().exec(cmd);
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
