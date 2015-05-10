@Entity
public class Reader implements Serializable {
	/** $Идентификатор (генерируется автоматически базой данных).$ */
	@Id @GeneratedValue(strategy=GenerationType.AUTO)
	private long id;

	/** $Аннотация означает, что при сохранении поле не может равняться null.$ */
	@NotNull protected String firstName;

	@NotNull protected String lastName;

	/** $Отношение «многие (читатели) к одному (местоположению)».$ */
	@ManyToOne @JoinColumn(name="location_id")
	protected Location location;

	/** $Отношение «многие (читатели) ко многим (взятым книгам)».$ */
	@ManyToMany @JoinTable(name="checkedout")
	protected List<Book> checkedOut;
}
