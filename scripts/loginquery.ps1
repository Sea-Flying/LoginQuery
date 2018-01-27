#[System.Threading.Thread]::CurrentThread.CurrentCulture = "en-US"

Function s1_i ($user,$pc){
$re = Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -FilterXPath "*[System[(EventID=21 or EventID=25)]] and *[UserData/EventXML/User='$user']" -ComputerName $pc
if(!$re){
0
}
else{
$re.length
}
$re | ForEach-Object{ $_.TimeCreated | Get-Date -Format "yyyy-MM-dd HH:mm:ss" }
}

Function s2_i ($user,$pc){
$query = Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -FilterXPath "*[System/EventID=24] and *[UserData/EventXML/User='$user']" -ComputerName $pc
$num = 0 
$re=,"begin"
$query | ForEach-Object {
    $this_rid = $_.RecordId
    $p_rid = $this_rid - 1    
    $p_id = (Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -FilterXPath "*[System/EventRecordID=$p_rid]" -ComputerName $pc).Id
    if ($p_id -ne 23){
        $num++
        $t_1 = Get-Date -Date $_.TimeCreated -Format "yyyy-MM-dd HH:mm:ss"
        $re += $t_1
    } 
}
if(!$query){
    $num = 0
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

Function s3_i ($user,$pc){
$query = Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -FilterXPath "*[System/EventID=24] and *[UserData/EventXML/User='$user']" -ComputerName $pc
$num = 0 
$re=,"begin"
$query | ForEach-Object {
    $this_rid = $_.RecordId
    $p_rid = $this_rid - 1
    $p_event = Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -FilterXPath "*[System/EventRecordID=$p_rid]" -ComputerName $pc
    $p_id = $p_event.Id
    $p_event_xml = [xml]$p_event.ToXml()
    $p_user = $p_event_xml.Event.UserData.EventXML.User
    if (($p_id -eq 23) -and ($p_user -eq $user)){
        $num++
        $t_1 = Get-Date -Date $_.TimeCreated -Format "yyyy-MM-dd HH:mm:ss"
        $re += $t_1
    } 
}
if(!$query){
    $num = 0
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

Function s1 ($user,$pc,$t_diff){
$re = Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -FilterXPath "*[System[(EventID=21 or EventID=25)]] and *[UserData/EventXML/User='$user'] and *[System[TimeCreated[timediff(@SystemTime)<=$t_diff]]]" -ComputerName $pc
if(!$re){
0
}
else{
$re.length
}
$re | ForEach-Object{ $_.TimeCreated | Get-Date -Format "yyyy-MM-dd HH:mm:ss" }
}

Function s2 ($user,$pc,$t_diff){
$query = Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -FilterXPath "*[System/EventID=24] and *[UserData/EventXML/User='$user'] and *[System[TimeCreated[timediff(@SystemTime)<=$t_diff]]]" -ComputerName $pc
$num = 0 
$re=,"begin"
$query | ForEach-Object {
    $this_rid = $_.RecordId
    $p_rid = $this_rid - 1    
    $p_id = (Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -FilterXPath "*[System/EventRecordID=$p_rid]" -ComputerName $pc).Id
    if ($p_id -ne 23){
        $num++
        $t_1 = Get-Date -Date $_.TimeCreated -Format "yyyy-MM-dd HH:mm:ss"
        $re += $t_1
    } 
}
if(!$query){
    $num = 0
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

Function s3 ($user,$pc,$t_diff){
$query = Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -FilterXPath "*[System/EventID=24] and *[UserData/EventXML/User='$user'] and *[System[TimeCreated[timediff(@SystemTime)<=$t_diff]]]" -ComputerName $pc
$num = 0 
$re=,"begin"
$query | ForEach-Object {
    $this_rid = $_.RecordId
    $p_rid = $this_rid - 1
    $p_event = Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" -FilterXPath "*[System/EventRecordID=$p_rid]" -ComputerName $pc
    $p_id = $p_event.Id
    $p_event_xml = [xml]$p_event.ToXml()
    $p_user = $p_event_xml.Event.UserData.EventXML.User
    if (($p_id -eq 23) -and ($p_user -eq $user)){
        $num++
        $t_1 = Get-Date -Date $_.TimeCreated -Format "yyyy-MM-dd HH:mm:ss"
        $re += $t_1
    } 
}
if(!$query){
    $num = 0
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

$ErrorActionPreference= 'silentlycontinue'
if($args.Length -eq 4){
    switch($($args[3])){
        {$_ -eq  1} {s1 $($args[0]) $($args[1]) $($args[2])}
        {$_ -eq  2} {s2 $($args[0]) $($args[1]) $($args[2])}
        {$_ -eq  3} {s3 $($args[0]) $($args[1]) $($args[2])}
    }
}
elseif($args.Length -eq 3){
    switch($($args[2])){
        {$_ -eq  1} {s1_i $($args[0]) $($args[1])}
        {$_ -eq  2} {s2_i $($args[0]) $($args[1])}
        {$_ -eq  3} {s3_i $($args[0]) $($args[1])}
    }
}

