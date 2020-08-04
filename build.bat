@echo off
setlocal

set destdir=c:\dist

curl -L https://www.python.org/ftp/python/3.8.5/python-3.8.5-amd64.exe -o %tmp%\python-setup.exe
taskkill /im python.exe /f /t
taskkill /im pythonw.exe /f /t
taskkill /im pip.exe /f /t

set regprefix=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall
reg delete "%regprefix%\{02C7481D-3B7E-4229-8895-C5C67356E2DB}" /va /f
reg delete "%regprefix%\{216A8530-DA4B-42FE-BDD4-DCDC1298FB6C}" /va /f
reg delete "%regprefix%\{353902D3-9C1B-4E11-B055-2164087BFEA9}" /va /f
reg delete "%regprefix%\{366349F7-DA19-4977-83EB-302019FA690A}" /va /f
reg delete "%regprefix%\{A3E57B8B-8336-4C64-83B7-5C6EC8E25254}" /va /f
reg delete "%regprefix%\{B0F29718-AB7A-40AF-8DF9-4E6129FFBCD4}" /va /f
reg delete "%regprefix%\{CD482F6D-9FC2-4042-B380-9FB198102148}" /va /f
reg delete "%regprefix%\{E93535B0-FC43-4105-AD73-E8773084A4D4}" /va /f
reg delete "%regprefix%\{F0846ED9-FA40-460F-A5F4-E4448619CC89}" /va /f
reg delete "%regprefix%\{FA7816C5-12FB-4278-9437-E99AA9639E59}" /va /f


%tmp%\python-setup.exe /quiet TargetDir=c:\py Include_lib=1 Include_symbols=1 CompileAll=1 Include_dev=1 PrependPath=0 AssociateFiles=0 Shortcuts=0 Include_doc=0 Include_test=0 Include_tools=0 Include_pip=0 Include_launcher=0 Include_exe=1
curl -L https://www.python.org/ftp/python/3.8.5/python-3.8.5-embed-amd64.zip -o %tmp%\python-min.zip
mkdir "%destdir%"
powershell -c "Expand-Archive -Path \"${env:tmp}\python-min.zip\" -DestinationPath \"${env:destdir}\" -force"
choco install /y pkgconfiglite
set PKG_CONFIG_PATH=%~dp0pkg-config
go build -o "%destdir%"
