package com.seaflying.LoginQuery;

import java.io.*;
import java.text.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.seaflying.LoginQuery.LoginResultPO;

public class Powershell {

	
	private Process ps;
	
	public List<LoginResultPO> getLoginResult(String user, String pc, int status, long t_diff) {
		List<LoginResultPO> re = new ArrayList<>();
		DateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String script = "D:\\Develop\\project\\LoginQuery\\scripts\\loginquery_with_ipaddr.ps1";
		String cmd ="";
		if(t_diff == -77) {			
			cmd = "powershell "+ script +" "+user+" "+pc+" "+status;
		}
		else if (t_diff > 0) {
			cmd = "powershell "+ script +" "+user+" "+pc+" "+t_diff+" "+status;
		}
		try {
			this.ps = Runtime.getRuntime().exec(cmd);
			ps.getOutputStream().close();
			ps.getErrorStream().close();
			BufferedReader reader = new BufferedReader(new InputStreamReader(ps.getInputStream(), "GBK"));
			String str = reader.readLine();
			int num = Integer.parseInt(str);
			for (int i = 0; i < num; i++) {
				LoginResultPO tmp = new LoginResultPO();
				Date time = sdf.parse(reader.readLine());
				String ip = reader.readLine();
				tmp.setTimestamp(time);
				tmp.setIpAddress(ip);
				re.add(tmp);
			}
			reader.close();
		}catch (Exception e){
			e.printStackTrace();
			System.err.println("Execute Loginquery PowerShell scripts or retrieve info Failed!");
		}
		ps.destroy();
		return re;
	}

	
}
