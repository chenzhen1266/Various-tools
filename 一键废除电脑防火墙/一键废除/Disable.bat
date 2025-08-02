:: ==================================================================================
:: NAME:Reset Windows Update Tool.
:: DESCRIPTION: ΢��ITEAM����רע����10�꣬�Ա�ҵ��Χ�����ݻָ���ϵͳ�������װ��ϵͳ�����Ż���.
:: AUTHOR: Manuel Gil.
:: VERSION: 10.5.4.1
:: WEBSITE:	http://wureset.com
:: ==================================================================================
:: Configure the CMD screen.
:: void mode();
:: /************************************************************************************/
:mode
	echo off
	title
	mode con cols=102 lines=40
	color 17
	cls

	goto getValues
goto :eof
:: /************************************************************************************/


:: Print the message as a title.
::		@param - text = el texto a imprimir (%*).
:: void print(string text);
:: /*************************************************************************************/
:print
	cls
	echo.
	echo.%nombre% [Version: %version%] by ΢��ITEAM����
	echo.
	echo.΢��ITEAM����רע����10�꣬�Ա�ҵ��Χ�����ݻָ���ϵͳ�������װ��ϵͳ�����Ż���
	echo.
	echo.         ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	echo.         +
	echo.         +             ���������Ǻ����͵��Աر����_�޹���ﾫƷ����
	echo.         +
	echo.         +  ������ϵͳ���Զ������������ӣ���������ѹ�������뷨������������п⡢��ͼ����........
	echo.         +
	echo.         ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	echo.
	echo.
	echo.%*
	echo.
goto :eof
:: /*************************************************************************************/


:: Add values to the Windows Registry.
::		@param - key = llave que se va a modificar (%~1).
::				value = valor que se va a agregar (%~2).
::				type = tipo de registro a agregar (%~3).
::				data = dato del nuevo registro (%~4).
:: void addReg(string key, string value, string type, string data);
:: /*************************************************************************************/
:addReg
	reg add "%~1" /v "%~2" /t "%~3" /d "%~4" /f
goto :eof
:: /*************************************************************************************/


:: Loads system values.
:: void getValues();
:: /************************************************************************************/
:getValues
	for /f "tokens=4-5 delims=[] " %%a in ('ver') do set version=%%a%%b
	for %%a in (%version%) do set version=%%a

	if %version% EQU 5.1.2600 (
		:: Nombre: "Microsoft Windows XP"
		set nombre=Microsoft Windows XP
		:: Family: Windows 5
		set Family=5
		:: Compatibilidad: Si
		set admite=Si
	) else if %version% EQU 5.2.3790 (
		:: Nombre: "Microsoft Windows XP Professional x64 Edition"
		set nombre=Microsoft Windows XP Professional x64 Edition
		:: Family: Windows 5
		set Family=5
		:: Compatibilidad: Si
		set admite=Si
	) else if %version% EQU 6.0.6000 (
		:: Nombre: "Microsoft Windows Vista"
		set nombre=Microsoft Windows Vista
		:: Family: Windows 6
		set Family=6
		:: Compatibilidad: Si
		set admite=Si
	) else if %version% EQU 6.0.6001 (
		:: Nombre: "Microsoft Windows Vista SP1"
		set nombre=Microsoft Windows Vista SP1
		:: Family: Windows 6
		set Family=6
		:: Compatibilidad: Si
		set admite=Si
	) else if %version% EQU 6.0.6002 (
		:: Nombre: "Microsoft Windows Vista SP2"
		set nombre=Microsoft Windows Vista SP2
		:: Family: Windows 6
		set Family=6
		:: Compatibilidad: Si
		set admite=Si
	) else if %version% EQU 6.1.7600 (
		:: Nombre: "Microsoft Windows 7"
		set nombre=Microsoft Windows 7
		:: Family: Windows 7
		set Family=7
		:: Compatibilidad: Si
		set admite=Si
	) else if %version% EQU 6.1.7601 (
		:: Nombre: "Microsoft Windows 7 SP1"
		set nombre=Microsoft Windows 7 SP1
		:: Family: Windows 7
		set Family=7
		:: Compatibilidad: Si
		set admite=Si
	) else if %version% EQU 6.2.9200 (
		:: Nombre: "Microsoft Windows 8"
		set nombre=Microsoft Windows 8
		:: Family: Windows 8
		set Family=8
		:: Compatibilidad: Si
		set admite=Si
	) else if %version% EQU 6.3.9200 (
		:: Nombre: "Microsoft Windows 8.1"
		set nombre=Microsoft Windows 8.1
		:: Family: Windows 8
		set Family=8
		:: Compatibilidad: Si
		set admite=Si
	) else if %version% EQU 6.3.9600 (
		:: Nombre: "Microsoft Windows 8.1 Update 1"
		set nombre=Microsoft Windows 8.1 Update 1
		:: Family: Windows 8
		set Family=8
		:: Compatibilidad: Si
		set admite=Si
	) else (
		ver | find "10.0." > nul
		if %errorlevel% EQU 0 (
			:: Nombre: "Microsoft Windows 10"
			set nombre=Microsoft Windows 10
			:: Family: Windows 10
			set Family=10
			:: Compatibilidad: Si
			set admite=Si
		) else (
			:: Nombre: "Desconocido"
			set nombre=Desconocido
			:: Compatibilidad: No
			set admite=No
		)
	)

	call :print %nombre% detected . . .

	if %admite% EQU Si goto components



:: void components();
:: /*************************************************************************************/
:components

	
	call :print ���ڷϳ�..


::�ر��û��˻�����(UAC)
rem reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /d 0 /t REG_DWORD /f >nul 2>nul  
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /d 0 /t REG_DWORD /f >nul 2>nul  

::�رմ򿪳���ġ���ȫ����
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /v "ModRiskFileTypes" /t REG_SZ /d ".bat;.exe;.reg;.vbs;.chm;.msi;.js;.cmd" /f  >nul 2>nul    
reg add "HKEY_USERS\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /v "ModRiskFileTypes" /t REG_SZ /d ".bat;.exe;.reg;.vbs;.chm;.msi;.js;.cmd" /f  >nul 2>nul    
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /v "ModRiskFileTypes" /t REG_SZ /d ".bat;.exe;.reg;.vbs;.chm;.msi;.js;.cmd" /f  >nul 2>nul 

::�رհ�ȫ����ɱ��֪ͨ,�����ɱ��defender�Ѿ��رգ���򿪵ķ�����Ϣ
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellServiceObjects\{F56F6FDD-AA9D-4618-A949-C1B91AF43B1A}" /f >nul 2>nul

::�ر�SmartscreenӦ��ɸѡ��
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /d off /t REG_SZ /f >nul 2>nul  
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "off" /f  >nul 2>nul    
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t reg_dword /d "0" /f  >nul 2>nul   

::�ر�Edg_Microsoft Defender Smartscreen
reg add "HKCU\SOFTWARE\Microsoft\Edge\SmartScreenEnabled" /f /ve /t REG_DWORD /d 0 /f  >nul 2>nul   

::ȥ����ݷ�ʽ����
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v link /t REG_BINARY /d 00000000 /f  >nul 2>nul 

::ȥ��UACС����
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 77 /d "%systemroot%\system32\imageres.dll,197" /t reg_sz /f  >nul 2>nul 
::��ʾ�����
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel /v {20D04FE0-3AEA-1069-A2D8-08002B30309D} /t REG_DWORD /d 0 /f  >nul 2>nul 


call :print ���ڷϳ�......
@Echo off
rem @chcp 1251
setlocal enabledelayedexpansion
for /f "tokens=6 delims=[]. " %%G in ('ver') do if %%G LEQ 7601 goto :WIN7
for /f "tokens=6 delims=[]. " %%G in ('ver') do if %%G EQU 9200 goto :WIN8
for /f "tokens=6 delims=[]. " %%G in ('ver') do if %%G EQU 9600 goto :WIN8
for /f "tokens=6 delims=[]. " %%G in ('ver') do if %%G GEQ 10240 goto :WIN10

:WIN7

Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /f >nul 2>nul 

net stop WinDefend >nul 2>nul 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d "0x4" /f >nul 2>nul 

SCHTASKS.exe /Change /TN "Microsoft\Windows Defender\MP Scheduled Scan" /Disable >nul 2>nul 
goto :END

:WIN8
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /f >nul 2>nul 

net stop WdNisDrv /Y
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdNisDrv" /v "Start" /t REG_DWORD /d "0x4" /f >nul 2>nul 
net stop WdNisSvc >nul 2>nul 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdNisSvc" /v "Start" /t REG_DWORD /d "0x4" /f >nul 2>nul 
net stop WinDefend >nul 2>nul 
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d "0x4" /f >nul 2>nul 

SCHTASKS.exe /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /Disable >nul 2>nul 
SCHTASKS.exe /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /Disable >nul 2>nul 
SCHTASKS.exe /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /Disable >nul 2>nul 
SCHTASKS.exe /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Verification" /Disable >nul 2>nul 
goto :END

:WIN10
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /f >nul 2>nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "AllowFastServiceStartup" /t REG_DWORD /d "0x0" /f >nul 2>nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "0x1" /f >nul 2>nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiVirus" /t REG_DWORD /d "0x1" /f >nul 2>nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /t REG_DWORD /d "0x0" /f >nul 2>nul
Reg.exe query "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Policy Manager" >nul 2>&1 || Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Policy Manager" /f && Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Policy Manager" /ve /f >nul 2>nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d "0x1" /f >nul 2>nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d "0x1" /f >nul 2>nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d "0x1" /f >nul 2>nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d "0x1" /f >nul 2>nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d "0x1" /f >nul 2>nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "DisableBlockAtFirstSeen" /t REG_DWORD /d "0x1" /f >nul 2>nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "LocalSettingOverrideSpynetReporting" /t REG_DWORD /d "0x0" /f >nul 2>nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpyNetReporting" /t REG_DWORD /d "0x0" /f >nul 2>nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d "0x0" /f >nul 2>nul

net stop WdNisDrv /Y >nul 2>nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdNisDrv" /v "Start" /t REG_DWORD /d "0x4" /f >nul 2>nul
net stop WdNisSvc >nul 2>nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdNisSvc" /v "Start" /t REG_DWORD /d "0x4" /f >nul 2>nul
net stop WinDefend >nul 2>nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d "0x4" /f >nul 2>nul
net stop wscsvc >nul 2>nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\wscsvc" /v "Start" /t REG_DWORD /d "0x4" /f >nul 2>nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d "0x0" /f >nul 2>nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.Defender.SecurityCenter" /v "Enabled" /t REG_DWORD /d "0x0" /f >nul 2>nul

SCHTASKS.exe /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /Disable >nul 2>nul
SCHTASKS.exe /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /Disable >nul 2>nul
SCHTASKS.exe /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /Disable >nul 2>nul
SCHTASKS.exe /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Verification" /Disable >nul 2>nul

:END
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Defender" /v "AllowFastServiceStartup" /t REG_DWORD /d "0x0" /f >nul 2>nul 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "0x1" /f >nul 2>nul 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Defender" /v "DisableAntiVirus" /t REG_DWORD /d "0x1" /f >nul 2>nul 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Defender" /v "ServiceKeepAlive" /t REG_DWORD /d "0x0" /f >nul 2>nul 
Reg.exe query "HKLM\SOFTWARE\Microsoft\Windows Defender\Policy Manager" >nul 2>&1 || Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Defender\Policy Manager" /f && Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows Defender\Policy Manager" /ve /f >nul 2>nul 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d "0x1" /f >nul 2>nul 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d "0x1" /f >nul 2>nul 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d "0x1" /f >nul 2>nul 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d "0x1" /f >nul 2>nul 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d "0x1" /f >nul 2>nul 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Defender\Spynet" /v "DisableBlockAtFirstSeen" /t REG_DWORD /d "0x1" /f >nul 2>nul 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Defender\Spynet" /v "LocalSettingOverrideSpynetReporting" /t REG_DWORD /d "0x0" /f >nul 2>nul 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Defender\Spynet" /v "SpyNetReporting" /t REG_DWORD /d "0x0" /f >nul 2>nul 
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d "0x0" /f >nul 2>nul 
                


	call :print ���ڷϳ�...
CLS
install_wim_tweak.exe /o /l
install_wim_tweak.exe /o /c "Windows-Defender" /r
install_wim_tweak.exe /h /o /l
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "SecurityHealth" /f
echo.
	
	call :print ���ڷϳ�................................
	net stop SecurityHealthService >nul 2>nul 
                sc.exe config SecurityHealthService start= disabled >nul 2>nul 

call :print ����ϲ���ˣ��Ѿ����׷ϳ�.15�����Զ�����.��Ч....
TIMEOUT /T 15
	:: ----- �������� -----
                start shutdown.exe /r /t 0


	call :print �������. 

goto :eof

:: /*************************************************************************************/


