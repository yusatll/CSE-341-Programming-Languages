flight(istanbul,izmir,3).
flight(istanbul,ankara,2).
flight(istanbul,trabzon,3).

flight(ankara,diyarbakir,8).

flight(antalya,diyarbakir,5).
flight(antalya,erzurum,2).

flight(erzurum,edirne,5).

flight(izmir,ankara,6).
flight(izmir,antalya,1).

flight(trabzon,ankara,6).

flight(kars,gaziantep,3).
flight(kars,ankara,3).

route(A,B,C) :- go(A,B,C,[A]).


go(A,B,C,visit) :- connecting(A,Z,N),
		not(member(Z,visit)), 
		go(Z,B,M,[Z|visit]) , C is M + N.

go(A,B,C,visit) :- (not(member(A,visit)) 
	-> connecting(A,B,C);
	connecting(B,A,C)).


connecting(X,Y,C) :- flight(X,Y,C) ; flight(Y,X,C).

