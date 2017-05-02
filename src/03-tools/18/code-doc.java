/**
 * $Вычисляет отношение двух действительных чисел.$
 * $В отличие от операции деления \textbf{<code>}/\textbf{</code>}, если знаменатель отношения$
 * $равен нулю, возбуждается исключительная ситуация.$
 *
 * $\codekw{@param} x$
 *    $числитель$
 * $\codekw{@param} y$
 *    $знаменатель$
 * $\codekw{@return}$
 *    $результат операции деления$
 *
 * $\codekw{@throws} ArithmeticException$
 *    $если знаменатель равен нулю$
 */
public static double div(double x, double y) {
	if (y == 0.0) throw new ArithmeticException("Division by zero");
	return x / y;
}
