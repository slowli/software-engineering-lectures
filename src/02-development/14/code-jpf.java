public class Racer implements Runnable {
	private int d = 42;
 
	public void run() {
		try { Thread.sleep(1001); } catch (InterruptedException e) {}
		d = 0;                     // (1)
	}
 
	public static void main(String[] args) {
		Racer racer = new Racer();
		Thread t = new Thread(racer);
		t.start();
 
		try { Thread.sleep(1000); } catch (InterruptedException e) {}
		int c = 420 / racer.d;    // (2)
		System.out.println(c);
	}
}
