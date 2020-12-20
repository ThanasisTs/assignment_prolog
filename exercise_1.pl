% define the plus ("+") predicate
plus(0,X,X).
plus(s(X),Y,s(Z)) :- plus(X,Y,Z).

% define the times ("*") predicate based on the plus
times(0,_,0).
times(s(X),Y,Z) :- times(X,Y,W), plus(W,Y,Z).

% define the power of a number based on the times predicate 
pow(_,0,s(0)).
pow(X,s(Y),Z) :- pow(X,Y,W), times(W,X,Z).

% define the sumpow predicate based on the pow and the plus predicates
sumpow(s(0),s(0)).
sumpow(s(X),S) :- sumpow(X,W), pow(s(X),X,Z), plus(W,Z,S).