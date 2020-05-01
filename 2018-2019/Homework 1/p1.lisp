;Ahmet Yuşa Telli
;151044092

(defun list-leveller (liste)

	(cond
		((not (cdr liste)) liste)
		((listp (car liste)) (list-leveller (append (car liste) (cdr liste) )) )
		(t (cons (car liste) (list-leveller (cdr liste))))	 
		;( t (append (leveller (car liste)) (leveller (cdr liste))))	
	)

)
