// $Указывает, что фрукты сравнимы с другими фруктами.$
// $В результате можно, например, сортировать списки и массивы фруктов$
// $(методы Arrays.sort, Collections.sort) и производить в них$
// $бинарный поиск (Arrays.binarySearch, Collections.binarySearch).$
public class Fruit implements Comparable<Fruit> {

	// $реализация единственного метода интерфейса Comparable$
	@Override public int compareTo(Fruit other) {
		return Double.compare(this.weight(), other.weight());
	}

	public double weight() { /* ... */ }

	// $Другие методы$
}

List<Fruit> fruitList = // ...
Collections.sort(fruitList);
