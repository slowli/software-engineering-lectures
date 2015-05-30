/**
 * $Вычисляет отношение двух действительных чисел.$
 * $В отличие от операции деления \textbf{<code>}/\textbf{</code>}, если знаменатель отношения равен нулю,$
 * $возбуждается исключительная ситуация.$
 *
 * $\textbf{@param} x$
 *    $числитель$
 * $\textbf{@param} y$
 *    $знаменатель$
 *
 * $\textbf{@return}$
 *    $результат операции деления$
 *
 * $\textbf{@throws} ArithmeticException$
 *    $если знаменатель равен нулю$
 */
public static double div(double x, double y) {
	if (y == 0.0) throw new ArithmeticException("Division by zero");
	return x / y;
}
