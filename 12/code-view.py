# Список книг, взятый из базы данных.
books = [
	{ 'author': 'Ray Bradbury', 'title': '451F' },
	{ 'author': 'Herman Melville', 'title': 'Moby-Dick' }
];

# HTML-код таблицы с данными о книгах.
print '<table>';
print '<thead><tr><th>Author</th><th>Title</th></tr></thead>';
print '<tbody>';
for book in books:
	print '<tr><td>%s</td><td>%s</td></tr>' 
		% (book['author'], book['title']);
print '</tbody>';
print '</table>';
