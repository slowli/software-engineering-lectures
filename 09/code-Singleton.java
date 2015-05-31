public class Singleton {
	private static Singleton instance;

	public static synchronized Singleton getInstance() {
		if (instance == null) {
			instance = new Singleton();
		}
		return instance;
	}
	
	private Singleton() { /* $код инициализации$ */ }

	public void run() { /* ... */ }
}

/* $использование$ */
Singleton.getInstance().run();
