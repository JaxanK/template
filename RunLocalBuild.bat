@echo off
setlocal enabledelayedexpansion

set "directory=%cd%\target\net.clojars..........."

set "latestVersion=0.0.0"
set "latestFileName="
set latestMajor=0
set latestMinor=0
set latestPatch=0

for /f "delims=" %%a in ('dir /b /a-d /on /tw "%directory%\*.jar" 2^>nul') do (
    set "fileName=%%~na"
    REM Extracting version numbers from the file name
    for /f "tokens=2 delims=-" %%i in ("!fileName!") do (
        set "version=%%i"
        for /f "tokens=1-3 delims=." %%A in ("!version!") do (
            set /a major=%%A
            set /a minor=%%B
            set /a patch=%%C
        )
    )

    REM Compare the extracted version with the current latestVersion
    if !major! GTR !latestMajor! (
        set /a latestMajor=!major!
        set /a latestMinor=!minor!
        set /a latestPatch=!patch!
        set "latestVersion=!major!.!minor!.!patch!"
        set "latestFileName=%%a"
    ) else if !major! EQU !latestMajor! (
        if !minor! GTR !latestMinor! (
            set /a latestMajor=!major!
            set /a latestMinor=!minor!
            set /a latestPatch=!patch!
            set "latestVersion=!major!.!minor!.!patch!"
            set "latestFileName=%%a"
        ) else if !minor! EQU !latestMinor! (
            if !patch! GEQ !latestPatch! (
                set /a latestMajor=!major!
                set /a latestMinor=!minor!
                set /a latestPatch=!patch!
                set "latestVersion=!major!.!minor!.!patch!"
                set "latestFileName=%%a"
            )
        )
    )
)

echo Latest Version Filename: %latestFileName%


cd "target\net.clojars.SSM"
java -jar "%latestFileName%"