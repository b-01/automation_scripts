# remove all files from current dir
Remove-Item ".\*" -Recurse -Exclude "*.ps1"
#
# powershell uses Tls1.0 -> github does not allow this
$AllProtocols = [System.Net.SecurityProtocolType]'Tls11,Tls12'
[System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols
#
#
$response = Invoke-RestMethod -Uri "https://api.github.com/repos/gchq/CyberChef/releases/latest"
$zip_file = "https://github.com/gchq/CyberChef/releases/download/" +$response.tag_name +"/CyberChef_" +$response.tag_name +".zip"
$fname = "CyberChef_" +$response.tag_name +".html"
#
# faster download by removing the progress bar
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $zip_file -OutFile "CyberChef.zip"
#
#
Expand-Archive "CyberChef.zip" -DestinationPath "output"
Copy-Item ".\output\*" -Recurse -Destination "."
Move-Item $fname -Destination "cyberchef.htm"
#
# cleanup
Remove-Item ".\output" -Recurse
Remove-Item "CyberChef.zip"
