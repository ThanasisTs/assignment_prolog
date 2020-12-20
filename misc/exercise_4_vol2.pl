move(X/Y, X1/Y, Barriers) :-
	X1 is X + 1,
	\+ member(X1/Y, Barriers).

move(X/Y, X1/Y, Barriers) :-
	X1 is X - 1,
	\+ member(X1/Y, Barriers).

move(X/Y, X/Y1, Barriers) :-
	Y1 is Y + 1,
	\+ member(X/Y1, Barriers).

move(X/Y, X/Y1, Barriers) :-
	Y1 is Y - 1,
	\+ member(X/Y1, Barriers).

goal(CurrentNode, GoalNode) :- CurrentNode = GoalNode.


move_cyclefree(Visited, Node, NextNode, Barrier) :-
  move(Node, NextNode, Barrier),
  \+ member(NextNode, Visited).


depthfirst_bound(_, _, Node, To, [Node], _) :-
  goal(Node, To).

depthfirst_bound(Barrier, Visited, Node, To, [NextNode|Path], Bound) :-
  Bound > 0,
  move_cyclefree(Visited, Node, NextNode, Barrier),
  NewBound is Bound - 1,
  depthfirst_bound(Barrier, [NextNode|Visited], NextNode, To, Path, NewBound).


solve_maze(Barrier, From, To, Path, Bound) :-
  depthfirst_bound(Barrier, [From], From, To, Path, Bound).