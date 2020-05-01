; Programming Language Homework 2
;	Ahmet Yusa Telli
;		151044092


(defun read-file (filename)
	(concatenate 'string (with-open-file (stream filename)
		(loop for line = (read-char stream nil)
			while line
			collect line))
	)
)


(defun is-Keyword (key) 
	(setf keyWords (list "and" "or" "not" "less" "nil" "list" 
						"equal" "append" "concat" "load"
						"set" "deffun" "for" "disp" "true" "false"
						"if" "exit"))

	(reduce #'(lambda (x y) (or x (equal key y))) keyWords :initial-value nil)
)


(defun is-operator (op) 
	(setf operatorList (list "**" "+" "-" "/"
							"(" "*" ")"
							 ))

	(reduce #'(lambda (x y) (or x (equal op y))) operatorList :initial-value nil)
)


(defun is-identifier (idents)

	(setq letters "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPRSTUVWXYZQ")
	(setq result  t)

	(if (< 0 (length idents))
		(loop for c across idents do
			(if (not (position c letters))
				(setq result nil)
			)
		)
		(setq result nil)
	)
	result
)


(defun is-integer (integ)

	(setq letters "0123456789-.")
	(setq result t)

	(if (< 0 (length integ))
		(loop for c across integ do
			(if (not (position c letters))
				(setq result nil)
			)
		)
		(setq result nil)
	)
	result
)

(defun DFA (ff)
	
	(cond
		;((equal ";;" ff) "COMMENT") 	; !!!!!!!!!!!!!!!!!!!! commenten sonraki yeri alma
		((equal "**" ff) "OP_DBLMULT")
		((equal "-" ff)  "OP_MINUS")
		((equal "+" ff)  "OP_PLUS")
		((equal "*" ff)  "OP_MULT")
		((equal "/" ff)  "OP_DIV")
		((equal "(" ff)  "OP_OP")
		((equal ")" ff)  "OP_CP")
		((equal "," ff)  "OP_COMMA")
		((equal "\"" ff) "OP_OC") 		; " " işaretinide al. ama ikisini beraber alıcaz.

		((is-Keyword ff)  (concatenate 'string "KW_" (string-upcase ff)) ) ;+
		((is-identifier ff)  "IDENTIFIER") ;+
		((is-integer ff)  "VALUE" ) ;+
		;((not (is-identifier ff)) "SYNTAX_ERROR") 		; SYNTAX_ERROR liste cannot be tokenized
		(t nil)
	)
)

(defun lexer (fileName)
	(setq buffer "")
	(setq tokens nil)
	(setf codes (read-file fileName))
	(setq command "")
	(setq com1 nil)
	(setq com2 nil)

	(loop for c across codes do
		(cond ((or (equal com1 T)(char= #\; c ))
			
				(setq com1 T) ; ilk ; bulduk
				(cond  ((or (equal com2 T)(char= #\; c )) 
					
						(setq com2 T) ; ikinci ;; bulduk
						(cond ((not(char= c #\Newline)) ; satır sonuna kadar al. 
							(setq command (concatenate 'string command (string c))))
							(t (setq com1 nil)(setq com2 nil)
							(setq tokens (append tokens '("COMMENT")))) ;else
						)
					)
				)
			)
		)

		(if (and (is-operator (string c)) (not(equal com1 T)))
				(cond ((DFA buffer)
					(setq tokens (append tokens (list (DFA buffer)))) 
					(setq buffer "")))
		)

		(if (and (not (or (char= c #\Space) (char= c #\Newline) (char= c #\Tab)))(not(equal com1 T)))
			(setq buffer (concatenate 'string buffer (string c)))
		)



		(if (and (or (is-operator (string c)) (char= c #\Space) (char= c #\Newline) (char= c #\Tab)) (not(equal com1 T)))
			(cond ((DFA buffer)
				(setq tokens (append tokens (list (DFA buffer))))
				(setq buffer ""))
			)
		)	
	)

	(if (< 0 (length buffer))
		(cond ((DFA buffer)
			(setq tokens (append tokens (list (DFA buffer)))))
		)
	)

	tokens

)

;(mapcar 'write-line (lexer  "input.g++"))