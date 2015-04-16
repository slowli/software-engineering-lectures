// Общий метод поиска максимального элемента в коллекции
public static <T> T max(Collection<T> elements, 
	Comparator<#\only<4>{\color{red}? \textbf{super} }#T> comparator) {
	// comparator используется для сравнения элементов из коллекции
	// с помощью метода public int comparator.compare(T x, T y);
}

List<Rectangle> rectangles = // …
Comparator<Shape> areaComp = // Сравнение фигур по площади
max(rectangles, areaComp);
// \only<3>{Ошибка: Comparator<Shape> нельзя привести к Comparator<Rectangle>}\only<4>{ОК: Comparator<Shape> — подтип Comparator<? super Rectangle>}
