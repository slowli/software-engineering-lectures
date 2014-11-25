/* #Полиморфизм подтипов: Circle можно рассматривать как Shape.# */
Shape s = new Circle(new Point(1, 1), 5);

/* #Динамическая диспетчеризация: вызывается Circle.draw(), а не Shape.draw().# */
s.draw();

public abstract class Shape {
	/*...*/

	public void drawAndFill() {
		/* #Открытая рекурсия: при вызове s.drawAndFill() будут вызваны# */
		/* #методы Circle.draw() и Circle.fill().# */
		this.draw();
		this.fill();
	}
}
