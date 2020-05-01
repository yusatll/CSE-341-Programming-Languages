Ahmet Yuşa Telli
151044092

Part1:
Flex kodunda error'lardan sadece "sayının 0 ile başlamaması gerekiyor" kısmını yaptım. diğer pdf deki örnek olan "liste" error'unu yapamadım. diğer işlemler çalışıyor. identifier, keyword bulma, comment bulma kısımları çalışıyor.
sıfır ile başlayan errorda o sayıya kadar gelip sonra programdan çıkacak şekilde ayarladım. yani baştan başlayıp giderken 0 ile başlayan sayı görünce diğerlerini hiç yapmayacak. pdf deki örnekte önce OP_OP yazmış sonra hata mesajı vermiş. ona göre yaptım. önceki kısımları basıyor sonrakileri basmıyor.
örnek olarak kullandığım 2 tane input dosyasını gönderiyorum. 
part1 i çalıştırırken kodun alt tarafında main fonksiyonunda fopen yapılan yere input dosyasının ismi girilmelidir.


çalıştırırken:
$ lex gpp_lexer.l
$ gcc lex.yy.c
$ ./a.out


Part2:
aynı şekilde burda da syntax erroru yapamadım. ama diğer işlemler çalışıyor. sadece error kısımları yok. "sayı sıfırdan başlaması gereken" ve "syntax error" kısımları yok. diğer comment keyword identifier bulma kısımları çalışıyor. burda da aynı 2 input dosyasını kullandım. 
part2 yi çalıştırmak için kod içinde son satırda mapcar kısmına filename girilmesi gerekiyor.

çalıştırırken:
$ clisp gpp_lexer.lisp
