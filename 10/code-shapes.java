public abstract class Shape {
	private Point center;
	protected Shape(Point center) { /*...*/ }

	public abstract void draw();
	public abstract void fill();
	public void drawAndFill() {
		this.draw();
		this.fill();
	}
}

public class Circle extends Shape {
	private double radius;
	public Circle(Point center, double radius) { /*...*/ }

	public void draw() { /*...*/ }
	public void fill() { /*...*/ }
}
