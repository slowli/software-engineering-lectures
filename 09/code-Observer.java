public interface ClickListener {
	void onClick(Object sender);
}

public class Button {
	public void setListener(ClickListener l) { /* ... */ }
}

Button button = new Button();
button.setListener(new ClickListener() {
	public void onClick(sender) {
		System.out.println(sender + " was clicked!");
	}
});
