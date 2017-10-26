@echo off
setlocal

call :Main "%~dp0" "%~dp0.." "%~dp0..\.."
goto :eof

:Main
set x=%~f1
set script_dir=%x:~0,-1%
set parent_dir=%~f2
set parent_parent_dir=%~f3
set go_bindata_dir=%script_dir%\vendor\github.com\jteeuwen\go-bindata\go-bindata
set go_bindata_path=%go_bindata_dir%\go-bindata

cd /d "%go_bindata_dir%"
endlocal
set GOPATH=%parent_parent_dir%
go build
if errorlevel 1 (
    echo go build failed
    exit /b 1
)

cd /d "%script_dir%"
"%go_bindata_path%" public
if errorlevel 1 (
    echo go-bindata failed
    exit /b 1
)

cd /d "%script_dir%"
go build -o go-chat.exe .
if errorlevel 1 (
    echo go build failed
    exit /b 1
)

cd /d "%script_dir%"
dir
go-chat.exe
if errorlevel 1 (
    echo go-chat.exe failed
    exit /b 1
)

goto :eof
