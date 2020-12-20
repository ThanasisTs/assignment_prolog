% remove an element from a list
remove(X, [X|L], L).
remove(X, [H|T], [H|L]) :- remove(X, T, L).

% find the regions of the map based on the adjacent matrix
extract_region_listgenerate_regions([],[]).
extract_region_listgenerate_regions([adjacent(X,Y)|As],[X,Y|Xs]) :- generate_regions(As,Xs).
generate_regions(Map,Regions) :- extract_region_list(Map,Regions_extended), list_to_ord_set(Regions_extended,Regions).

% generate colorings
generate([],_,[]).
generate([R|Rs],C,[color(R,Y)|Zs]) :- 
	remove(Y,C,_),
	generate(Rs,C,Zs).

% check if two adjecent regions have the same color
conflict(X,Y,C) :- member(color(X,C1),C), member(color(Y,C2),C), C1=C2.

% check the generated colorings
test(_,[]).
test(C,[adjacent(X,Y)|As]) :- \+ conflict(X,Y,C), test(C,As). 
		
% define the color_map predicate
color_map(Map,Colors,Coloring) :- generate_regions(Map,Regions), generate(Regions,Colors,Coloring), test(Coloring,Map).