public class Arrays {
	/* … */

	// Методы для бинарного поиска в массивах
	public static int binarySearch(byte[] a, byte key);
	public static int binarySearch(int[] a, int key);
	// другие массивы из примитивных ТД

	// используется для всех массивов, не состоящих из примитивных элементов
	public static int binarySearch(Object[] a, Object key);
}

Arrays.binarySearch(new int[] { 2, 3, 5, 8 }, 6);
Arrays.binarySearch(new double[] { 2.1, 3.1, 5.0, 8.0 }, 6.3);
Arrays.binarySearch(new String[] { "bar", "bazz", "foo" }, "element");
