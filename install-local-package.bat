@echo off
setlocal EnableExtensions

set "NAMESPACE=%~1"
if "%NAMESPACE%"=="" set "NAMESPACE=local"

set "PACKAGE_NAME=%~2"
if "%PACKAGE_NAME%"=="" set "PACKAGE_NAME=sysu-mse-cpp-template"

set "PACKAGE_VERSION=%~3"
if "%PACKAGE_VERSION%"=="" set "PACKAGE_VERSION=0.1.0"

set "DATA_ROOT=%~4"
if "%DATA_ROOT%"=="" set "DATA_ROOT=%APPDATA%"

set "REPO_ROOT=%~dp0"
if "%REPO_ROOT:~-1%"=="\" set "REPO_ROOT=%REPO_ROOT:~0,-1%"

set "TARGET_DIR=%DATA_ROOT%\typst\packages\%NAMESPACE%\%PACKAGE_NAME%"
set "TARGET_LINK=%TARGET_DIR%\%PACKAGE_VERSION%"

if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"

if exist "%TARGET_LINK%" rmdir "%TARGET_LINK%" 2>nul
if exist "%TARGET_LINK%" del "%TARGET_LINK%" 2>nul

mklink /D "%TARGET_LINK%" "%REPO_ROOT%"
if errorlevel 1 exit /b 1

echo Installed local Typst package:
echo   source: %REPO_ROOT%
echo   target: %TARGET_LINK%
echo.
echo Import it in any Typst project with:
echo   #import "@%NAMESPACE%/%PACKAGE_NAME%:%PACKAGE_VERSION%": report, lab-table
