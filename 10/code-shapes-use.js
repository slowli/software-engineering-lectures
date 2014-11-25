var shape = new Circle({'x': 1, 'y': 1}, 5);

/* #Работает, несмотря на отсутствие методов .draw() и .fill() в Shape.# */
shape.drawAndFill();
/* #Заменяет метод для конкретного объекта.# */
shape.draw = function() { /*...*/ };
/* #Заменяет метод для всех объектов, создаваемых с помощью new Circle(...).# */
Circle.prototype.draw = function() { /*...*/ };

var otherShape = {
	'draw': function() { alert('Drawn!'); }
	'fill': function() { alert('Filled!'); }
	'drawAndFill': Shape.prototype.drawAndFill
};
/* #Duck typing: работает, несмотря на отсутствие явного наследования.# */
otherShape.drawAndFill();
