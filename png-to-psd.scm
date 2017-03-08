;Place in the GIMP scripts folder. (don't forget to refresh scripts before running)
;Windows: C:\Program Files\GIMP 2\share\gimp\2.0\scripts
;This uses filename patterns instead of running script repeatedly from .bat!
(define (script-fu-png-to-psd files)
	(let* (
            (filelist (strbreakup files " "))
            (first (car filelist))
            (rest (unbreakupstr (cdr filelist) " "))
            (image (car (gimp-file-load RUN-NONINTERACTIVE first first))) ;load file
            (drawable (car (gimp-image-get-active-drawable image))) ;get drawable
            (mfile (car (strbreakup first ".")))  ;nuke anything after the first '.' (pay attention to naming schemes)
            (sfile (string-append mfile ".psd")) ;add .xcf extension (separate in case we ever need just the filename again)
		)
        ;add more manipulation that can be automated here
                
        (file-psd-save RUN-NONINTERACTIVE image drawable sfile sfile 1 0) ;save
        
		(script-fu-png-to-psd rest)
	)
)

(script-fu-register
    "script-fu-png-to-psd"                       ;func name
    "convert png to psd"                          	;menu label
    "batch converts png files to psd"          		;description
    "TS anon"                             			;author
    "copyright 2017, TS anon"        				;copyright notice
    "March 7, 2017"                             	;date created
    ""                     							;image type that the script works on
    SF-STRING      "files"          "file names"	;file names
)
