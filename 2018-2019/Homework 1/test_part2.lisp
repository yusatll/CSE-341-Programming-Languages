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


(defun merge-lists (liste1 liste2)

	(setq liste1 (reverse (cons (car liste2) (reverse liste1))) ) 		;append fonk kullanamadigimiz icin cons kullandim.
	;ama cons da soyle bi sikinti var. ilk listenin yanina ekliyor. yeni bir list olusturuyor. nested bir list donduruyor. ondan sikinti oldu.
	;bu nedenle once ilk list i ters cevirip digerinin ilk elemanini en sonuna ekliyorum yeni basina. sonra tekrar ters cevirince icindeki onceden ters 
	;cevirdigim list donuyor. boylece ikisi tek list olmus oluyor.  
	
	(if (> (length liste2) 1)
		
		;ikinci list i uzunlugu 1 olana kadar yani son elemana kadar onceki list e ekliyoruz.
		(merge-lists liste1 (cdr liste2) )	
		liste1		;en son ilk list i return ediyoruz. 
	)
)

;Ahmet Yusa Telli
;151044092


;; MAIN FUNCTION
(defun main ()
  (with-open-file (stream #p"input_part2.csv")
    (loop :for line := (read-csv-line stream) :while line :collect
      (format t "~a~%"
      ;; CALL YOUR (MAIN) FUNCTION HERE

      (merge-lists (read-from-string (nth 0 line)) (read-from-string (nth 1 line)))

      )
    )
  )
)

;; CALL MAIN FUNCTION
(main)
