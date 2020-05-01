flight(istanbul,izmir).
flight(istanbul,ankara).
flight(istanbul,antalya).
flight(istanbul,gaziantep).
flight(istanbul,van).
flight(istanbul,rize).
flight(ankara,van).
flight(ankara,konya).
flight(antalya,gaziantep).
flight(antalya,konya).
flight(edremit,edirne).
flight(edremit,erzincan).
flight(izmir,ısparta).
flight(ısparta,burdur).
flight(rize,van).


route(X,Y) :- flight(X,Y);route(Y,X).
