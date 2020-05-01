merhaba hocam, ödevimi açıklamak istiyorum,

part1
yacc kısmında girilen kodun ne olduklarını ekrana basıyorum. mesela (+ 10 5) girerseniz 
OP_OP
OP_PLUS
 VALUE
 VALUE
OP_CP
gibi bir sonuç ekrana basıyorum. sonuç kısmını yapamadım henüz.
burda herhangi bir fonksiyonda girseniz bu şekilde bir çıktı verecektir.
yacc çalıştırmak için önceki ödevdeki "gpp_lexer.l" dosyasını aynen kullanıyorum. ve "gpp_interpreter.y" dosyasını ekledim. çalıştırmak için terminale:

lex gpp_lexer.l
yacc -d gpp_interpreter.y
cc lex.yy.c y.tab.c -ll
./a.out

yazmanız gerekiyor.

PART1 i sonradan değiştirdim ama olmadı. hiç birşey çalışmadı. GÖNDEREMİYORUM part1'i.
.l dosyasını gönderiyorum sadece ona bakabilirsiniz isterseniz.

part2:
parser kısmında file dan kodu okuyorum ve yine file a yazıyorum. çalıştırma şekli şöyle:
terminalde "clisp" yazdıktan sonra (load "gpp_interpreter.lisp") yazmanız gerekiyor. ve sonra önceki ödevdeki lexer ın output'unu buradaki "gppinterpreter" fonksiyonuna göndermeniz gerekiyor.
ben önceki ödevde yaptığım gpp_lexer.lisp dosyasını gönderiyorum (fonksiyon isimleri aynı olduğu için önceki ödevdeki fonksiyonun ismini lexer olarak değiştirdim.). 
(gppinterpreter (lexer "input.g++")) olarak çalıştırabilirsiniz. veya 
(gppinterpreter '("OP_OP" "KW_EQUAL" "IDENTIFIER" "VALUE" "OP_CP")) olarak da çalıştırabilirsiniz. parse tree oluşturuyorum. sonucunu "output.g++" dosyasına yazıyorum. output.g++ dosyasında şöyle bir sonuç bastırıyorum:
START
	INPUT
		EXPI
		OP_OP
			KW_EQUAL
			EXPI
				ID
					IDENTIFIER
			
		EXPI
			VALUES
				integerValue
					VALUE
		OP_CP


