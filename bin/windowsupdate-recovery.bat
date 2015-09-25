net stop wuauserv

cd %systemroot%
if ERRORLEVEL 1 goto END

if Exist SoftwareDistribution.old (
  rmdir /S /Q SoftwareDistribution.old
  if ERRORLEVEL 1 goto END
)
if Exist SoftwareDistribution (
  ren SoftwareDistribution SoftwareDistribution.old
  if ERRORLEVEL 1 goto END
)

net start wuauserv
if ERRORLEVEL 1 goto END

net stop bits
net start bits
if ERRORLEVEL 1 goto END

net stop cryptsvc

cd %systemroot%\system32
if ERRORLEVEL 1 goto END

if Exist catroot2.old (
  rmdir /S /Q catroot2.old
  if ERRORLEVEL 1 goto END
)
if Exist catroot2 (
  ren catroot2 catroot2.old
  if ERRORLEVEL 1 goto END
)

net start cryptsvc
if ERRORLEVEL 1 goto END

:END
