public abstract class Shape {
	public abstract void draw();
}

public class Circle extends Shape {
	public Circle(api, center, radius) { /*...*/ }
	public void draw() { api.drawCircle(center, radius); }
}

public interface DrawingAPI {
	void drawCircle(Point c, double radius);
	/* #другие методы# */
}

public class WindowsAPI implements DrawingAPI {
	public void drawCircle(Point c, double radius) { /* ... */ }
}

public class LinuxAPI implements DrawingAPI {
	public void drawCircle(Point c, double radius) { /* ... */ }
}
