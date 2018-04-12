:: #####
:: #
:: # Meus Pedidos
:: #
:: # Script para "Automatizacao Basica de formatação/instalação de novos equipamentos (Windows)"
:: # Criado por: Thiago de Mello S. G. Trufelli - thiagotrufelli@meuspedidos.com.br
:: # Data de Criação: 16/06/2016
:: # Data de ultima Alteração: 10/04/2018 - Realizado ajustes no script, adicionado instalações pelo Chocolatey
:: #
:: #####
:: Define Charset para UTF-8
chcp 65001

set dir="%UserProfile%\Desktop\Roteiro_Nova_Instalacao"

:: Ler senhas do arquivo apropiado
set /p adm_Pass=<secret.txt

:: Ativa o usuário "Administrador" local do computador
net user administrador /active:yes

:: Adiciona a senha ao usuário "Administrador" e define que ela nunca expirará
net user administrador %adm_Pass% /expires:never 

:: Adiciona o usuário MPlyaer ao grupo Usuários e emove do grupo de Addministradores
net localgroup usuários /add mplayer
net localgroup administradores /delete mplayer

:: Renomeia o Windows e adiciona ao grupo de trabalho "MEUSPEDIDOS"
PowerShell.exe -noprofile -executionpolicy bypass -file %dir%\Rename_Windows.ps1

:: Cria diretório para armazenar o Wallpaper
::mkdir c:\Temp\Wallpaper

:: Copiar Wallpaper para o diretório
::copy "%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Imagens\wallpaper.bmp" "C:\Temp\Wallpaper\wallpaper.bmp"

:: Desabilita o UAC
::reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f

:: Desabilita o Firewall
::netsh advfirewall set allprofiles state off

:: Desabilitar notificações sobre o Firewall
::netsh firewall set notifications mode = disable profile = all 

:: Libera acesso a \\ e Psexec
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\system /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f

:: Aplica a alteração
::RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

:: Desabilita Windows Defender Security Center e remove do startup
::reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v Type /t REG_DWORD /d 3 /f
::reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v SecurityHealth /f
::reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v WindowsDefender /f

:: Instala Open Office (Apenas Calc,Writer e Impress)
::msiexec.exe /i "%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Pacotes\OpenOffice 4.1.3 (pt-BR) Installation Files\openoffice413.msi" ALLUSERS=1 /qn /norestart SETUP_USED=1 RebootYesNo=No CREATEDESKTOPLINK=0 ADDLOCAL=ALL REMOVE=gm_o_Quickstart,gm_p_Base,gm_p_Base_Bin,gm_p_Draw,gm_p_Draw_Bin,gm_p_Math,gm_p_Math_Bin

:: Install Chocolatey
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

:: Maps Chocolatey Repo_MP
net use x: \\172.16.1.253\Chocolatey_Repo /user:administrador %adm_Pass%

:: Add the Chocolatey MP Repository
choco source add -n Repo_MP -s x:\

:: Chocolatey install Programs (Chrome,Notepad++,Slack,Skype)
choco install .\Packages.config -y

:: Remove atalhos para todos os usuários
::del "C:\Users\Public\Desktop\Adobe Reader XI.lnk"
::del "C:\Users\Public\Desktop\Skype.lnk"

:: Instala o Avast
::%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Pacotes\avast_business_antivirus_setup_offline.exe /silent

:: Instala plugin do Chrome Click2Call
::regedit.exe /s %UserProfile%\Desktop\Roteiro_nova_Instalacao\install_click2call.reg

:: Remover completamente o One Drive
:: Mata o processo
::taskkill /f /im OneDrive.exe

:: Desinstala o aplicativo
::%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall

:: Remove diretórios do Onedrive
::rd "%UserProfile%\OneDrive" /Q /S
::rd "%LocalAppData%\Microsoft\OneDrive" /Q /S
::rd "%ProgramData%\Microsoft OneDrive" /Q /S
::rd "C:\OneDriveTemp" /Q /S

:: Remove chaves órfãs do registro
::REG Delete "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
::REG Delete "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f

:: Executa Windows Update
::cscript %UserProfile%\Desktop\Roteiro_Nova_Instalacao\Windows_Update.vbs

:: Altera o Wallpaper para da MP
::REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /d "C:\temp\Wallpaper\wallpaper.bmp" /f

:: Limpa o Win 10
PowerShell.exe -noprofile -executionpolicy bypass -file %dir%\Windows10_Decrapifier_version_1.ps1

:: Instalar VNC
::%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Pacotes\vnc\UltraVNC_1_2_12_X64_Setup.exe /verysilent /loadinf="%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Pacotes\vnc\vncinstall.inf" /log /no restart
::copy "%UserProfile%\Desktop\Roteiro_Nova_Instalacao\Pacotes\vnc\ultravnc.ini" "%ProgramFiles%\UltraVNC\ultravnc.ini" /Y

pause