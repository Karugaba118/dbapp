;;;;;;;;;AUTHOR: KARUGABA CONFORT MWESIGWA ;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;, LOADING LTK ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(ql:quickload '(ltk dbi));;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; USING THE PACKAGE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package :ltk) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar *connection*)
(defvar *query*)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; FUNCTIONS TAKING HIGHER PRECEDENCES TO UNDEBUGGEABLE ;;;;;;;;;

(defun connect(db user pwd)
    ;;connecting -mysql

    (defvar *connection* (dbi:connect :mysql :database-name db :username user :password pwd))




    (if *connection* (admin-window) (print "Failed"))
    
    
    ;; executing a query

   ; (let*((query (dbi:prepare *connection* "SELECT * FROM users")) (query (dbi:execute query)))
   ;     (loop for row = (dbi:fetch query)
   ;         while row
   ;             ;;process "row"
   ;             do (format t "~a~%" row)))

)

(defun admin-window()


    (with-ltk()
        (wm-title *tk* " ########  My DataBase #####################")
        (minsize *tk* 1000 750)
        (let* (
                ;(content (make-instance 'frame ))
                (listbox (make-instance 'listbox :height 5))
                (scrollbar (make-instance 'scrollbar :orientation :vertical))
                (status (make-instance 'label :text "Status MASSAGE here")))

                ;(configure content :padding "5 5 12 0")
                ;(grid content 0 0 :sticky)
                ;(listbox-append listbox *db-results*)


                (grid listbox 0 0 :sticky "nwes")
                (grid scrollbar 0 1 :sticky "ns")
                (grid status 1 0 :columnspan 2 :sticky "we")

                (configure scrollbar :command (format nil "~a yview" (widget-path listbox)))
                (configure listbox :yscrollcommand (format nil "~a set" (widget-path scrollbar)))

                (grid-columnconfigure *tk* 0 :weight 1)
                (grid-rowconfigure *tk* 0 :weight 1)

                ;(dotimes (i 100) (listbox-append listbox(format nil "Line ~a of 100" (+ 1 i))))
                
                (query (dbi:prepare *connection* "SELECT * FROM users")) (query (dbi:execute query))
                (loop for row = (dbi:fetch query)  while row do (listbox-append listbox( format t "~a~%" row)))
                
            

                




            )
              
        )
    
    )





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;; MAIN ENTRY OF THE APP ;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun main()
    ;;(wm-title *tk* "Editor-T")
    (with-ltk()
        (wm-title *tk* " ########  ADMIN LOGIN #####################")
        ;(minsize *tk* 500 340 )
        (maxsize *tk* 1000 750)
        (set-geometry *tk* 700 360 500 300)
        (let* (
                (frame (make-instance 'frame :borderwidth 10 :relief :ridge))
                (database (make-instance 'entry :master frame)) (databasel (make-instance 'label :master frame :text "Database: "))
                (username (make-instance 'entry :master frame)) (usernamel (make-instance 'label :master frame :text "Username: "))
                (password (make-instance 'entry :master frame)) (passwordl (make-instance 'label :master frame :text "Password: "))
                (login (make-instance 'button :text "Login" :master frame :command (lambda () 
                                                                        (connect
                                                                            (text database) (text username) (text password))
                                                                    
                                                                     )))
            )
            ()
            (grid frame 0 0 :sticky "nsew" :pady 100 :padx 180 :ipadx 30 :ipady 30)

            (grid databasel 0 0 :sticky "nw" :pady 5 :ipadx 10)
            ;(grid (make-instance 'label :text "Database: " :master frame) 0 0)
            (grid database 0 1 :pady 5 :ipadx 40)

            (grid usernamel 1 0 :sticky "nw" :pady 5)
            ;(grid (make-instance 'label :text "Username: " :master frame) 1 0)
            (grid username 1 1 :pady 5 :ipadx 40)

            (grid passwordl 2 0 :sticky "nw" :pady 5)
            ;(grid (make-instance 'label :text "Password: " :master frame) 2 0)
            (grid password 2 1 :pady 5 :ipadx 40)
            (grid login 3 0 :columnspan 2 :ipadx 20) 
        )
    )
)

(main)