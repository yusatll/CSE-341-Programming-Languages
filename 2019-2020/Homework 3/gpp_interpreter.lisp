; Programming Language Homework 3
;	Ahmet Yusa Telli
;		151044092

(load "gpp_lexer.lisp")

(defun gppinterpreter (liste)

	(with-open-file (fileptr "output.g++"
		:direction :output :if-exists :supersede 
		:if-does-not-exist :create)
	;(format fileptr "DIRECTIVE parse tree~a" #\NewLine)
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
			(setq sec  (car lexer))

			(cond
				((string= sec "OP_OP")  (setq tabs (+ tabs 1)) (tabWrite (+ temptab 1) fileptr))
				((string= sec "OP_CP")  (tabWrite temptab fileptr) (setq tabs (- tabs 1)))
				((tabWrite (+ temptab 1) fileptr))
			)

			(setq control	(car  lexer))
			(setq secCont	(cadr lexer))
		
			(cond 
				((or (string= control "KW_IF") (string= control "KW_WHILE") (string= control "KW_AND") (string= control "KW_OR") (string= control "KW_NOT") ) 
					(format fileptr "~a~a" control #\NewLine) (tabWrite (+ temptab 1) fileptr) (format fileptr "~a" "EXPB"))

				((or (string= control "OP_PLUS") (string= control "OP_MINUS") (string= control "OP_MULT") (string= control "OP_DIV") (string= control "KW_FOR"))
				 (format fileptr "~a~a" control #\NewLine) (tabWrite (+ temptab 1) fileptr) (format fileptr "~a" "EXPI"))

				((or (string= control "KW_DEFFUN") (string= control "KW_SET") ) 
					(format fileptr "~a~a" control #\NewLine) (tabWrite (+ temptab 1) fileptr) (format fileptr "~a" "ID"))

				;((and (string= contF "IDENTIFIER") (or(string= four "OP_OP" ) (string= four "'" )))
				;	(format fileptr "~a~a~a" #\Tab control #\NewLine) (tabWrite (+ temptab 1) fileptr) (format fileptr "~a" "IDLIST") )

				((string= control "IDENTIFIER") 
				 (format fileptr "~a" #\NewLine) (tabWrite temptab fileptr) (format fileptr "~a~a" "IDLIST" #\NewLine) (tabWrite (+ temptab 1) fileptr) (format fileptr "~a~a" "ID" #\NewLine) 
																		   (tabWrite (+ temptab 2) fileptr) (format fileptr "~a" control ))
				((string= control "VALUE")
				 (format fileptr "~a" #\NewLine) (tabWrite temptab fileptr) (format fileptr "~a~a" "EXPI" #\NewLine) 
											(tabWrite (+ temptab 1) fileptr) (format fileptr "~a~a" "VALUES" #\NewLine)
											(tabWrite (+ temptab 2) fileptr) (format fileptr "~a~a" "integerValue" #\NewLine) 
											(tabWrite (+ temptab 3) fileptr) (format fileptr "~a" control ))

				((and (string= control "KW_EQUAL") (string=  secCont "IDENTIFIER"))
				 (format fileptr "~a~a" control #\NewLine) (tabWrite (+ temptab 1)  fileptr) (format fileptr "~a" "EXPI")
				 (format fileptr "~a" #\NewLine) (tabWrite (+ temptab 2) fileptr) (format fileptr "~a" "ID")
				 (format fileptr "~a" #\NewLine) (tabWrite (+ temptab 3) fileptr) (format fileptr "~a" secCont)
				 (pop lexer)
				)

				((and(string= control "OP_OP") (string= secCont "OP_OP")) 
					(format fileptr "~a~a" control #\NewLine) (tabWrite temptab fileptr) (format fileptr "~a" "EXPB") )

				((or (string= control "KW_CONCAT") (string= control "KW_APPEND")  )
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

;(write (gppinterpreter "151044092.tree"))