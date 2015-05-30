def fib(n):
	""" $Вычисляет \(n\)-е число Фибоначчи (с отсчетом от нуля).$ """
	if (n == 0):
		return 0;
	a, b = 0, 1;
	for i in range(1, n):
		a, b = b, a + b;
	return b;
