abstract class Shape {
	public abstract double area();
}

class Rectangle extends Shape {
	private final double width, height;
	public double area() { return width * height; }
}

class Circle extends Shape {
	private final double radius;
	public double area() { return Math.PI * radius * radius; }
}

Shape[] shapes = new Shape[] {
	new Rectangle(3, 4), new Circle(5)
};
for (Shape shape : shapes) System.out.println(shape.area());
