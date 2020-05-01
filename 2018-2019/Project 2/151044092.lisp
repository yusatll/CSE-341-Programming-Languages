;Ahmet Yusa Telli
;	151044092

(defun parser (liste)

	(with-open-file (fileptr "151044092.tree"
		:direction :output :if-exists :supersede 
		:if-does-not-exist :create)
	(format fileptr "DIRECTIVE parse tree~a" #\NewLine)
	(format fileptr "~a~a~a~a~a" "START" #\NewLine #\Tab "INPUT" #\NewLine)
	(tabWrite 2 fileptr)
	(format fileptr "~a~a" "EXPI" #\NewLine)
	(new liste 1 fileptr)
	(values)
	)
)


(defun new (lexer tabs fileptr)

	(cond 
		((null lexer) lexer)
		(
			(setq temptab tabs)
			(setq fir (car (car lexer)))
			(setq sec (second (car lexer)))
			(cond
				((string= sec "(")  (setq tabs (+ tabs 1)) (tabWrite (+ temptab 1) fileptr))
				((string= sec ")")  (tabWrite temptab fileptr) (setq tabs (- tabs 1)))
				((tabWrite (+ temptab 1) fileptr))
			)

			(setq control (second (car lexer)))
			(setq contF   (first (car lexer)))
		
			(cond 
				((or (string= control "if") (string= control "while") (string= control "and") (string= control "or") (string= control "not") ) 
					(format fileptr "~a~a" control #\NewLine) (tabWrite (+ temptab 1) fileptr) (format fileptr "~a" "EXPB"))

				((or (string= control "+") (string= control "-") (string= control "*") (string= control "/") (string= control "for"))
				 (format fileptr "~a~a" control #\NewLine) (tabWrite (+ temptab 1) fileptr) (format fileptr "~a" "EXPI"))

				((or (string= control "deffun") (string= control "set") ) 
					(format fileptr "~a~a" control #\NewLine) (tabWrite (+ temptab 1) fileptr) (format fileptr "~a" "ID") )

				((and (string= contF "identifier") (setq four (second (cadr lexer)) ) (or(string= four "(" ) (string= four "'" )))   
					(format fileptr "~a~a~a" #\Tab control #\NewLine) (tabWrite (+ temptab 1) fileptr) (format fileptr "~a" "IDLIST") )

				((and(string= contf "identifier") (equal (length control) 1) )
				 (format fileptr "~a" #\NewLine) (tabWrite temptab fileptr) (format fileptr "~a~a" "IDLIST" #\NewLine) (tabWrite (+ temptab 1) fileptr) (format fileptr "~a~a" "ID" #\NewLine) 
				 																				   (tabWrite (+ temptab 2) fileptr) (format fileptr "~a" control ))
				((string= contf "integer")
				 (format fileptr "~a" #\NewLine) (tabWrite temptab fileptr) (format fileptr "~a~a" "EXPI" #\NewLine) 
				 						   (tabWrite (+ temptab 1) fileptr) (format fileptr "~a~a" "VALUES" #\NewLine)
				 						   (tabWrite (+ temptab 2) fileptr) (format fileptr "~a~a" "integerValue" #\NewLine) 
				 						   (tabWrite (+ temptab 3) fileptr) (format fileptr "~a" control ))

				( (and (string= control "equal") (string= (first (cadr lexer)) "identifier")) 
				 (format fileptr "~a~a" control #\NewLine) (tabWrite (+ temptab 1)  fileptr) (format fileptr "~a" "EXPI")
				 (format fileptr "~a" #\NewLine) (tabWrite (+ temptab 2) fileptr) (format fileptr "~a" "ID")
				 (format fileptr "~a" #\NewLine) (tabWrite (+ temptab 3) fileptr) (format fileptr "~a" (second (cadr lexer)))
				 (pop lexer)
				 )

				;( (and(string= control "(") (string= (second (cadr lexer)) "(")) 
				;	(format fileptr "~a~a" control #\NewLine) (tabWrite temptab fileptr) (format fileptr "~a" "EXPB") )

				( (or (string= control "concat") (string= control "append")  )
					(format fileptr "~a~a" control #\NewLine) (tabWrite temptab fileptr) (format fileptr "~a" "EXPLISTI") )

				(t (format fileptr "~a"  control))
			) 

			(format fileptr "~a" #\NewLine)
			(new (cdr lexer) tabs fileptr)

		)
	)
	(values)
)

(defun tabWrite (tabCount fileptr)
	(cond 
		((> tabCount 0) (format fileptr "~a" #\Tab) (tabWrite (- tabCount 1) fileptr))
	)
)
