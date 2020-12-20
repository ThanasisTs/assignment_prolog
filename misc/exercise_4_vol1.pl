move(M,N, Barriers, X/Y, X1/Y1) :- 
	member(L1, [-1, 0, 1]),
	member(L2, [-1, 0, 1]),
	0 is L1*L2,
	X1 is X + L1,
	Y1 is Y + L2,
	X+Y =\= X1+Y1,
	X1 < M, 0 < X1, 0 < Y1, Y1 < N,
	\+ member(X1/Y1, Barriers).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

breadthfirst(_, _, _, [Path|_], To, Path) :-
  last(Path,Goal),
  goal(Goal, To).
  
breadthfirst(M, N, Barriers, [Path|Paths], To, SolutionPath) :-
  expand_breadthfirst(M, N, Barriers, Path, ExpPaths),
  append(Paths, ExpPaths, NewPaths),
  breadthfirst(M, N, Barriers, NewPaths, To, SolutionPath).

expand_breadthfirst(M, N, Barriers, Path, ExpPaths) :- 
  findall(NewPath, expand_path(M, N, Barriers, Path, NewPath), ExpPaths).

expand_path(M, N, Barriers, Path, NewPath) :-
  last(Path, LastNode),
  move(M, N, Barriers, LastNode, NewLastNode),
  append(Path, [NewLastNode], NewPath).

goal(CurrentState, GoalState) :- 
	CurrentState = GoalState.

solve_maze(M, N, Barriers, From, To, Path) :-
  breadthfirst(M, N, Barriers, [[From]], To, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

