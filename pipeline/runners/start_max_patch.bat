@echo off
setlocal

set MAX_EXE=D:\Program Files\Cycling '74\Max 9\Max.exe

if not exist "%MAX_EXE%" (
    echo [ERROR] No se encontro Max 9
    exit /b 1
)

if "%~1"=="" (
    echo [INFO] Iniciando Max 9...
    start "" "%MAX_EXE%"
) else (
    echo [INFO] Iniciando Max 9 con: "%~f1"
    start "" "%MAX_EXE%" "%~f1"
)

exit /b 0
