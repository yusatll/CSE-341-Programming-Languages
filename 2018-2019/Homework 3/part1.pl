% id, capacity, equipment
room(z06, 10, hcapped, projector).
room(z11, 10, hcapped, smartboard).

% id, instructor, capacity, hour, room
course(cse341, genc, 10, 4, z06).
course(cse343, turker, 6, 3, z11).
course(cse331, bayrakci, 5, 3, z06).
course(cse321, gozupek, 10, 4, z11).
course(cse341, genc, 10, 4, z11).

% id, course, needs
instructor(genc, cse341, projector).
instructor(turker, cse343, smartboard).
instructor(bayrakci, cse331, _).
instructor(gozupek, cse321, smartboard).

%id, courses, hcapped
student(1, [cse341, cse343, cse331], nothcapped).
student(2, [cse341, cse343], nothcapped).
student(3, [cse341, cse331], nothcapped).
student(4, [cse341], nothcapped).
student(5, [cse341, cse331], nothcapped).
student(6, [cse341, cse343, cse331], hcapped).
student(7, [cse341, cse343], nothcapped).
student(8, [cse341, cse343], hcapped).
student(9, [cse341], nothcapped).
student(10, [cse341, cse321], nothcapped).
student(11, [cse341, cse321], nothcapped).
student(12, [cse343, cse321], nothcapped).
student(13, [cse343, cse321], nothcapped).
student(14, [cse343, cse321], nothcapped).
student(15, [cse343, cse321], hcapped).



occupancy(z06, 9, cse331). %conflict icin ekstra yazdim

occupancy(z06, 9, cse341).
occupancy(z06, 10, cse341).
occupancy(z06, 11, cse341).

occupancy(z06, 13, cse331).
occupancy(z06, 14, cse331).
occupancy(z06, 15, cse331).

occupancy(z11, 8, cse343).
occupancy(z11, 9, cse343).
occupancy(z11, 10, cse343).
occupancy(z11, 11, cse343).

occupancy(z11, 14, cse321).
occupancy(z11, 15, cse321).
occupancy(z11, 16, cse321).




% Check whether there is any scheduling conflict.
% CourseID1,CourseID2
conflict(X,Y):- occupancy(C1,T1,X), occupancy(C2,T2,Y),
    (T1 == T2 , C1 == C2).



% Check which room can be assigned to a given class.
% roomid, courseid
assign(X,Y) :- (course(Y,_,_,_,R), room(X,_,_,_)),
		(R == X).


% NOT: burada _ kadirdim.Cunku oyle olunca ustteki ile
% karisiyordu.
% Check which room can be assigned to which classes.
% roomid
assign(X) :- course(R,_,_,_,X), write(R).




% Check whether a student can be enrolled to a given class.
% StudentID, courseid
enroll(X,Y) :- (student(X,R,_), course(Y,_,_,_,_)),
		write(X),
		write(' id student has these course(s): '), nl,
                write(R),nl,
		write('add this course: '), write(Y), nl,
		%write(R).
		append(R,Y,L),
		write('after enroll the student has these course(s): '),nl,
		write(L).


% Check which classes a student can be assigned.
% StudentID
enroll(X,_) :- student(X,R,_), write(X),
		write(' id student can be assigned these course(s): '),
		nl, showStudent(R).



showStudent([X|Y]) :- write(X), nl, showStudent(Y).
