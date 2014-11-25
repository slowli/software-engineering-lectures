public interface ClickListener {
	void onClick(Object sender);
}

public class Button {
	private ClickListener listener;
	public void setListener(ClickListener l) { this.listener = l; }

	protected void doClick() {
		/* ... */
		if (this.listener != null) this.listener.onClick(this);
	}
}

Button button = new Button();
button.setListener(new ClickListener() {
	public void onClick(sender) {
		System.out.println(sender + " was clicked!");
	}
});
