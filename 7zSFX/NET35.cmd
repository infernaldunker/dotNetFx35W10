@echo off
if exist "%Windir%\Sysnative\reg.exe" (set "SysPath=%Windir%\Sysnative") else (set "SysPath=%Windir%\System32")
set "Path=%SysPath%;%Windir%;%SysPath%\Wbem"
for /f "tokens=6 delims=[]. " %%G in ('ver') do set winbuild=%%G
if %winbuild% LSS 10240 (
  if not "%1"=="" goto :eof
  echo ==== ERROR ====
  echo This package is only for Windows 10
  echo Press any Key to Exit.
  pause >nul
  goto :eof
)
set arch=x64
if /i "%PROCESSOR_ARCHITECTURE%"=="x86" (
if "%PROCESSOR_ARCHITEW6432%"=="" set arch=x86
)
cd /d "%~dp0"
if %winbuild% LSS 16299 (
set "source=%arch%\16299\update.mum"
)
if %winbuild% GEQ 16299 (
set "source=%arch%\16299\update.mum"
)
if %winbuild% GEQ 17134 (
set "source=%arch%\17134\update.mum"
)
if %winbuild% GEQ 17763 (
set "source=%arch%\17763\update.mum"
)
echo.
DISM.exe /Online /NoRestart /Add-Package /PackagePath:"%source%"
echo.
echo ============================================================
echo.
if not "%1"=="" goto :eof
echo Press any Key to Exit.
pause >nul
goto :eof