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
#  Title: Compress-Files                                                                                                                                                    #
#  Description: This PowerShell code compresses files from a source directory and saves them as a ZIP file in a destination directory.                                      #
#___________________________________________________________________________________________________________________________________________________________________________#
#                                             __  __________  _      ______________ __  ________   ___  __________  ____     __                                             #
#                                            / / / / __/ __/ | | /| / /  _/_  __/ // / / ___/ _ | / _ \/ __/ __/ / / / /    / /                                             #
#                                           / /_/ _\ \/ _/   | |/ |/ _/ /  / / / _  / / /__/ __ |/ , _/ _// _// /_/ / /__  /_/                                              #
#                                           \____/___/___/   |__/|__/___/ /_/ /_//_/  \___/_/ |_/_/|_/___/_/  \____/____/ (_)                                               #
#############################################################################################################################################################################

function Compress-Files {
    param(
        [CmdletBinding()]
        [Parameter(Mandatory = $true)]
        [Alias("sp")]
        [string]$sourcePath,
            
        [Parameter(Mandatory = $true)]
        [Alias("dp")]
        [string]$destinationPath,
    
        [Parameter(Mandatory = $false)]
        [Alias("fn")]
        [string]$fileName = "compressed.zip",
    
        [Parameter(Mandatory = $false)]
        [Alias("ibdsp")]
        [bool]$includeBaseDirectorySourcePath = $false,

        [Parameter(Mandatory = $false)]
        [Alias("ibddp")]
        [bool]$includeBaseDirectoryDestinationPath = $false
    )
    

    # Include base user directory
    $userDir = Get-Variable HOME -valueOnly

    if ($includeBaseDirectorySourcePath) {
        $sourcePath = Join-Path $userDir $sourcePath
    }

    if ($includeBaseDirectorySourcePath){
        $destinationPath = Join-Path $userDir $destinationPath
    }
    
    # Check if the source path exists
    if (-not (Test-Path $sourcePath)) {
        Write-Error "Source path '$sourcePath' does not exist."
        return
    }
    
    # Create the destination path if it does not exist
    if (-not (Test-Path $destinationPath)) {
        New-Item -ItemType Directory -Path $destinationPath | Out-Null
    }

    # Remove .zip ending from file name
    if ($fileName.ToLower().Contains(".zip")) { 
        $fileName = $fileName.Replace(".zip", "")
    }
    
    # Compress files from source path to destination path
    $zipFile = Join-Path $destinationPath $fileName
    Compress-Archive -Path $sourcePath -DestinationPath $zipFile -CompressionLevel Optimal -Update
    
    return $zipFile + ".zip"    
}