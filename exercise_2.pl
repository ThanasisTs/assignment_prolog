% check if an element is in a list
member(X,[X|_]).
member(X,[_|Xs]) :- member(X,Xs).

% check if an element is a list
isList([]).
isList([_|_]).

% check if two lists have the same length
check_length(X,Y) :- length(X,L), length(Y,M), L=M.

% check if each element of the first list is a member of the second
check_members([],_).
check_members([X|Xs],Y) :- member(X,Y), check_members(Xs,Y).

% define the set_equal predicate
set_equal(X,Y) :- check_length(X,Y), check_members(X,Y).

% check if the list X is a member of the list Y
check_list_member(X,Y) :- isList(X), permutation(X,Z), member(Z,Y).

% check if each element of the first list is a member of the second
% in the case where a list can be an element of another list
check_members_r([],_).
check_members_r([X|Xs],Y) :- member(X,Y), check_members_r(Xs,Y).
check_members_r([X|Xs],Y) :- check_list_member(X,Y), check_members_r(Xs,Y).

% define the set_equal_r predicate
set_equal_r(X,Y) :- check_length(X,Y), check_members_r(X,Y).