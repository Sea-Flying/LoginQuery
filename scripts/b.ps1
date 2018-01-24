#[System.Threading.Thread]::CurrentThread.CurrentCulture = "en-US"

Function s1 ($user,$pc){
$re = Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -FilterXPath "*[System[(EventID=21 or EventID=25)]] and *[UserData/EventXML/User='$user']" -ComputerName $pc
$re.length
$re | ForEach-Object{ $_.TimeCreated | Get-Date -Format "yyyy-MM-dd HH:mm:ss" }
}

Function s2 ($user,$pc){
$query = Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -FilterXPath "*[System/EventID=24] and *[UserData/EventXML/User='$user']" -ComputerName $pc
$len = $query.length
$num = 0 
$re=,"begin"
$query | ForEach-Object {
    $this_rid = $_.RecordId
    $p_rid = $this_rid - 1    
    $p_id = (Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -FilterXPath "*[System/EventRecordID=$p_rid]").Id
    if ($p_id -ne 23){
        $num++
        $t_1 = Get-Date -Date $_.TimeCreated -Format "yyyy-MM-dd HH:mm:ss"
        $re += $t_1
    } 
}
$num
if($num -eq 0){
    $re=$null
    }
else{
    $re=$re[1..$num]
    }
$re
}

Function s3 ($user,$pc){
$query = Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -FilterXPath "*[System/EventID=24] and *[UserData/EventXML/User='$user']" -ComputerName $pc
$len = $query.length
$num = 0 
$re=,"begin"
$query | ForEach-Object {
    $this_rid = $_.RecordId
    $p_rid = $this_rid - 1
    $p_event = Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -FilterXPath "*[System/EventRecordID=$p_rid]"
    $p_id = $p_event.Id
    $p_event_xml = [xml]$p_event.ToXml()
    $p_user = $p_event_xml.Event.UserData.EventXML.User
    if (($p_id -eq 23) -and ($p_user -eq 'songqq-PC\songqq')){
        $num++
        $t_1 = Get-Date -Date $_.TimeCreated -Format "yyyy-MM-dd HH:mm:ss"
        $re += $t_1
    } 
}
$num
if($num -eq 0){
    $re=$null
    }
else{
    $re=$re[1..$num]
    }
$re
}

s1  $($args[0]) $($args[1]) 
s2  $($args[0]) $($args[1]) 
s3  $($args[0]) $($args[1]) 
