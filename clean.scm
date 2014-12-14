;Place in the GIMP scripts folder. (don't forget to refresh scripts before running)
;Windows: C:\Program Files\GIMP 2\share\gimp\2.0\scripts
;TODO: use filename patterns instead of running script repeatedly from .bat
(define (script-fu-clean file)
	(let* ((image (car (gimp-file-load RUN-NONINTERACTIVE file file))) ;load file
			(drawable (car (gimp-image-get-active-drawable image))) ;get drawable
			(mfile (car (strbreakup file ".")))  ;nuke anything after the first '.' (pay attention to naming schemes)
			(sfile (string-append mfile ".xcf")) ;add .xcf extension (separate in case we ever need just the filename again)
		)
		(gimp-image-convert-grayscale image) ;grayscale
		(gimp-brightness-contrast drawable 0 50) ;contrast up
		;add more manipulation that can be automated here
		
		(gimp-xcf-save RUN-NONINTERACTIVE image drawable sfile sfile) ;save
	)
)

(script-fu-register
    "script-fu-clean"                        		;func name
    "clean conv"                                  	;menu label
    "changes mode and contrast"              		;description
    "TS anon"                             			;author
    "copyright 2014, TS anon"        				;copyright notice. Will change to GPL or something later.
    "December 11, 2014"                          	;date created
    ""                     							;image type that the script works on
    SF-FILENAME      "file"          "file name"	;a file name
)
;(script-fu-menu-register "script-fu-clean" "<Image>/File/Convert/clean") ;not quite right. Only used in batch mode anyway.
