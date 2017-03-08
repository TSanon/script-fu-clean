;Place in the GIMP scripts folder. (don't forget to refresh scripts before running)
;Windows: C:\Program Files\GIMP 2\share\gimp\2.0\scripts
;This uses filename patterns instead of running script repeatedly from .bat!
(define (script-fu-import-png files)
	(let* (
            (filelist (strbreakup files " "))
            (first (car filelist))
            (rest (unbreakupstr (cdr filelist) " "))
            (image (car (gimp-file-load RUN-NONINTERACTIVE first first))) ;load file
            (drawable (car (gimp-image-get-active-drawable image))) ;get drawable
            (mfile (car (strbreakup first ".")))  ;nuke anything after the first '.' (pay attention to naming schemes)
            (sfile (string-append mfile ".xcf")) ;add .xcf extension (separate in case we ever need just the filename again)
		)
        (gimp-image-convert-grayscale image) ;grayscale
        ;add more manipulation that can be automated here
                
        (gimp-xcf-save RUN-NONINTERACTIVE image drawable sfile sfile) ;save
        
		(script-fu-import-png rest)
	)
)

(script-fu-register
    "script-fu-import-png"                    		;func name
    "import  png"                                  	;menu label
    "batch imports png files"               		;description
    "TS anon"                             			;author
    "copyright 2017, TS anon"        				;copyright notice
    "March 7, 2017"                             	;date created
    ""                     							;image type that the script works on
    SF-STRING      "files"          "file names"	;file names
)
