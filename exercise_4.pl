% a state is safe, meaning that the agent can get to this state
% if its coordinates are within the limits of the maze
% and no obstacle is in this state
safe_state(M, N, Barrier, X/Y) :-
	0 < X, X < M, 0 < Y, Y < N,
	\+ member(X/Y, Barrier).

% generate a possible next state and move there
% if the state is safe
move(M,N, Barrier, X/Y, X1/Y1) :- 
	member(L1, [-1, 0, 1]),
	member(L2, [-1, 0, 1]),
	0 is L1*L2,
	X1 is X + L1,
	Y1 is Y + L2,
	X+Y =\= X1+Y1,
	safe_state(M, N, Barrier, X1/Y1).

% iterative deepening algorithm
move_cyclefree(M, N, Barrier, Visited, State, NextState) :-
  move(M, N, Barrier, State, NextState),
  \+ member(NextState, Visited).

path(_, _, _, State, State, [State]).
path(M, N, Barrier, State, LastState, Path) :-
  path(M, N, Barrier, State, PenultimateState, PenultimatePath),
  move_cyclefree(M, N, Barrier, PenultimatePath, PenultimateState, LastState),
  append(PenultimatePath, [LastState], Path).

goal(Path, GoalState) :-
	last(Path, LastState),
	LastState = GoalState.

% define the solve_maze predicate
solve_maze(M, N, Barrier, From, To, Path) :-
  path(M, N, Barrier, From, To, Path),
  goal(Path, To).