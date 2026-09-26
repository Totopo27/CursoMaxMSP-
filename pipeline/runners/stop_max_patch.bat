@echo off
setlocal

:: ============================================================================
:: Runner de Cierre de Max 9 para Auditoría Dinámica y Remota
:: Compatible con OpenCode, herdr y Gentle AI
:: ============================================================================

echo [INFO] Cerrando instancias activas de Max 9 (Max.exe)...

tasklist /FI "IMAGENAME eq Max.exe" 2>NUL | find /I /N "Max.exe">NUL
if "%ERRORLEVEL%"=="0" (
    taskkill /IM Max.exe /F >NUL 2>&1
    echo [OK] Proceso Max.exe finalizado exitosamente.
) else (
    echo [INFO] No habia procesos activos de Max.exe ejecutandose.
)

exit /b 0
