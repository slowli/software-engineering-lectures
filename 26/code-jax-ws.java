@Stateless @WebService(
	serviceName = "IntSequence",
	targetNamespace = "http://example.com/int-sequence/")
public class IntSequence {
	@WebMethod
	public List<Description> listSequences() { /* ... */ }

	@WebMethod
	public Description getDetails(String seq) throws IntSequenceException {
		if (/* $Последовательность не зарегистрирована$ */) {
			throw new IntSequenceException(/* ... */);
		}
		// Вернуть информацию о последовательности 
	}

	@WebMethod
	public BigInteger getDetails(String seq, int index) {
		// Вернуть член последовательности
	}
}
