#Latest version, April 7, 2017

Write-Host "*******Decrapifying Windows 10...*******"
Write-Host "***Removing App Packages...***"

#I recommend running this script on a fresh install, though it should work fine anyways.  Should ;)
#This part removes all the apps.  By default, it removes everything except the calculator, photos, sound recorder, and the store.  To remove all apps including the store, comment out this part...


Get-AppxPackage -AllUsers | where-object {$_.name -notlike "*Store*" -and $_.name -notlike "*Calculator*" -and $_.name -notlike "*Windows.Photos*" -and $_.name -notlike "*SoundRecorder*"} | Remove-AppxPackage -erroraction silentlycontinue
Get-AppxPackage -AllUsers | where-object {$_.name -notlike "*Store*" -and $_.name -notlike "*Calculator*" -and $_.name -notlike "*Windows.Photos*" -and $_.name -notlike "*SoundRecorder*"} | Remove-AppxPackage -erroraction silentlycontinue

Get-AppxProvisionedPackage -online | where-object {$_.displayname -notlike "*Store*" -and $_.displayname -notlike "*Calculator*" -and $_.displayname -notlike "*Windows.Photos*" -and $_.displayname -notlike "*SoundRecorder*"} | Remove-AppxProvisionedPackage -online -erroraction silentlycontinue

#... and comment in this one:

#Get-AppxPackage -AllUsers | Remove-AppxPackage -erroraction silentlycontinue
#Get-AppxPackage -AllUsers | Remove-AppxPackage -erroraction silentlycontinue

#Get-AppXProvisionedPackage -Online | Remove-AppxProvisionedPackage -online -erroraction silentlycontinue


#Now apps are removed, below we will disable a bunch of features.  The rabbit hole is deep, this are the ones I thought most important.

Write-Host "***Disabling delivery optimization for local machine...***"

Reg Add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /T REG_DWORD /V "DODownloadMode" /D 0 /F
Reg Add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /V "DownloadMode" /T REG_DWORD /D 0 /F
Reg Add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /V "DODownloadMode" /T REG_DWORD /D 0 /F

Write-Host "***Changing delivery optimization download mode for this user...*** "

Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /T REG_DWORD /V "SystemSettingsDownloadMode" /D 3 /F

#This part disables auto-update and auto-download of Store apps for all users. Set value to 2=always off, 4=always on

Write-Host "***Disabling auto update and download of Windows Store Apps...***"

Reg Add "HKCU\SOFTWARE\Policies\Microsoft\WindowsStore" /T REG_DWORD /V "AutoDownload" /D 2 /F

#Next Section is for Anniversary Edition, comment it in if you are on 1607+, no effect it seems on previous editions

Write-Host "***Disabling Suggested Apps, Feedback, Lockscreen Spotlight, File Explorer ads (WTF??? seriously M$!!!), and unwanted app installs for this user...***"

Reg Add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\" /T REG_DWORD /V "SystemPaneSuggestionsEnabled" /D 0 /F
Reg Add "HKCU\Software\Microsoft\CurrentVersion\ContentDeliveryManager\" /T REG_DWORD /V "SoftLandingEnabled" /D 0 /F
Reg Add "HKCU\Software\Microsoft\CurrentVersion\ContentDeliveryManager\" /T REG_DWORD /V "RotatingLockScreenEnable" /D 0 /F
Reg Add "HKCU\Software\Microsoft\CurrentVersion\ContentDeliveryManager\" /T REG_DWORD /V "PreInstalledAppsEnabled" /D 0 /F
Reg Add "HKCU\Software\Microsoft\CurrentVersion\ContentDeliveryManager\" /T REG_DWORD /V "SilentInstalledAppsEnabled" /D 0 /F
Reg Add "HKCU\Software\Microsoft\CurrentVersion\ContentDeliveryManager\" /T REG_DWORD /V "ContentDeliveryAllowed" /D 0 /F
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\" /T REG_DWORD /V "ShowSyncProviderNotifications" /D 0 /F

#1607+ Features end

Write-Host "***Disabling Cloud-Content for this machine...***"
Reg Add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent\" /T REG_DWORD /V "DisableWindowsConsumerFeatures" /D 1 /F

Write-Host "***Disabling OneDrive for local machine...***"

Reg Add "HKLM\Software\Policies\Microsoft\Windows\OneDrive" /T REG_DWORD /V "DisableFileSyncNGSC" /D 1 /F
Reg Add "HKLM\Software\Policies\Microsoft\Windows\OneDrive" /T REG_DWORD /V "DisableFileSync" /D 1 /F

Write-Host "***Disabling Onedrive startup run for this user...***"

Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /T REG_BINARY /V "OneDrive" /D 0300000021B9DEB396D7D001 /F

Write-Host "***Disabling telemetry for local machine...***"

Reg Add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /T REG_DWORD /V "AllowTelemetry" /D 0 /F
Reg Add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /V "PreventDeviceMetadataFromNetwork" /T REG_DWORD /D 1 /F
Reg Add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /V "DontOfferThroughWUAU" /T REG_DWORD /D 1 /F
Reg Add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /V "CEIPEnable" /T REG_DWORD /D 0 /F
Reg Add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "AITEnable" /T REG_DWORD /D 0 /F
Reg Add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "DisableUAR" /T REG_DWORD /D 1 /F

Write-Host "***Setting Windows 10 privacy options for this user...***"

Reg Add "HKLM\Software\Policies\Microsoft\Windows\AppPrivacy" /T REG_DWORD /V "LetAppsAccessAccountInfo" /D 2 /F
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /T REG_DWORD /V "Enabled" /D 0 /F
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /T REG_DWORD /V "EnableWebContentEvaluation" /D 0 /F
Reg Add "HKCU\SOFTWARE\Microsoft\Input\TIPC" /T REG_DWORD /V "Enabled" /D 0  /F
Reg Add "HKCU\Control Panel\International\User Profile" /T REG_DWORD /V "HttpAcceptLanguageOptOut" /D 1 /F
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /T REG_SZ /V Value /D DENY /F
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" /T REG_SZ /V Value /D DENY /F
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /T REG_SZ /V Value /D DENY /F
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}" /T REG_SZ /V Value /D DENY /F
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" /T REG_SZ /V Value /D DENY /F
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" /T REG_SZ /V Value /D DENY /F
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" /T REG_SZ /V Value /D DENY /F
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /T REG_SZ /V Value /D DENY /F
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" /T REG_SZ /V Value /D DENY /F
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" /T REG_SZ /V Value /D DENY /F
Reg Add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /T REG_DWORD /V "AcceptedPrivacyPolicy" /D 0 /F
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /T REG_DWORD /V "Enabled" /D 0 /F
Reg Add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /T REG_DWORD /V "RestrictImplicitTextCollection" /D 1 /F
Reg Add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /T REG_DWORD /V "RestrictImplicitInkCollection" /D 1 /F
Reg Add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /T REG_DWORD /V "HarvestContacts" /D 0 /F
Reg Add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /T REG_DWORD /V "NumberOfSIUFInPeriod" /D 0 /F


Write-Host "***Disallowing apps from accessing account info on this machine...***"

Reg Add "HKLM\Software\Policies\Microsoft\Windows\AppPrivacy" /T REG_DWORD /V "LetAppsAccessAccountInfo" /D 2 /F

Write-Host "***Disallowing Cortana and web connected search through local machine policy...***"

Reg Add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "AllowCortana" /T REG_DWORD /D 0 /F
Reg Add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "ConnectedSearchUseWeb" /T REG_DWORD /D 0 /F

Write-Host "***Disabling Cortana and Bing search for this user...***"

Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "CortanaEnabled" /T REG_DWORD /D 0 /F
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "SearchboxTaskbarMode" /T REG_DWORD /D 0 /F
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "BingSearchEnabled" /T REG_DWORD /D 0 /F
Reg Add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "DeviceHistoryEnabled" /T REG_DWORD /D 0 /F

Write-Host "***Disabling some unecessary scheduled tasks...***"

Get-Scheduledtask "SmartScreenSpecific","Microsoft Compatibility Appraiser","Consolidator","KernelCeipTask","UsbCeip","Microsoft-Windows-DiskDiagnosticDataCollector", "GatherNetworkInfo","QueueReporting" | Disable-scheduledtask 

Write-Host "***Stopping and disabling diagnostics tracking services, Onedrive sync service, various Xbox services, Distributed Link Tracking, and Windows Media Player network sharing (you can turn this back on if you share your media libraries with WMP)...***"

Get-Service Diagtrack,DmwApPushService,OneSyncSvc,XblAuthManager,XblGameSave,XboxNetApiSvc,TrkWks,WMPNetworkSvc | stop-service -passthru | set-service -startuptype disabled

Write-Host "*******Decrapification complete.*******"

Write-Host "If you have unremovable tiles on your start menu afterwards, copy c:\users\USER\appdata\local\tiledatalayer from a fresh profile, AFTER running the script, to your profile, overwriting what is there. The main file is tiledatelayer.edb. This will give you a default start menu but without all the useless app icons."
Write-Host "This doesn't seem to be an issues with 1511 +" 

Write-Host "*******Reboot your computer now!*******"

