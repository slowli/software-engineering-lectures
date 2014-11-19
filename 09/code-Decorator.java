public interface Component {
	public int operation(int x);
}

public class ComponentA implements Component {
	public int operation(int x) { /* ... */ }
}

public class LoggingComponent implements Component {
	public LoggingComponent(Component base) { /* ... */ }

	public int operation(int x) {
		int result = this.base.operation(x);
		Log.info("Operation(" + x + ") = " + result); 
		return result;
	}
}
