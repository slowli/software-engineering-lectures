public class Figure {
	public static final int SQUARE = 0;
	public static final int CIRCLE = 1;

	private int type;

	public double getArea() {
		switch (this.type) {
			case CIRCLE: /* ... */
			case SQUARE: /* ... */
			default: throw new IllegalStateException();
		}
	}
}
public abstract class Figure {
	public abstract double getArea();
}
public class Circle extends Figure { 
	public double getArea() { /* ... */ }
}
public class Square extends Figure {
	public double getArea() { /* ... */ }
}
