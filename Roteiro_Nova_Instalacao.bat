:: #####
:: #
:: # Meus Pedidos
:: #
:: # Script para "Automatizacao Basica de formatação/instalação de novos equipamentos (Windows)"
:: # Criado por: Thiago de Mello S. G. Trufelli - thiagotrufelli@meuspedidos.com.br
:: # Data de Criação: 16/06/2016
:: # Data de ultima Alteração: 26/10/2017 - Removido a instalação do Google Drive e adicionado a instalação do Google Drive File Stream
:: #
:: #####

::# TESTE

:: Define Charset para UTF-8
chcp 65001

:: Limpa o Win 10
::PowerShell.exe -noprofile -executionpolicy bypass -file %UserProfile%\Desktop\Roteiro_Nova_Instalacao\Windows10_Decrapifier_version_1.ps1

:: Renomeia o Windows e adiciona ao grupo de trabalho "MEUSPEDIDOS"
PowerShell.exe -noprofile -executionpolicy bypass -file %UserProfile%\Desktop\Roteiro_Nova_Instalacao\Rename_Windows.ps1

:: Remove o diretório "Administrador" do diretório "c:\users\", para que assim, não ocorra erro ao criar o usuário "Administrador"
rmdir C:\Users\Administrador /S /Q

:: Ativa o usuário "Administrador" local do computador
net user administrador /active:yes

:: Adiciona a senha ao usuário "Administrador" e define que ela nunca expirará
net user administrador m3us@p3d1d0s /expires:never 

:: Cria diretório para armazenar o Wallpaper
mkdir c:\Temp\Wallpaper

:: Copiar Wallpaper para o diretório
copy "%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Imagens\wallpaper.bmp" "C:\Temp\Wallpaper\wallpaper.bmp"

:: Define o Wallpaper do MPlayer
::reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d C:\Temp\Wallpaper\wallpaper.bmp /f

:: Defnie o Lockscreen do MPlayer
::REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization /V LockScreenImage /T REG_SZ /D C:\temp\wallpaper\wallpaper.bmp /F

:: Desabilita o UAC
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f

:: Desabilita a Cortana
::reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f

:: Desabilita o Firewall
netsh advfirewall set allprofiles state off

:: Desabilitar notificações sobre o Firewall
netsh firewall set notifications mode = disable profile = all 

:: Libera acesso a \\ e Psexec
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\system /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f

:: Aplca a alteração
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

:: Desabilita Windows Defender Security Center e remove do startup
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v Type /t REG_DWORD /d 3 /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v SecurityHealth /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v WindowsDefender /f

:: Renomeia arquivos originais de imagens do usuário
::ren "C:\ProgramData\Microsoft\User Account Pictures\guest.bmp" "guest.original.bmp"
::ren "C:\ProgramData\Microsoft\User Account Pictures\user.bmp" "user.original.bmp"
::ren "C:\ProgramData\Microsoft\User Account Pictures\user-32.png" "user-32.original.png"
::ren "C:\ProgramData\Microsoft\User Account Pictures\user-40.png" "user-40.original.png"
::ren "C:\ProgramData\Microsoft\User Account Pictures\user-48.png" "user-48.original.png"
::ren "C:\ProgramData\Microsoft\User Account Pictures\user-192.png" "user-192.original.png"

:: Copia os arquivos da MP de imagens do usuário
::copy "%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Imagens\guest.bmp" "C:\ProgramData\Microsoft\User Account Pictures\guest.bmp"
::copy "%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Imagens\user.bmp" "C:\ProgramData\Microsoft\User Account Pictures\user.bmp"
::copy "%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Imagens\user-32.png" "C:\ProgramData\Microsoft\User Account Pictures\user-32.png"
::copy "%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Imagens\user-40.png" "C:\ProgramData\Microsoft\User Account Pictures\user-40.png"
::copy "%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Imagens\user-48.png" "C:\ProgramData\Microsoft\User Account Pictures\user-48.png"
::copy "%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Imagens\user-192.png" "C:\ProgramData\Microsoft\User Account Pictures\user-192.png"

:: Instala o 7zip
msiexec /i "%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Pacotes\7z1604-x64.msi" /quiet

:: Instala Open Office (Apenas Calc,Writer e Impress)
msiexec.exe /i "%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Pacotes\OpenOffice 4.1.3 (pt-BR) Installation Files\openoffice413.msi" ALLUSERS=1 /qn /norestart SETUP_USED=1 RebootYesNo=No CREATEDESKTOPLINK=0 ADDLOCAL=ALL REMOVE=gm_o_Quickstart,gm_p_Base,gm_p_Base_Bin,gm_p_Draw,gm_p_Draw_Bin,gm_p_Math,gm_p_Math_Bin

:: Instala o Skype
%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Pacotes\SkypeSetup.exe /silent /install

:: Remove atalho do Skype de todos os usuários
del "C:\Users\Public\Desktop\Skype.lnk"

:: Instala o Chrome
%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Pacotes\ChromeStandaloneSetup64.exe /silent /install

:: Instala o Notepad++
%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Pacotes\npp.7.5.4.Installer.x64.exe /S

:: Instala o Avast
%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Pacotes\avast_business_antivirus_setup_offline.exe /silent

:: Remove o atalho do Avast de todos os usuários
del "C:\Users\Public\Desktop\Avast Business Security.lnk"

:: Instala Slack
%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Pacotes\SlackSetup.exe

:: Instala o Drive ( Substituido pelo Google Drive File Stream )
::msiexec /i %UserProfile%\Desktop\Roteiro_Nova_Instalacao\Pacotes\gsync_enterprise.msi /quiet
%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Pacotes\GoogleDriveFSSetup.exe --silent

:: Instala Adobe Reader 
%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Pacotes\AdbeRdr11000_pt_BR.exe /msi EULA_ACCEPT=YES /qn

:: Remove atalho do Adobe de todos os usuários
del "C:\Users\Public\Desktop\Adobe Reader XI.lnk"

:: Chama o instalador do Hosanna
::%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Pacotes\Setup_HosannaAiOAgent-4.0.0.4_rc6.exe"

:: Instala plugin do Chrome Click2Call
regedit.exe /s %UserProfile%\Desktop\Roteiro_nova_Instalacao\install_click2call.reg

:: Remover completamente o One Drive
:: Mata o processo
taskkill /f /im OneDrive.exe

:: Desinstala o aplicativo
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall

:: Remove diretórios do Onedrive
rd "%UserProfile%\OneDrive" /Q /S
rd "%LocalAppData%\Microsoft\OneDrive" /Q /S
rd "%ProgramData%\Microsoft OneDrive" /Q /S
rd "C:\OneDriveTemp" /Q /S

:: Remove chaves órfãs do registro
REG Delete "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
REG Delete "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f

:: Executa Windows Update
cscript %UserProfile%\Desktop\Roteiro_Nova_Instalacao\Windows_Update.vbs

:: Remove Apps Nativos do Win10 desnecessários (Twitter, Facebook, Netflix, etc...)

::PowerShell.exe -noprofile -executionpolicy bypass -file %UserProfile%\Desktop\Roteiro_Nova_Instalacao\Remove_Win_10_Apps.ps1
::PowerShell.exe -noprofile -executionpolicy bypass -file %UserProfile%\Desktop\Roteiro_Nova_Instalacao\Windows10_Decrapifier_version_1.ps1

:: Altera o Wallpaper para da MP
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /d "C:\temp\Wallpaper\wallpaper.bmp" /f

:: Limpa o Win 10
PowerShell.exe -noprofile -executionpolicy bypass -file %UserProfile%\Desktop\Roteiro_Nova_Instalacao\Windows10_Decrapifier_version_1.ps1

:: Adiciona o usuário MPlyaer ao grupo Usuários e emove do grupo de Addministradores
net localgroup usuários /add mplayer
net localgroup administradores /delete mplayer

:: Instalar VNC
%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Pacotes\vnc\UltraVNC_1_2_12_X64_Setup.exe /verysilent /loadinf="%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Pacotes\vnc\vncinstall.inf" /log /no restart
copy "%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Pacotes\vnc\ultravnc.ini" "%ProgramFiles%\UltraVNC\ultravnc.ini" /Y
::net stop uvnc_service 
::net start uvnc_service 

pause