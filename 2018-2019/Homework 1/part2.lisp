;Ahmet Yusa Telli
;151044092


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