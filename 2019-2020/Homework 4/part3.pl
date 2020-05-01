when(102,10).
when(108,12).
when(341,14).
when(455,16).
when(452,17).

where(102,z23).
where(108,z11).
where(341,z06).
where(455,207).
where(452,207).

enrollment(a,102).
enrollment(a,108).
enrollment(b,102).
enrollment(c,108).
enrollment(d,341).
enrollment(e,455).

schedule(S,P,T) :- 	enrollment(S,X), where(X,P),when(X,T).

usage(P,T) :-  when(X,T),where(X,P).

conflict(X,Y) :- when(X,K),when(Y,Z),K=Z ; where(X,K),where(Y,Z),K=Z.

meet(X,Y) :- enrollment(X,S1),enrollment(Y,S2),(when(S1,T), when(S2,T), where(S1,P), where(S1,P)).