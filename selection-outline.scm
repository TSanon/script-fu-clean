(define (script-fu-selection-outline image drawable growSize featherSize)
    (gimp-image-undo-group-start image) ;start undo group
    (let*
        (
            (outlineLayer
                (car (gimp-layer-new ;create new layer for outline
                    image ;image to add layer to
                    (car (gimp-image-width image)) ;width of full image
                    (car (gimp-image-height image)) ;height of full image
                    (car (gimp-drawable-type drawable)) ;layer to use as basis
                    "outline" ;name of the new layer
                    100 ;opacity
                    NORMAL-MODE ;mode
                ))
            )
        )
        (gimp-image-insert-layer ;add new layer to image
            image ;image to add layer to
            outlineLayer ;layer to add
            (car (gimp-item-get-parent drawable)) ;attach to same parent as active layer
            (+ 1 (car (gimp-image-get-item-position image drawable))) ;place behind the active layer
        )
        (gimp-selection-grow image growSize) ;grow the selection by growSize
        (gimp-selection-feather image featherSize) ;feather selection by featherSize
        (gimp-edit-bucket-fill outlineLayer 1 0 100 0 FALSE 0 0) ;fill with background color
        (gimp-selection-invert image) ;invert selection
        (gimp-edit-clear outlineLayer) ;clear the rest of the layer
        (gimp-selection-clear image) ;clear the selection
        (plug-in-autocrop-layer RUN-NONINTERACTIVE image outlineLayer) ;autocrop the outline layer
        (gimp-image-set-active-layer image drawable) ;set the original active layer to active again
    )
    (gimp-image-undo-group-end image) ;end undo group
    (gimp-displays-flush) ;update view
)
(script-fu-register
    "script-fu-selection-outline"            ;func name
    "Outline Selection"                 ;menu label
    "Outlines the selected area"        ;description
    "TS anon"                           ;author
    "copyright 2017, TS anon"           ;copyright notice
    "February 10, 2017"                 ;date created
    ""                                  ;image type
    SF-IMAGE        "Image"     0
    SF-DRAWABLE     "Drawable"  0
    SF-ADJUSTMENT   "Grow"      '(10 1 999 1 3 0 1) ;amount to grow selection
    SF-ADJUSTMENT   "Feather"   '(2  1 999 1 3 0 1) ;amount to feather selection
)
(script-fu-menu-register "script-fu-selection-outline" "<Image>/Select") ;register to the select menu
