remove(X, [X|L], L).
remove(X, [H|T], [H|L]) :- remove(X, T, L).

generate_regions([adjacent(X,Y)|As],[X,Y|Xs]) :- length(Xs,L), L=0, generate_regions(As,Xs).
generate_regions([adjacent(X,_)|As],[X|Xs]) :- \+member(X,Xs), generate_regions(As,Xs).
generate_regions([adjacent(_,Y)|As],[Y|Xs]) :- \+member(Y,Xs), generate_regions(As,Xs).

generate([],_,[]).
generate([R|Rs],C,[color(R,Y)|Zs]) :- 
	remove(Y,C,_),
	generate(Rs,C,Zs).

conflict(X,Y,C) :- member(color(X,C1),C), member(color(Y,C2),C), C1=C2.

test(_,[]).
test(C,[adjacent(X,Y)|As]) :- \+ conflict(X,Y,C), test(C,As). 
		

color_map(Map,Colors,Coloring) :- generate_regions(Map,Regions), generate(Regions,Colors,Coloring), test(Coloring,Map).

%color_map([adjacent(c,a), adjacent(c,b), adjacent(c,d), adjacent(c,e), adjacent(c,f), adjacent(e,f), adjacent(b,a), adjacent(b,e), adjacent(d,a), adjacent(d,f)], [red,green,blue,black], Coloring).
