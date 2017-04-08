// $Интерфейс для списков, состоящих из элементов типа E$
public interface List<E>{
	boolean add(E e);
	E get(int index);
	E remove(int index);
	E set(int index, E element);
	/* ... */
}

List<Integer> intList = new ArrayList<Integer>();
intList.add(2); // $боксинг int \(\rightarrow\) Integer$
intList.add("foo"); // $ошибка компиляции$
