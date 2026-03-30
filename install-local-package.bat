@echo off
setlocal EnableExtensions

set "FORCE=0"
if /I "%~1"=="--force" (
  set "FORCE=1"
  shift
) else if /I "%~1"=="-f" (
  set "FORCE=1"
  shift
)

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

call :validate_path_segment "namespace" "%NAMESPACE%" || exit /b 1
call :validate_path_segment "package name" "%PACKAGE_NAME%" || exit /b 1
call :validate_path_segment "package version" "%PACKAGE_VERSION%" || exit /b 1

set "PACKAGES_ROOT=%DATA_ROOT%\typst\packages"
set "TARGET_DIR=%PACKAGES_ROOT%\%NAMESPACE%\%PACKAGE_NAME%"
set "TARGET_LINK=%TARGET_DIR%\%PACKAGE_VERSION%"

if /I not "%TARGET_LINK:%PACKAGES_ROOT%\=%"=="%TARGET_LINK%" goto target_checked
echo Error: refusing to operate outside Typst packages directory: %TARGET_LINK%
exit /b 1

:target_checked

if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"

if exist "%TARGET_LINK%" (
  if not "%FORCE%"=="1" (
    echo Error: target already exists: %TARGET_LINK%
    echo Refusing to remove it without --force.
    exit /b 1
  )
)

if "%FORCE%"=="1" (
  if exist "%TARGET_LINK%\NUL" (
    rmdir /S /Q "%TARGET_LINK%" 2>nul
  ) else if exist "%TARGET_LINK%" (
    del /F /Q "%TARGET_LINK%" 2>nul
  )
)

if exist "%TARGET_LINK%" (
  echo Error: failed to remove existing target: %TARGET_LINK%
  exit /b 1
)

mklink /D "%TARGET_LINK%" "%REPO_ROOT%"
if errorlevel 1 exit /b 1

echo Installed local Typst package:
echo   source: %REPO_ROOT%
echo   target: %TARGET_LINK%
echo.
echo Import it in any Typst project with:
echo   #import "@%NAMESPACE%/%PACKAGE_NAME%:%PACKAGE_VERSION%": report, lab-table
exit /b 0

:validate_path_segment
set "SEGMENT_LABEL=%~1"
set "SEGMENT_VALUE=%~2"

if "%SEGMENT_VALUE%"=="" (
  echo Error: %SEGMENT_LABEL% must not be empty.
  exit /b 1
)

if "%SEGMENT_VALUE%"=="." (
  echo Error: invalid %SEGMENT_LABEL% '%SEGMENT_VALUE%'. Use a single path segment without slash, backslash, '.' or '..'.
  exit /b 1
)

if "%SEGMENT_VALUE%"==".." (
  echo Error: invalid %SEGMENT_LABEL% '%SEGMENT_VALUE%'. Use a single path segment without slash, backslash, '.' or '..'.
  exit /b 1
)

if not "%SEGMENT_VALUE:/=%"=="%SEGMENT_VALUE%" (
  echo Error: invalid %SEGMENT_LABEL% '%SEGMENT_VALUE%'. Use a single path segment without slash, backslash, '.' or '..'.
  exit /b 1
)

if not "%SEGMENT_VALUE:\=%"=="%SEGMENT_VALUE%" (
  echo Error: invalid %SEGMENT_LABEL% '%SEGMENT_VALUE%'. Use a single path segment without slash, backslash, '.' or '..'.
  exit /b 1
)

exit /b 0
