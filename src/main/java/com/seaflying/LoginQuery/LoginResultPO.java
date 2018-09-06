package com.seaflying.LoginQuery;

import java.util.Date;

public class LoginResultPO {
    private Date timestamp;
    private String ipAddress;

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }
}
