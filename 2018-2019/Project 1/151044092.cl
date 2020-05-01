; Programming Language Project 1
;	Ahmet Yusa Telli
;		151044092


(defun read-file (filename)
	(concatenate 'string (with-open-file (stream filename)
		(loop for line = (read-char stream nil)
			while line
			collect line))
	)
)
;(write (read-file "yusa.coffee"))

(defun is-Keyword (key) 
	(setf keyWords (list "and" "or" "not"
						"equal" "append" "concat"
						"set" "deffun" "for"
						"while" "if" "exit"))

	(reduce #'(lambda (x y) (or x (equal key y))) keyWords :initial-value nil)
)

(defun is-binary (bin)
	(setq binaryVals (list "true" "false"))

	(reduce #'(lambda (x y) (or x (equal bin y))) binaryVals :initial-value nil)
)

(defun is-operator (op) 
	(setf operatorList (list "+" "-" "/"
							"(" "*" ")"
							"**" ))

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

	(setq letters "0123456789-")
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

(defun foor (ff)
	(cond
		((is-binary ff)  (list "binaryValue" (string ff)))
		((is-Keyword ff)  (list "keyword" (string ff)))
		((is-identifier ff)  (list "identifier" (string ff)))
		((is-integer ff)  (list "integer" (string ff)))
		((is-operator ff)  (list "operator" (string ff)))
		((equal "-" ff)  (list "operator" (string ff)))
		((equal "+" ff)  (list "operator" (string ff)))
		((equal "*" ff)  (list "operator" (string ff)))
		((equal "**" ff)  (list "operator" (string ff)))
		((equal "/" ff)  (list "operator" (string ff)))
		(t nil)
	)
)

(defun lexer (fileName)

	(setq buffer "")
	(setq tokens nil)
	(setf codes (read-file fileName))

	(loop for c across codes do

		(if (is-operator (string c))
				(cond ((foor buffer)
					(setq tokens (append tokens (list (foor buffer))))
					(setq buffer "")))
		)

		(if (not (or (char= c #\Space) (char= c #\Newline) (char= c #\Tab)))
			(setq buffer (concatenate 'string buffer (string c)))
		)

		(if (or (is-operator (string c)) (char= c #\Space) (char= c #\Newline) (char= c #\Tab))
			(cond ((foor buffer)
				(setq tokens (append tokens (list (foor buffer))))
				(setq buffer ""))
			)
		)

		
	)

	(if (< 0 (length buffer))
		(cond ((foor buffer)
			(setq tokens (append tokens (list (foor buffer)))))
		)
	)

	tokens

)

;(write (lexer (read-file "yusa.coffee")))