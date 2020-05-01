; *********************************************
; *  341 Programming Languages                *
; *  Fall 2019                                *
; *  Author: Ahmet Yusa Telli 				  *
; *    151044092 			                  *
; *********************************************
; NOT: HOCAM BURAYA KADAR GELEBİLDİM. Bİ YERDE HATA VERİYOR AMA BULAMADIM. 
; YAKLAŞTIM DECODE ETMEYE. AMA 26! E GÖRE YAPMADIM. SADECE PDF DEKİ CİPHER A GÖRE YAPTIM.
; ONA GÖRE DEĞERLENDİRİRSENİZ SEVİNİRİM.
; AHMET YUŞA TELLİ
; 151044092


;; utility functions 
(load "include.lisp") ;; "c2i and "i2c"


(defun read-as-list (filename)
	; Reads a file containing one word per line and returns a list of words (each word is in turn a list of characters)."
	(let ((in (open filename :if-does-not-exist nil)) 
		(paragraph '())(paragraphList '()) (word '()) (test '(#\Newline)))
		(when in
			(loop for word = (read in nil)
				while word do 
					
					(setf temp nil)
					(with-input-from-string (is (string word))
						(do ((c (read-char is) (read-char is nil 'the-end)))
							((not (characterp c)))
							(push (char-downcase c) temp)
							(print c)
						)
					)
					(setf word temp)
					(setf word (reverse word))
					(print word)
					(if (not (alpha-char-p (car word)))
						(progn
							(print word)
							(print (last paragraph))
							(push  word (cdr (last paragraph)))
							(setf word '())	
						)
						(progn
							;(print "ELSE KISMI")
							;(print paragraph)
							(push (cdr paragraph) (cdr (last paragraphList)))
							;(print paragraphList)
							(setf paragraph '())
						)
					)	
			)
			(close in)
		)
		;(print (cdr paragraphList))
		(cdr paragraphList) ; return
	)
	; Implement this function...
)




(defun readfile (filename)
	;(print "readfile")
	(let ((in (open filename :if-does-not-exist nil)) 
		(paragraph '())(paragraphList '()) (word '()) (newline #\Newline)  (space #\Space) )
		(when in	
			(loop for charact =(read-char in nil) 
				while (not (equal charact nil)) do
				(if (not (or (and (not nil) (not newline)) (alpha-char-p charact)))
					(progn
						(setf paragraphList (push (reverse word) paragraphList))
						(setf word '())
					)
					(progn
						(setf word (push charact word))
					)
				)
			)
		)
		(setf paragraphList (reverse (push (reverse word) paragraphList)))
		paragraphList
	)
)

;; -----------------------------------------------------
;; HELPERS
;; *** PLACE YOUR HELPER FUNCTIONS BELOW ***
; spell-checker-0
(defun spell-checker-0 (word)
	;you should implement this function
	; tek tek dict içinde gez. kelime var mı kontrol et.
	(setf empty_list '(- - - - - - - - - - - - - - - - - - - - - - - - - -) )
	(if (null word)
		t
		(progn
			(let* ((index (convert1 (car word))) (letter (nth index empty_list)))
				(if (not (equal '- letter))
					(spell-checker-0 (cdr word))
					nil
				)
			)
		)
	)
)

; convert_encode_to_decode_word
(defun spell-checker-1 (word)
	;you should implement this function
	(loop for i from 0 to (- (list-length word) 1)
		collect(nth (convert1 (nth i word)) '(- - - - - - - - - - - - - - - - - - - - - - - - - -))
	)
)


;; -----------------------------------------------------
;; DECODE FUNCTIONS
; Gen-Decoder-A
(defun Gen-Decoder-A (encoded_document)
	;you should implement this function
	(setf dictionary (dict_data "dictionary1.txt"))
	(if (null encoded_document)
		(return-from Gen-Decoder-A(list))
	)
	(progn
		(let ((encoded_sentence (car encoded_document)))
			(if (spell-checker-0 encoded_sentence)
				;(print "Gen-Decoder-A")
				(progn
					(let ((clean_sentence (convert_encode_to_decode_word encoded_sentence)))
						;(print "clean_sentence")
						(if (read_dict clean_sentence "dictionary1.txt")
							(progn
								;(print "clean_sentence")
								;(print clean_sentence)
								(Gen-Decoder-A (cdr encoded_document))
							)
							(progn
								;(print"encoded_sentence to fix_decode")
								;(print encoded_sentence)
								(fix_decode encoded_sentence)
								(Gen-Decoder-A encoded_document)
							)
						)
					)

				)
				(progn
					(let* (( in (car (take_word_dict encoded_sentence 0))) (clean_sentence (nth in dictionary )))
						;(print in)
						(if (null (available encoded_sentence clean_sentence))
							(progn
								;(print "mapping")
								(mapping encoded_sentence clean_sentence)
								(Gen-Decoder-A (cdr encoded_document))
							)
							(progn
								;(print "not mapping")
								(loop for i from (+ in 1) to (- (list-length (dict_data "dictionary1.txt")) 2) do
									(if (null (available encoded_sentence (take_word_dict encoded_sentence i)))
										(progn
											(mapping encoded_sentence clean_sentence)
											(Gen-Decoder-A (cdr encoded_document))
										)
										(progn
											(fix_decode encoded_sentence)
											(Gen-Decoder-A encoded_document)))))
						)
					)
				)
			)
		)
	)
)

(defun Gen-Decoder-B-0 (paragraph)
	;you should implement this function
)

(defun Gen-Decoder-B-1 (paragraph)
	;you should implement this function
)

; spell-checker-0
(defun Code-Breaker (document decoder)	
	
)

;; -----------------------------------------------------
;; Test code...

(defun test_on_test_data ()
	(print "....................................................")
	(print "Testing ....")
	(print "....................................................")
	(terpri)
)

;(setq cipher_Alphabet '(d e f p q a b k l c r s t g y z h i j m n o u v w x))


(defun convert_word_from_clean_to_encode (clean_word cipher)
	;(print clean_word)
	;(setf cipher_Alphabet '(d e f p q a b k l c r s t g y z h i j m n o u v w x))
	(loop for i from 0 to (- (list-length clean_word) 1) 
		collect(nth (c2i (nth i clean_word)) cipher)
		)
)



(defun convert_list_from_clean_to_encode (clean_list cipher)
	;(print (list-length clean_list))
	(setf cipher_Alphabet '(d e f p q a b k l c r s t g y z h i j m n o u v w x))
	(loop for i from 0 to (- (list-length clean_list) 1) 
		collect(convert_word_from_clean_to_encode (nth i clean_list) cipher)
		;(print (nth i clean_list))
	)
)


(defun convert_paragraph_from_clean_to_encode (clean_paragh)
	;(print (list-length clean_paragh))
	;(setf cipher_Alphabet '(d e f p q a b k l c r s t g y z h i j m n o u v w x))
	(setf cipher_Alphabet '(a b c d e f g h i j k l m n o p q r s t u v w x y z))
	(loop for i from 0 to (- (list-length clean_paragh) 1) 
		collect (convert_list_from_clean_to_encode (nth i clean_paragh) cipher_Alphabet)
	)
)


(defun convert_encode_to_decode_word (w)
	;(print "convert_encode_to_decode_word")
	(loop for i from 0 to (- (list-length w) 1)
		collect(nth (convert1 (nth i w)) '(- - - - - - - - - - - - - - - - - - - - - - - - - -))
	)
)

(defun is_in_dictionary (word dictionary)
	;(print "in dictionary1")
	;(print dictionary)
	;(print (cadr dictionary))
	(if (equal (cadr dictionary) word)
		t
		(is_in_dictionary word (cdr dictionary))
		;(print(cdr dictionary))
	)

)
	
(defun dict_data (filename)
	(let ((dict (readfile filename)))
		dict
	)
)

(defun read_dict (w filename)
	;(print "read_dict")
	;(print w)
	(let ((dict (readfile filename)))
		;(print dict)
		(is_in_dictionary w dict)
	)

)

(defun convert1 (x)
	(cond
		((eq x 'A) 0)
		((eq x 'B) 1)
		((eq x 'C) 2)
		((eq x 'D) 3)
		((eq x 'E) 4)
		((eq x 'F) 5)
		((eq x 'G) 6)
		((eq x 'H) 7)
		((eq x 'I) 8)
		((eq x 'J) 9)
		((eq x 'K) 10)
		((eq x 'L) 11)
		((eq x 'M) 12)
		((eq x 'N) 13)
		((eq x 'O) 14)
		((eq x 'P) 15)
		((eq x 'Q) 16)
		((eq x 'R) 17)
		((eq x 'S) 18)
		((eq x 'T) 19)
		((eq x 'U) 20)
		((eq x 'V) 21)
		((eq x 'W) 22)
		((eq x 'X) 23)
		((eq x 'Y) 24)
		((eq x 'Z) 25))
)

(defun fix_decode (w)
	;(print "fix_decode")
	(loop for i from 0 to (- (list-length w) 1) do
		(if (not (equal '- (nth (convert1 (nth i w)) '(- - - - - - - - - - - - - - - - - - - - - - - - - -) )))
			(setf (nth (convert1 (nth i w)) '(- - - - - - - - - - - - - - - - - - - - - - - - - -) ) '-)
		)
	)
)


(defun take_word_dict (w a)
	;(print "take_word_dict")
	;(print (dict_data "dictionary1.txt"))
	(setf dict (dict_data "dictionary1.txt"))
	(loop for i from a to (list-length dict) do
		(if (equal (list-length (nth i dict)) (list-length w))
			;(if (equal (same_pos (nth i dict)) (same_pos word))
				(return-from take_word_dict (list i))
			;)
		)
	)
)

#||
(defun same_pos (w)
	;(print "same_pos")
	;(print w)
	(loop for i from 0 to (list-length w)do
		(loop for j from (+ i 1) to (list-length w)do
			(if (equal (nth i w) (nth j w))
				collect (list i j)
			)
		)
	)
)
||#
(defun available (encoded clean)
	;(print "available")
	(loop for i from 0 to (- (list-length encoded) 1) do
		(let* ((in (convert1 (nth i encoded))) (letter (nth in '(- - - - - - - - - - - - - - - - - - - - - - - - - -))))
			(if (not (equal '- letter ))
				(if (not (eq letter (nth i clean)))
					(return-from check_is_avaible(list '*)))
			)
		)
	)
)


(defun mapping (encoded clean)
	;(print "map")
	;(print encoded)
	;(print clean)
	(loop for i from 0 to (- (list-length encoded) 1) do
		(setf (nth (convert1 (nth i encoded)) '(- - - - - - - - - - - - - - - - - - - - - - - - - -)) (nth i clean))	
	)
)

;---------------------------------------------------------------------------------------
; TEST CODE
; test icin bu cipher alphabet e göre test ettim.
(setf cipher_Alphabet '(d e f p q a b k l c r s t g y z h i j m n o u v w x))

(setf readed (readfile "document1.txt")) ; dosyadan okundu
(print readed)
; sifrelenmis liste
(setf encoded (convert_list_from_clean_to_encode readed cipher_Alphabet))
(print encoded) ; okunan paragraf şifrelendi.
(Gen-Decoder-A encoded)

