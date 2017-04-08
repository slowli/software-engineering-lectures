/* $Пример использования в Java$ */
public class MyContainer<T> implements Collection<T> {
	public Iterator<T> iterator() { /* ... */ }
}

Container<String> container = ...;
for (String str : container) {
	System.out.println(str);
}

/* $эквивалентный способ$ */
for (Iterator<String> it = container.iterator(); it.hasNext(); ) {
	String str = it.next();
	System.out.println(str);
}
