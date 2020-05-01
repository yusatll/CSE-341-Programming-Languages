(load "csv-parser.lisp")
(in-package :csv-parser)

;; (read-from-string STRING)
;; This function converts the input STRING to a lisp object.
;; In this code, I use this function to convert lists (in string format) from csv file to real lists.

;; (nth INDEX LIST)
;; This function allows us to access value at INDEX of LIST.
;; Example: (nth 0 '(a b c)) => a

;; !!! VERY VERY VERY IMPORTANT NOTE !!!
;; FOR EACH ARGUMENT IN CSV FILE
;; USE THE CODE (read-from-string (nth ARGUMENT-INDEX line))
;; Example: (mypart1-funct (read-from-string (nth 0 line)) (read-from-string (nth 1 line)))

;; DEFINE YOUR FUNCTION(S) HERE


(defun list-leveller (liste)

	(cond
		;bi kac farkli durum oldugu icin cond kullandim.
		((listp (car liste)) (list-leveller (append (car liste) (cdr liste) )) )	;once gelen listenin ilk elemanı list mi ona baktım. 
		;ona gore recursive yaptım
		((not (cdr liste)) liste)	;
		(t (cons (car liste) (list-leveller (cdr liste))))	;ilk elemani alip geri kalan ile recursive yaptik.	 
		;( t (append (leveller (car liste)) (leveller (cdr liste))))	
	)

)

;Ahmet Yusa Telli
;151044092


;; MAIN FUNCTION
(defun main ()
  (with-open-file (stream #p"input_part1.csv")
    (loop :for line := (read-csv-line stream) :while line :collect
      (format t "~a~%"
      ;; CALL YOUR (MAIN) FUNCTION HERE

      (list-leveller (read-from-string (nth 0 line)))

      )
    )
  )
)

;; CALL MAIN FUNCTION
(main)
