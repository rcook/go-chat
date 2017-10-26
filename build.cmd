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

cd %go_bindata_dir%
endlocal
set GOPATH=%parent_parent_dir%
go build

%go_bindata_path% public

goto :eof
