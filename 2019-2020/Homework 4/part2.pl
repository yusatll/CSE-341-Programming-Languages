distance(istanbul,izmir,328).
distance(istanbul,ankara,351).
distance(istanbul,antalya,482).
distance(istanbul,gaziantep,847).
distance(istanbul,van,1262).
distance(istanbul,rize,967).
distance(ankara,van,920).
distance(ankara,konya,227).
distance(antalya,gaziantep,592).
distance(antalya,konya,192).
distance(edirne,edremit,251).
distance(edremit,erzincan,992).
distance(izmir,ısparta,308).
distance(ısparta,burdur,25).
distance(rize,van,373).


route(X,Y,C) :- path(X,Y,C,[]);path(Y,X,C,[]).

path(X,Y,C,V) :- distance(X,Y,C),not(X=Y).
path(X,Y,C,V) :- not(member(X,V)),distance(X,T,C1),not(T=X),path(T,Y,C2,[X|V]),not(X=Y),C is C1 + C2.