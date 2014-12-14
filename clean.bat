for %%x in (*.jpg) do "C:\Program Files\GIMP 2\bin\gimp-console-2.8" -i -b "(script-fu-clean \"%%x\")" -b "(gimp-quit 0)"
