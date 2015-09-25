rem DOS Script to Reset Windows Update Agent
rem https://gallery.technet.microsoft.com/scriptcenter/Dos-Command-Line-Batch-to-fb07b159/view/

sc query wuauserv | findstr /I /C:"STOPPED"
if %errorlevel% NEQ 0 (
  net stop wuauserv
  if ERRORLEVEL 1 goto END
)

cd %systemroot%
if ERRORLEVEL 1 goto END

if EXIST SoftwareDistribution.old (
  rmdir /S /Q SoftwareDistribution.old
  if ERRORLEVEL 1 goto END
)
if EXIST SoftwareDistribution (
  ren SoftwareDistribution SoftwareDistribution.old
  if ERRORLEVEL 1 goto END
)

net start wuauserv
if ERRORLEVEL 1 goto END

sc query bits | findstr /I /C:"STOPPED"
if %errorlevel% NEQ 0 (
  net stop bits
  if ERRORLEVEL 1 goto END
)
net start bits
if ERRORLEVEL 1 goto END

sc query cryptsvc | findstr /I /C:"STOPPED"
if %errorlevel% NEQ 0 (
  net stop cryptsvc
  if ERRORLEVEL 1 goto END
)

cd %systemroot%\system32
if ERRORLEVEL 1 goto END

if EXIST catroot2.old (
  rmdir /S /Q catroot2.old
  if ERRORLEVEL 1 goto END
)
if EXIST catroot2 (
  ren catroot2 catroot2.old
  if ERRORLEVEL 1 goto END
)

net start cryptsvc
if ERRORLEVEL 1 goto END

:END

