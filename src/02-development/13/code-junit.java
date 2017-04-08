@Test
public void testBoundaryValues() {
	String str = Fibonacci.get(0);
	assertEquals("0", str);
	str = Fibonacci.get(1);
	assertEquals("1", str);
}

@Test
public void testSums() {
	for (int n = 10; n < 10000; n++) {
		BigNumber a = new BigNumber(Fibonacci.get(n)), 
			b = new BigNumber(Fibonacci.get(n - 1)), 
			c = new BigNumber(Fibonacci.get(n - 2));
		assertEquals(b.plus(c), a);
	}
}
