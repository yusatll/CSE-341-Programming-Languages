element(E,S) :- member(E,S).


union([],[],[]).
union([],S2,S2).
union(S1,[],S1).	
union([H|T],S2,[H|S3]) :- \+member(H,S2) ,union(T,S2,S3). 
union([H|T],S2,S3) :- member(H,S2),union(T,S2,S3).



intersect([],[],[]).
intersect([],_,[]).
intersect(_,[],[]).
intersect([H|T],S2,[H|S3]) :- member(H , S2), intersect(T,S2,S3),!.
intersect([H|T],S2,S3) :- \+member(H , S2), intersect(T,S2,S3).


equivalent(S1,S2) :- sort(S1, SS1), sort(S2,SS2), SS1 == SS2.