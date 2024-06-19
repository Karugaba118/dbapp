;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;, LOADING LTK ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(ql:quickload :ltk);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; USING THE PACKAGE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package :ltk) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar *url*)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; FUNCTIONS TAKING HIGHER PRECEDENCES TO UNDEBUGGEABLE ;;;;;;;;;

(defun save-f(content url)
    (if (> (length url) 0)
        ((format url content) (setf url in) (format t "file saved"))

       (with-open-file (in (get-save-file) :direction :output);;Setting filename to file name returned
            (format in content)
            (setf url in)
        ) 
    )   
)

#|(defun save-f(content url)
    (if  url
        (with-open-file (stream url :direction :output :if-exists :overwrite)
            (format stream content)
        )
    )
)|#


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun save-as-f(content)
    (with-open-file (in (get-save-file) :direction :output);;Setting filename to file name returned
        (format in content)
        (setf url in)
    )    
)


(defun open-f (textarea)
    (with-open-file (in (get-open-file :title "Open File"))
        (format t "FILE :: ~a~%" in)
        
        (when in 
            (clear-text (textbox textarea))
            (loop for line = (read-line in nil)
                while line do (append-text (textbox textarea) line)
                              (append-newline (textbox textarea))  
            )
            (close in)
        )
        (setf url in)
    )   
)

(defun about()
    ;(make-toplevel *tk* )
    ;(wm-title *about* "About")
    
    (with-ltk()
        (wm-title *tk* " About ")
        (minsize *tk* 1000 750)
    )    
)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;; MAIN ENTRY OF THE APP ;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun main()
    ;;(wm-title *tk* "Editor-T")
    (with-ltk()
        (wm-title *tk* " ########  My DataBase #####################")
        (minsize *tk* 1000 750)
        (let* (
                (url "")                                ;;i will call it global url....
                
                (textarea (make-instance 'scrolled-text))
                (menubar (make-instance 'menubar))
                (file-menu (make-instance 'menu :text "File" :master menubar))
                (file-edit (make-instance 'menu :text "Edit" :master menubar))
                (about-menu (make-instance 'menu :text "About" :master menubar))
                (save (make-instance 'menubutton :text "Save" :master file-menu :command (lambda () (save-f (text textarea) url))))
                (save-as (make-instance 'menubutton :text "Save As" :master file-menu :command (lambda () (setf url (save-as-f (text textarea) )))))
                (open (make-instance 'menubutton :text "Open" :master file-menu :command (lambda () (setf url (Open-f textarea)))))
                (undo (make-instance 'menubutton :text "Undo" :master file-edit :command (lambda () (print url))))
                (about (make-instance 'menubutton :text "About" :master about-menu :command (lambda () (about))))
                

                (c-menu (make-instance 'menu :text "Options"));;; CONTEXTUAL MENU ;;;;;;;;;;;;;;;;;
                (c-save (make-instance 'menubutton :text "save" :master c-menu :command (lambda () (print "Saving....c....."))))
                (c-open (make-instance 'menubutton :text "open" :master c-menu :command (lambda () (print "opening....c....."))))


            )

            (place textarea 5 5 :width 1900 :height 800)
              
        )
        (bind *tk* "<3>" (lambda (evt) (popup c-menu 
            (event-root-x evt) (event-root-y evt)
        )))
        
    )
)

(main)