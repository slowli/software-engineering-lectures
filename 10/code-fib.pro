% \ Вычисление чисел Фибоначчи.
% \ $\mathrm{fib}(n, X) \Leftrightarrow X = F_n$.
fib(N, X) :-
	fibr(0, 1, N, X).

fibr(A, _, 0, X) :- X is A.
fibr(_, B, 1, X) :- X is B.
fibr(A, B, N, X) :- 
	N_1 is N - 1,
	Sum is A + B,
	fibr(B, Sum, N_1, X).
