@echo off
setlocal enabledelayedexpansion

:MainMenu
cls
echo.
:: ���� PC�� IP�� ȭ�鿡 ���
ipconfig | findstr /i "ipv4"
echo.

echo. 1. Add-Computer
echo.
echo. 2. Rename-Computer
echo.
echo. 3. Add-Administrator-Group
echo.
echo. 4. Reboot-windows
echo.  

choice /C:12340X /N /M   "Input Number : "  

if errorlevel 4 goto :Reboot-windows
if errorlevel 3 goto :Add-Administrator-Group
if errorlevel 2 goto :Rename-Computer
if errorlevel 1 goto :Add-Computer

:: ������ ����
:Add-Computer
cls
powershell Add-Computer -DomainName �������ּ� -Credential ������\����
pause
goto MainMenu

:: ��ǻ�� �̸� ����
:Rename-Computer
cls
set/p str=��ǻ�� �̸��� �Է��ϼ��� : 
powershell Rename-Computer -NewName "%str%" -DomainCredential ������\����
pause
goto MainMenu

:: ������ �׷쿡 ����� �߰�
:Add-Administrator-Group
cls
set/p str=Input User accounts : 
net localgroup administrators /add %str%
pause
goto MainMenu

:: ������ ���� ���� �� PC �����
:Reboot-windows
cls
:: ���� PC ������ ���� ���� ����
net user ���ð����̸� /active ���ð�����ȣ
:: ��ȣ ��� �Ⱓ ������
net accounts /maxpwage:unlimited
net accounts /minpwage:0
:: Windows ���� �����
shutdown -r -t 0
pause

