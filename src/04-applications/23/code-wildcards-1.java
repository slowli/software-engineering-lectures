public double totalArea(List<$\only<2>{\color{red}? \textbf{extends} }$Shape> shapes) {
	double area = 0.0;

	for (Shape shape : shapes) {
		area += shape.area();
	}
	return area;
}

List<Rectangle> rectangles = // ...
totalArea(rectangles); // $\only<1>{Ошибка: List<Rectangle> нельзя привести к List<Shape>}\only<2>{OK: List<Rectangle> — подтип List<? extends Shape>}$
