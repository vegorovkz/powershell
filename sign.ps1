$UserName = $env:username
$Filter = "(&(objectCategory=User)(samAccountName=$UserName))"
$Searcher = New-Object System.DirectoryServices.DirectorySearcher
$Searcher.Filter = $Filter
$ADUserPath = $Searcher.FindOne()
$ADUser = $ADUserPath.GetDirectoryEntry()
$ADDisplayName = $ADUser.DisplayName
$ADEmailAddress = $ADUser.mail
$ADTitle = $ADUser.title
$ADTelePhoneNumber = $ADUser.TelephoneNumber
$ADMobilePhoneNumber = $ADUser.mobile
$mobileType = $ADMobilePhoneNumber

$mobTrue = "<font face=`"Times New Roman`" color=`"#800000`"> моб. $ADMobilePhoneNumber</font><br>"
$mobFalse = ""

$result = if ($mobileType) {$mobTrue}
          else {$mobFalse}

$signature = "$env:appdata\Thunderbird\Profiles\signature.htm"

 $html = '
      <body text="#000000" bgcolor="#FFFFFF">
        <font face="Times New Roman" color="#800000">"Static Text"</font><br>
        <font face="Times New Roman" color="#800000">'+$ADTitle+'</font><br>
        <font face="Times New Roman" color="#800000">"Static Text"</font><br>
        <font face="Times New Roman" color="#800000">'+$ADDisplayName+'</font><br>
        <font face="Times New Roman" color="#800000">tel. +7 (7252) 55 55 55 (ex.'+$ADTelePhoneNumber+')</font><br>
        '+$result+'
        <font face="Times New Roman" color="#800000">email: '+$ADEmailAddress+'</font><br>
        <font face="Times New Roman" color="#800000">web: website.com</font><br><br>
      </body>'


Write-Output $html | out-file $signature -encoding UTF8


