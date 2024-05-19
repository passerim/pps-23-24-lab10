% Ex1.1
% search(Elem, List)
search(X, cons(X, _)).
search(X, cons(_, Xs)) :- search(X, Xs).
% search(a, cons(a, cons(b, cons(c, nil)))).          -> Yes
% search(a, cons(c, cons(d, cons(e, nil)))).          -> No
% search(X, cons(a, cons(b, cons(c, nil)))).          -> Yes {X/a}, Yes {X/b}, Yes {X/c}
% search(a, X).                                       -> Yes {X/cons(a, _)}, Yes {X/cons(_, cons(a, _))}, ...
% search(a, cons(X, cons(b, cons(Y, cons(Z, nil))))). -> Yes {X/a}, Yes {X/_, Y/a}, Yes {X/_, Y/_, Z/a}
% search(X, Y).                                       -> Yes {X1/X, Y/cons(X, _)}, Yes {X1/X, Y/cons(_, cons(X, _))}, ...

% Ex1.2
% search2(Elem, List)
% looks for two consecutive occurrences of Elem
search2(X, cons(X, cons(X, _))).
search2(X, cons(_, Xs)) :- search2(X, Xs).
% search2(a, cons(c, cons(a, cons(a, cons(d, cons(a, cons(a, nil))))))). -> Yes
% search2(a, cons(c, cons(a, cons(a, cons(a, nil))))).                   -> Yes
% search2(a, cons(c, cons(a, cons(a, cons(b, nil))))).                   -> Yes
% search2(a, L).                                                         -> Yes {L/cons(a, cons(a, _))}, Yes {L/cons(_, cons(a, cons(a, _)))}, ...
% search2(a, cons(_, cons(a, cons(_, cons(a, cons(_, nil)))))).          -> Yes

% Ex1.3
% search_two(Elem, List)
% looks for two occurrences of Elem with any element in between!
search_two(X, cons(X, cons(_, cons(X, _)))).
search_two(X, cons(_, Xs)) :- search_two(X, Xs).
% search_two(a, cons(c, cons(a, cons(a, cons(b, nil))))).          -> No
% search_two(a, cons(c, cons(a, cons(d, cons(a, cons(b, nil)))))). -> Yes
% search_two(a, X).						   -> Yes {X/cons(a, cons(_, cons(a, nil)))}
% search_two(X, cons(a, cons(b, cons(a, nil)))).		   -> Yes {X/a}

% Ex1.4
% search_anytwo(Elem, List)
% looks for any Elem that occurs two times, anywhere
search_anytwo(X, cons(X, Xs)) :- search(X, Xs).
search_anytwo(X, cons(_, Xs)) :- search_anytwo(X, Xs).
% search_anytwo(a, cons(c, cons(a, cons(a, cons(b, nil))))).          -> Yes
% search_anytwo(a, cons(c, cons(a, cons(d, cons(a, cons(b, nil)))))). -> Yes

% Ex2.1
% size(List, Size)
% Size will contain the number of elements in List, written using notation zero, s(zero), s(s(zero)), ...
size(nil, zero).
size(cons(_, T), s(X)) :- size(T, X).
% size(cons(a, cons(b, cons(c, nil))), X). -> Yes {X/s(s(s(zero)))}
% size(L, s(s(s(zero)))).		   -> Yes {L/cons(_, cons(_, cons(_, nil)))}

% Sum of Peano numbers
sum(X, zero, X).
sum(X, s(Y), s(Z)) :- sum(X, Y, Z).

% Ex2.2
% sum_list(List, Sum)
sum_list(nil, zero).
sum_list(cons(H, T), X) :- sum_list(T, Y), sum(H, Y, X).
% sum_list(cons(zero, cons(s(s(zero)), cons(s(zero), nil))), X). -> Yes {X/s(s(s(zero)))}

% Ex2.3
% count(List, Element, NumOccurrences)
% it uses count(List, Element, NumOccurrencesSoFar, NumOccurrences)
count(L, E, N) :- count(L, E, zero, N).
count(nil, E, N, N).
count(cons(E, L), E, N, M) :- count(L, E, s(N), M).
count(cons(E, L), E2, N, M) :- E \= E2, count(L, E2, N, M).
% count(cons(a, cons(b, cons(c, cons(a, cons(b, nil))))), a, N).       -> //
% count(cons(a, cons(b, cons(c, cons(a, cons(b, nil))))), a, zero, N). -> //
% count(cons(b, cons(c, cons(a, cons(b, nil)))), a, s(zero), N).       -> //
% count(cons(c, cons(a, cons(b, nil))), a, s(zero), N).                -> //
% count(cons(a, cons(b, nil)), a, s(zero), N).                         -> //
% count(cons(b, nil), a, s(s(zero)), N).                               -> //
% count(nil, a, s(s(zero)), N).                                        -> Yes {N/s(s(zero))}

% Greater relation
isNumber(zero).
isNumber(s(N)) :- isNumber(N).
greater(s(N), zero) :- isNumber(N).
greater(s(N), s(M)) :- greater(N, M).

% Ex2.4
% max(List, Max)
% Max is the biggest element in List
% Suppose the list has at least one element
max(nil, TM, TM).
max(cons(H, T), H, M) :- max(T, H, M).
max(cons(H, T), TM, M) :- greater(H, TM), max(T, H, M).
max(cons(H, T), TM, M) :- greater(TM, H), max(T, TM, M).
max(cons(H, T), M) :- max(T, H, M).
% max(cons(zero, cons(s(s(zero)), cons(s(zero), nil))), X). -> Yes {X/s(s(zero))}

% Ex2.5
% minmax(List, Min, Max)
% Min is the smallest element in List
% Max is the biggest element in List
% Suppose the list has at least one element
minmax(nil, TMIN, TMIN, TMAX, TMAX).
minmax(cons(H, T), TMIN, MIN, H, MAX) :- minmax(T, TMIN, MIN, H, MAX).
minmax(cons(H, T), TMIN, MIN, TMAX, MAX) :- greater(H, TMAX), minmax(T, TMIN, MIN, H, MAX).
minmax(cons(H, T), TMIN, MIN, TMAX, MAX) :- greater(H, TMIN), greater(TMAX, H), minmax(T, TMIN, MIN, TMAX, MAX).
minmax(cons(H, T), H, MIN, TMAX, MAX) :- minmax(T, H, MIN, TMAX, MAX).
minmax(cons(H, T), TMIN, MIN, TMAX, MAX) :- greater(TMIN, H), minmax(T, H, MIN, TMAX, MAX).
minmax(cons(H, T), MIN, MAX) :- minmax(T, H, MIN, H, MAX).
% minmax(cons(zero, cons(s(s(zero)), cons(s(zero), nil))), X, Y). -> Yes {X/zero, Y/s(s(zero))}

% Ex3.1
% same(List1, List2)
% are the two lists exactly the same?
same(nil, nil).
same(cons(H, T), cons(H, T)).
% same(cons(zero, cons(s(s(zero)), cons(s(zero), nil))), cons(zero, cons(s(s(zero)), cons(s(zero), nil)))). -> Yes
% same(cons(a, cons(b, nil)), L).									    -> Yes {L/cons(a, cons(b, nil))}
% same(L, cons(a, cons(b, nil))).									    -> Yes {L/cons(a, cons(b, nil))}

% Ex3.2
% all_bigger(List1, List2)
% all elements in List1 are bigger than those in List2, 1 by 1?
all_bigger(cons(H1, nil), cons(H2, nil)) :- greater(H1, H2).
all_bigger(cons(H1, T1), cons(H2, T2)) :- greater(H1, H2), all_bigger(T1, T2).
% all_bigger(nil, nil). 							   -> No
% all_bigger(cons(s(zero), nil), nil). 						   -> No
% all_bigger(cons(s(zero), nil), cons(s(s(zero)), nil)). 			   -> No
% all_bigger(cons(s(s(zero)), cons(s(zero), nil)),cons(s(zero), cons(zero, nil))). -> Yes

% Ex3.3
% sublist(List1, List2)
% List1 should contain elements all also in List2
sublist(nil, _).
sublist(cons(H, T), L) :- search(H, L), sublist(T, L).
% sublist(cons(a, cons(b, nil)), cons(c, cons(b, cons(a, nil)))). -> Yes

% Ex4.1
% seq(N, E, List) -> List is [E, E, ..., E] with size N
seq(zero, _, nil).
seq(s(N), E, cons(E, T)) :- seq(N, E, T).
% seq(s(s(s(zero))), a, cons(a,cons(a, cons(a, nil)))). -> Yes
% seq(s(s(s(zero))), a, L).				-> Yes {L/cons(a,cons(a, cons(a, nil)))}
% seq(N, a, cons(a,cons(a, cons(a, nil)))).		-> Yes {N/s(s(s(zero)))}
% seq(s(s(s(zero))), X, cons(a,cons(a, cons(a, nil)))).	-> Yes {X/a}

% Ex4.2
% seqR(N, List) -> is [N-1, ..., 1, 0]
seqR(zero, nil).
seqR(s(N), cons(N, T)) :- seqR(N, T).
% seqR(zero, nil).                                                       -> Yes
% seqR(s(zero), cons(zero, nil)).                                        -> Yes
% seqR(s(s(zero)), cons(s(zero), cons(zero, nil))).                      -> Yes
% seqR(s(s(s(zero))), cons(s(s(zero)), cons(s(zero), cons(zero, nil)))). -> Yes

% Ex4.3
% seqR2(N, List) -> is [0, 1, ..., N-1]
last(nil, X, cons(X, nil)).
last(cons(H, nil), X, cons(H, cons(X, nil))).
last(cons(H1, T1), X, cons(H1, T2)) :- last(T1, X, T2).
seqR2(zero, nil).
seqR2(s(N), L) :-  seqR2(N, LP), last(LP, N, L).
% seqR2(zero, nil).                                                       -> Yes
% seqR2(s(zero), cons(zero, nil)).                                        -> Yes
% seqR2(s(s(zero)), cons(zero, cons(s(zero), nil))).                      -> Yes
% seqR2(s(s(s(zero))), cons(zero, cons(s(zero), cons(s(s(zero)), nil)))). -> Yes

% Ex5
% last(List, Last) -> last
% Last is the last element of List
last(cons(H, nil), H).
last(cons(_, T), E) :- last(T, E).
% last(cons(s(zero), cons(s(s(zero)), nil)), X). -> Yes {X/s(s(zero))}

% mapIncreaseOne(List, IncreasedList) -> map(_ + 1)
% Increase by one all the elements of List
mapIncreaseOne(nil, nil).
mapIncreaseOne(cons(zero, T), cons(s(zero), TM)) :- mapIncreaseOne(T, TM).
mapIncreaseOne(cons(s(N), T), cons(s(s(N)), TM)) :- mapIncreaseOne(T, TM).
% mapIncreaseOne(cons(zero, nil), cons(s(zero), nil)). 				        -> Yes {X/cons(s(zero), nil)}
% mapIncreaseOne(cons(s(zero), cons(zero, nil)), cons(s(s(zero)), cons(s(zero), nil))). -> Yes

% filterPositive(List, FilteredList) -> filter(_ > 0)
% Filter List keeping only its elements greater than zero
filterPositive(nil, nil).
filterPositive(cons(zero, T), F) :- filterPositive(T, F).
filterPositive(cons(s(N), T), cons(s(N), F)) :- filterPositive(T, F).
% filterPositive(cons(zero, nil), X). 		     -> Yes {X/nil}
% filterPositive(cons(s(zero), nil), X). 	     -> Yes {X/cons(s(zero), nil)}
% filterPositive(cons(s(zero), cons(zero, nil)), X). -> Yes {X/cons(s(zero), nil)}

% countPositive(List, C) -> count(_ > 0)
% Count elements of List greater than zero
countPositive(nil, zero).
countPositive(cons(zero, T), C) :- countPositive(T, C).
countPositive(cons(s(N), T), s(C)) :- countPositive(T, C).
% countPositive(cons(zero, nil), zero). 				       -> Yes
% countPositive(cons(s(s(zero)), cons(zero, cons(s(zero), nil))), s(s(zero))). -> Yes

% findPositive(List, E) -> find(_ > 0)
% Find the first element of List that is greater than zero
findPositive(cons(s(N), _), s(N)).
findPositive(cons(zero, T), E) :- findPositive(T, E).
% findPositive(cons(s(zero), nil), s(zero)).				   -> Yes
% findPositive(cons(zero, cons(s(zero), cons(s(s(zero)), nil))), s(zero)). -> Yes

% dropRightTwo(List, DroppedList) -> drop(2)
% Drop last two elements from List
dropRight(L, D) :- last(D, E, L), last(L, E).
dropRightTwo(L, D2) :- dropRight(L, D1), dropRight(D1, D2).
% dropRightTwo(cons(a, nil), X). 			    -> No
% dropRightTwo(cons(a, cons(b, cons(c, cons(d, nil)))), X). -> Yes {X/cons(a, cons(b, nil))}

% dropWhilePositive(List, DroppedList) -> dropwhile(_ > 0)
% Drop elements from List until a zero element is found
dropWhilePositive(nil, nil).
dropWhilePositive(cons(zero, T), cons(zero, T)).
dropWhilePositive(cons(s(N), T), L) :- dropWhilePositive(T, L).
% dropWhilePositive(cons(s(s(zero)), cons(s(zero), cons(zero, nil))), cons(zero, nil)). -> Yes

% partitionPositive(List, Partition1, Partition2) -> partition(_ > 0)
% Partition List into Partition1 containing only elements greater than zero and Partition2 containing only elements equal to zero
partitionPositive(nil, nil, nil).
partitionPositive(cons(zero, T), P1, cons(zero, P2)) :- partitionPositive(T, P1, P2).
partitionPositive(cons(s(N), T), cons(s(N), P1), P2) :- partitionPositive(T, P1, P2).
% partitionPositive(cons(zero, nil), X, Y).						 -> Yes {X/nil, Y/cons(zero, nil)}
% partitionPositive(cons(zero, cons(s(s(zero)), cons(s(zero), cons(zero, nil)))), X, Y). -> Yes {X/cons(s(s(zero)), cons(s(zero), nil)), Y/cons(zero, cons(zero, nil))}

% reversed(List, Reversed) -> reversed
% Reverse a List
reversed(nil, nil).
reversed(cons(H, T), R) :- reversed(T, RT), last(RT, H, R).
% reversed(cons(a, cons(b, cons(c, nil))), X). -> Yes {X/cons(c, cons(b, cons(a, nil)))}

% DropTwo(List, DroppedList) -> drop(2)
% Drop the first two elements from List
dropTwo(cons(_, cons(_, T)), T).
% dropTwo(cons(a, nil), X). 	     	      -> No
% dropTwo(cons(a, cons(b, cons(c, nil))), X). -> Yes {X/cons(c, nil)}

% takeTwo(List, ListOfTwo) -> take(2)
% Take the first two elements of List
takeTwo(cons(A, cons(B, _)), cons(A, cons(B, nil))).
% takeTwo(cons(a, nil), X). 	     	      -> No
% takeTwo(cons(a, cons(b, cons(c, nil))), X). -> Yes {X/cons(a, cons(b, nil))}

% zip(List1, List2, ZippedLists) -> zip(l2)
% Zip List1 and List2 as a new list ZippedLists
zip(nil, _, nil).
zip(_, nil, nil).
zip(cons(H1, T1), cons(H2, T2), cons((H1, H2), T)) :- zip(T1, T2, T).
% zip(cons(a, cons(b, nil)), nil, nil).				 -> Yes
% zip(cons(a, cons(b, nil)), cons(zero, cons(s(zero), nil)), X). -> Yes {X/cons((a, zero), cons((b, s(zero)), nil))}
