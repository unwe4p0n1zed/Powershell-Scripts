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
#  Title: Install Office 365                                                                                                                                                #
#  Description: This PowerShell code installs Office 365 on a workstation. RUN POWERSHELL AS ADMIN!                                                                         #
#  Based on: https://github.com/mallockey/Install-Office365Suite - Visit for Documentation                                                                                  #
#  Target: Windows 10, 11                                                                                                                                                   #
#___________________________________________________________________________________________________________________________________________________________________________#
#                                             __  __________  _      ______________ __  ________   ___  __________  ____     __                                             #
#                                            / / / / __/ __/ | | /| / /  _/_  __/ // / / ___/ _ | / _ \/ __/ __/ / / / /    / /                                             #
#                                           / /_/ _\ \/ _/   | |/ |/ _/ /  / / / _  / / /__/ __ |/ , _/ _// _// /_/ / /__  /_/                                              #
#                                           \____/___/___/   |__/|__/___/ /_/ /_//_/  \___/_/ |_/_/|_/___/_/  \____/____/ (_)                                               #
#############################################################################################################################################################################

# Enable execution
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Enable TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# get all the scripts needed 
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/unwe4p0n1zed/Powershell-Scripts/main/Functions/Install-Office/Install-Office.ps1'))
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/unwe4p0n1zed/Powershell-Scripts/main/Functions/Remove-FileOrFolder/Remove-FileOrFolder.ps1'))
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/unwe4p0n1zed/Powershell-Scripts/main/Functions/Check-Powershell-Admin/Check-Powershell-Admin.ps1'))


if (Check-PowerShell-Admin) {
    # start install
    & Install-Office365Suite -DisplayInstall
    # delete script files
    Remove-FileOrFolder -ip "C:\Scripts\Office365Install" -it "Folder" 
} else {
    # powershell is not in administrator mode, exit
    Write-Warning "Insufficient permissions to run this script. Open the PowerShell console as an administrator and run this script again."
    Start-Sleep -S 5
}

EXIT
