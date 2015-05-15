@Path("/")
public class IntegerSequenceContainer {
	@GET @Produces("application/json")
	public String listSequences() { /* ... */ }

	@GET @Path("{seq}/") @Produces({"application/json","text/plain"})
	public Response getDetails(@PathParam("seq") String seq) {
		if (/* $Последовательность не зарегистрирована$ */) {
			return Response.status(404).entity("Unknown sequence: " + seq)
				.type("text/plain").build();
		}
		// Вернуть информацию о последовательности 
	}

	@GET @Path("{seq}/{index}") @Produces("text/plain")
	public Response getDetails(
		@PathParam("seq") String sequenceID, 
		@PathParam("index") int index) {
		// Вернуть член последовательности
	}
}
