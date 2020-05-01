;Ahmet Yuşa Telli
;151044092


(defun insert-n (liste value index)

	(if (> index 0)
		(append (list (car liste)) (insert-n (cdr liste) value (- index 1) ) )

		(push value liste)
	)
		
)

