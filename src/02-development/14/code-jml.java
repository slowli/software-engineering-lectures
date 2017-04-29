public class SquareRoot {

	/**
	 * $Точность вычисления корня.$
	 */
	private static final double EPS = 1e-4;

	// $Предусловие$
	/*@ $\codekw{requires} x >= 0.0;$ @*/
	// $Постусловие$
	/*@ $\codekw{ensures} JMLDouble.approximatelyEqualTo(x, \codekw{\textbackslash{}result} * \codekw{\textbackslash{}result}, EPS);$
	  @*/
	public static double sqrt(double x) {
		// ...
	}
}
