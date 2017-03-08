@ECHO OFF
setLocal Enabledelayedexpansion
set "list="
for %%x in (*.png) do (
set "list=%%x !list!"
)
REM last character will be a space
set list=!list:~0,-1!
@ECHO ON
"C:\Program Files\GIMP 2\bin\gimp-console-2.8" -i -b "(script-fu-import-png \"!list!\")" -b "(gimp-quit 0)"