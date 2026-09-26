@echo off
setlocal enabledelayedexpansion

:: ============================================================================
:: Runner de Inicio de Parches Max 9 para Auditoría Dinámica y Remota
:: Compatible con OpenCode, herdr y Gentle AI
:: ============================================================================

set MAX_EXE="D:\Program Files\Cycling '74\Max 9\Max.exe"

if not exist %MAX_EXE% (
    echo [ERROR] No se encontro el ejecutable de Max 9 en: %MAX_EXE%
    exit /b 1
)

if "%~1"=="" (
    echo [INFO] Iniciando Max 9 sin parche especifico...
    start "" %MAX_EXE%
) else (
    set TARGET_PATCH=%~f1
    if not exist "!TARGET_PATCH!" (
        echo [ERROR] No se encontro el archivo del parche: "!TARGET_PATCH!"
        exit /b 1
    )
    echo [INFO] Iniciando Max 9 con el parche: "!TARGET_PATCH!"
    start "" %MAX_EXE% "!TARGET_PATCH!"
)

echo [OK] Max 9 iniciado en segundo plano.
exit /b 0
