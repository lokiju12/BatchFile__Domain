@echo off
setlocal enabledelayedexpansion

:MainMenu
cls
echo.
:: 현재 PC의 IP를 화면에 출력
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

:: 도메인 가입
:Add-Computer
cls
powershell Add-Computer -DomainName 도메인주소 -Credential 도메인\계정
pause
goto MainMenu

:: 컴퓨터 이름 변경
:Rename-Computer
cls
set/p str=컴퓨터 이름을 입력하세요 : 
powershell Rename-Computer -NewName "%str%" -DomainCredential 도메인\계정
pause
goto MainMenu

:: 관리자 그룹에 사용자 추가
:Add-Administrator-Group
cls
set/p str=Input User accounts : 
net localgroup administrators /add %str%
pause
goto MainMenu

:: 관리용 계정 생성 후 PC 재부팅
:Reboot-windows
cls
:: 유저 PC 관리용 로컬 계정 생성
net user 로컬계정이름 /active 로컬계정암호
:: 암호 사용 기간 무제한
net accounts /maxpwage:unlimited
net accounts /minpwage:0
:: Windows 강제 재부팅
shutdown -r -t 0
pause

