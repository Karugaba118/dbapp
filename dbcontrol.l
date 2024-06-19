(ql:quickload :dbi)



;;connecting -mysql

(defvar *connection*
     (dbi:connect :mysql :database-name "datamine" :username "root" :password ""))


;; executing a query

(let*((query (dbi:prepare *connection*
              "SELECT * FROM students"))
      (query (dbi:execute query)))
     (loop for row = (dbi:fetch query)
      while row
      ;;process "row"
      do (format t "~a~%" row)))