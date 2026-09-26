@echo off
setlocal

:: ============================================================================
:: Verificador de Estado de Max 9
:: Devuelve 0 si Max.exe esta corriendo, 1 si esta detenido
:: ============================================================================

tasklist /FI "IMAGENAME eq Max.exe" 2>NUL | find /I /N "Max.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo [RUNNING] Max 9 esta actualmente en ejecucion.
    exit /b 0
) else (
    echo [STOPPED] Max 9 no esta en ejecucion.
    exit /b 1
)
