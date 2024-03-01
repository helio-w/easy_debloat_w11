# Author Alexandre Guillot
# 28-02-2024 v1

# This PS script aim to unbloat and install open-source software/alternatives on a Windows 11 clean install fully updated.
# Tested on W11 French install
# Feel free to customize collections

# Please unblock this file and autorize script execution before running this script
# Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Parameters
param (
    [switch]$c, #If enabled, clean bloatwares
    [string]$i # If enabled, take collections name and install it
)

# UTF-8 encoding
chcp 65001

# Install function
function installList {
    param(
        [array]$list
    )


    foreach ($app in $list) {
        winget install $app
    }
}

# Liste des noms d'applications à désinstaller
$toRemove = @(
    "Clipchamp.Clipchamp_yxz26nhyzhsrt",
    "Microsoft.549981C3F5F10_8wekyb3d8bbwe", # Cortana
    "Microsoft.BingNews_8wekyb3d8bbwe",
    "Microsoft.BingWeather_8wekyb3d8bbwe",
    "Microsoft.GetHelp_8wekyb3d8bbwe",
    "Microsoft.Getstarted_8wekyb3d8bbwe",
    "Microsoft.MicrosoftOfficeHub_8wekyb3d8bbwe",
    "Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe",
    "Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe",
    "Microsoft.OutlookForWindows_8wekyb3d8bbwe",
    "Microsoft.Paint_8wekyb3d8bbwe",
    "Microsoft.People_8wekyb3d8bbwe",
    "Microsoft.PowerAutomateDesktop_8wekyb3d8bbwe",
    "Microsoft.DevHome", # PowerAutomate
    "Microsoft.Windows.Photos_8wekyb3d8bbwe",
    "Microsoft.WindowsAlarms_8wekyb3d8bbwe",
    "Microsoft.WindowsCamera_8wekyb3d8bbwe",
    "Microsoft.WindowsFeedbackHub_8wekyb3d8bbwe",
    "Microsoft.WindowsMaps_8wekyb3d8bbwe",
    "Microsoft.YourPhone_8wekyb3d8bbwe",
    "Microsoft.ZuneMusic_8wekyb3d8bbwe",
    "Microsoft.ZuneVideo_8wekyb3d8bbwe",
    "Microsoft.OneDrive",
    "microsoft.windowscommunicationsapps_8wekyb3d8bbwe",
    "Microsoft.WindowsSoundRecorder_8wekyb3d8bbwe",
    "Microsoft.Todos_8wekyb3d8bbwe",
    "SpotifyAB.SpotifyMusic_zpdnekdrzrea0",
    "MicrosoftCorporationII.QuickAssist_8wekyb3d8bbwe"
)

# Liste des noms d'applications à installer
$baseInstall = @(
    "mozilla.firefox",
    "mozilla.thunderbird",
    "discord.discord",
    "spotify.spotify",
    "IrfanSkiljan.IrfanView",   # Image Viewer
    "9MVZQVXJBQ9V",             # AV1 Extensions
    "Notepad++.Notepad++",      # Better Notepad
	"TheDocumentFoundation.LibreOffice"
    # "KDE.Okular"                # PDF Viewer / Seems to be broken
    
)

$devInstall = @(
    "Microsoft.VisualStudioCode",
    "Git.Git",
    "BellSoft.LibericaJDK.21.Full",
    "dbeaver.dbeaver",
    "Oracle.VirtualBox",
    "JetBrains.IntelliJIDEA.Ultimate",
    "JetBrains.PHPStorm"
)

$gameInstall = @(
    "valve.steam",
    "HeroicGamesLauncher.HeroicGamesLauncher"
)

$installLists = @{}
$installLists["base"] = $baseInstall
$installLists["dev"] = $devInstall
$installLists["game"] = $gameInstall

# Parcours de la liste et désinstallation des applications
if($c){
    foreach ($app in $toRemove) {
        # Vérifie si l'application est déjà installée
        winget uninstall $app
    }
}

if($i){
    winget source update
    $installArgs = $i -Split(' ')
    foreach($arg in $installArgs){
        if($installLists.ContainsKey($arg)){
            installList -list $installLists[$arg]
        }
    }
}

Write-Host "Finished"
