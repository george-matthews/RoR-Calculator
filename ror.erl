-module(ror).
-import(lists,[nth/2]).
-import(rand,[uniform/1]).
-export([most/2, cost/2, total/2, generate/3]).

%Returns how many units can be brought along with X point cost
most(menatarms,X)->most(16,120,X);
most(peasantarchers,X)->most(16,200,X);
most(knightsoftherealm,X)->most(8,220,X).
%X=minimum size, Y=unit cost.
most(X, Y, Z)-> trunc(Z / cost(X, Y, 1)).
	
	
%Returns the cost of X many of that unit
cost(menatarms,X)->cost(16,120,X);
cost(peasantarchers,X)->cost(16,200,X);
cost(knightsoftherealm,X)->cost(8,220,X).
%X=minimum size, Y=unit cost.
cost(_,_,0)-> 0;
cost(X, Y, Z) -> (Y/X) + cost(X, Y, Z-1).

%Returns the total cost of units in List X, starting with unit Y.
total(X, Y) when Y =< length(X)->
	cost(nth(1, nth(Y, X)), nth(2, nth(Y, X))) + total(X, Y+1);
total(_,_)->
	0.

%Returns a randomly generated army from the units listed in list X, according to Y points, starting at unit Z, prioritised left to right (Units on far left are always added). Returns a list of units alongside remaining points.
%Add feature that allocates remaining points across units if some points remain.
generate(X, Y, Z) when Z =< length(X) andalso Y > 25->
	A = nth(Z,X),
	B = uniform(most(A, Y)),
	C =[A, B],
	C ++ generate(X,Y-cost(A,B),Z+1);
generate(_,Y,_)->
	Y.

%Find a way to unify profiles for max and cost, so you dont type every unit twice.
%6 Men at Arms, 2 Knights of the Realm = 100 points
%6 Men at Arms, 1 Knight of the realm, 2 Peasant archers = 98 points. 