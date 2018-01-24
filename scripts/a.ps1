#[System.Threading.Thread]::CurrentThread.CurrentCulture = "en-US"
Function s1 ($user,$pc){
$re = (Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -FilterXPath "*[System[(EventID=21 or EventID=25)]] and *[UserData/EventXML/User='$pc\$user']").TimeCreated | Get-Date -Format "yyyy/MM/dd HH:mm:ss"
$re.length
$re
}

Function s2 ($user,$pc){
$query = (Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -FilterXPath "*[System/EventID=24] and *[UserData/EventXML/User='$pc\$user']")
$len = $query.length
$num = 0 
$re=,"begin"
$query | ForEach-Object {
    $this_rid = $_.RecordId
    $p_rid = $this_rid - 1
    $p_id = (Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -FilterXPath "*[System/EventRecordID=$p_rid] and *[UserData/EventXML/User='$pc\$user']").Id
    if ($p_id -ne 23){
        $num++
        $t_1 = Get-Date -Date $_.TimeCreated -Format "yyyy/MM/dd HH:mm:ss"
        $re += $t_1
    } 
}
$num
$re
}

Function s3 ($user,$pc){
$query = (Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -FilterXPath "*[System/EventID=24] and *[UserData/EventXML/User='$pc\$user']")
$len = $query.length
$num = 0 
$re=,"begin"
$query | ForEach-Object {
    $this_rid = $_.RecordId
    $p_rid = $this_rid - 1
    $p_id = (Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -FilterXPath "*[System/EventRecordID=$p_rid] and *[UserData/EventXML/User='$pc\$user']").Id
    if ($p_id -eq 23){
        $num++
        $t_1 = Get-Date -Date $_.TimeCreated -Format "yyyy/MM/dd HH:mm:ss"
        $re += $t_1
    } 
}
$num
$re
}


s2 $($args[0]) $($args[1])


