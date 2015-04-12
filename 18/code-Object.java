public class Object {
	public Object(); // конструктор
	protected void finalize(); // деструктор
	protected Object clone(); // операция клонирования
	public boolean equals(Object obj); // сравнение по значению
	public int hashCode(); // хэш-код для имплементаций таблиц и множеств
	public String toString(); // приведение к строковому ТД
	public Class<?> getClass(); // класс объекта (напр., для рефлексии)

	// примитивы синхронизации
	public void notify();
	public void notifyAll();
	public void wait();
	public void wait(long timeout);
	public void wait(long timeout, int nanos);
}
