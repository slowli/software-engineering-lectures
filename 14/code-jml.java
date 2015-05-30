public class SquareRoot {

	/**
	 * $Точность вычисления корня.$
	 */
	private static final double EPS = 1e-4;

	// $Предусловие$
	/*@ $\textbf{requires} x >= 0.0;$ @*/
	// $Постусловие$
	/*@ $\textbf{ensures} JMLDouble.approximatelyEqualTo(x, \textbf{\textbackslash{}result} * \textbf{\textbackslash{}result}, EPS);$
	  @*/
	public static double sqrt(double x) {
		// ...
	}
}
