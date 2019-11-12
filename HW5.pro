% Cracker Barrel Peg Puzzle Solver
% CSCE 4430 - Aaron Johnson

% This program solves the peg puzzle popularized by Cracker Barrel
% Requires installation of Lambda module
% ?-pack-install(lambda).

:-use_module(library(lambda)).

% program call:
solver:-
	solver(moveset),
	display(moveset).
	
% Build solution:
solver(moveset):-
	jump([1], [2,3,4,5,6,7,8,9,10,11,12,13,14,15], [], moveset).

solver(moveset1):-
	jump([2], [1,3,4,5,6,7,8,9,10,11,12,13,14,15], [], moveset1).

solver(moveset2):-
	jump([3], [1,2,4,5,6,7,8,9,10,11,12,13,14,15], [], moveset2).

solver(moveset3):-
	jump([4], [1,2,3,5,6,7,8,9,10,11,12,13,14,15], [], moveset3).

solver(moveset4):-
	jump([5], [1,2,3,4,6,7,8,9,10,11,12,13,14,15], [], moveset4).


%movement operation
jump(_, [_], Lst, moveset):-
	reverse(Lst, moveset).


% Free = empty space
% Occupied = Filled space
% S = Start
% O = Over (space being jumped over)
% E = End
jump(Free, Occupied, Lst, moveset):-
	select(S, Occupied, Oc1),
	select(O, Oc1, Oc2),
	select(E, Free, F1),
	move(S, O, E),
	jump([S, O | F1], [E | Oc2], [move(S,O,E) | Lst], moveset).


%List of possible legal moves forward/reverse
% (Start,Over,End)
move(S,2,E):-
	member([S,E], [[1,4], [4,1]]).
move(S,3,E):-
	member([S,E], [[1,6], [6,1]]).
move(S,4,E):-
	member([S,E], [[2,7], [7,2]]).
move(S,5,E):-
	member([S,E], [[2,9], [9,2]]).
move(S,5,E):-
	member([S,E], [[3,8], [8,3]]).
move(S,6,E):-
	member([S,E], [[3,10], [10,3]]).
move(S,5,E):-
	member([S,E], [[4,6], [6,4]]).
move(S,7,E):-
	member([S,E], [[4,11], [11,4]]).
move(S,8,E):-
	member([S,E], [[4,13], [13,4]]).
move(S,8,E):-
	member([S,E], [[5,12], [12,5]]).
move(S,9,E):-
	member([S,E], [[5,14], [14,5]]).
move(S,9,E):-
	member([S,E], [[6,13], [13,6]]).
move(S,10,E):-
	member([S,E], [[6,15], [15,6]]).
move(S,8,E):-
	member([S,E], [[9,7], [7,9]]).
move(S,9,E):-
	member([S,E], [[10,8], [8,10]]).
move(S,12,E):-
	member([S,E], [[11,13], [13,11]]).
move(S,13,E):-
	member([S,E], [[12,14], [14,12]]).
move(S,14,E):-
	member([S,E], [[15,13], [13,15]]).


% Display Solution with Xs and Os
display(solution):-
	display(solution, [1]).


display([], Free):-
	numlist(1,15, Lst),
	maplist(\X^I^member(X,Free) -> I = '0'; I = 'X'), Lst, [I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format('    ~w        ~n', [I1]),
	format('   ~w ~w      ~n', [I2,I3]),
	format('  ~w ~w ~w    ~n', [I4,I5,I6]),
	format(' ~w ~w ~w ~w  ~n', [I7,I8,I9,I10]),
	format('~w ~w ~w ~w ~w~n~n', [I11,I12,I13,I14,I15]),
	writeIn(complete).


display([move(Start, Middle, End) | Tail], Free):-
	numlist(1,15, Lst),
	maplist(\X^I^member(X,Free) -> I = '0'; I = 'X'), Lst, [I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format('    ~w        ~n', [I1]),
	format('   ~w ~w      ~n', [I2,I3]),
	format('  ~w ~w ~w    ~n', [I4,I5,I6]),
	format(' ~w ~w ~w ~w  ~n', [I7,I8,I9,I10]),
	format('~w ~w ~w ~w ~w~n~n', [I11,I12,I13,I14,I15]),
	select(End, Free, F1),
	display(Tail, [Start, Middle | F1]).