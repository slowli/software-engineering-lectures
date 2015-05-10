public class SerializationTest implements Serializable {
	/** $Идентификатор версии, записываемый при сериализации.$ */
	private static final long serialVersionUID = 1L;
	/** $Не сериализуется, т.к. является статическим.$ */
	private static final int ANSWER = 42;
	/** $Сериализуемое поле.$ */
	private int foo;
	/** $Еще одно сериализуемое поле.$ */
	private List<Integer> someList = new ArrayList<Integer>();
	/** $Не сериализуется, т.\,к. помечено как transient.$ */
	private transient Map<Integer, String> cache 
			= new HashMap<Integer, String>();
	/* $Другие поля и методы.$ */

	private void readObject(ObjectInputStream in) throws IOException {
		in.defaultReadObject(); // Механизм чтения по умолчанию
		// При десериализации не вызывается конструктор объекта, 
		// так что несохраненные поля надо инициализировать вручную
		this.cache = new HashMap<Integer, String>();
	}
}
