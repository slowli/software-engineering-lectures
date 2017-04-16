function Shape(center) {
	this.center = center;
};
Shape.prototype.drawAndFill = function() {
	this.draw();
	this.fill();
};

function Circle(center, radius) {
	Shape.call(this, center);
	this.radius = radius;
}
/* $Клонирование прототипа.$ */
Circle.prototype = Object.create(Shape.prototype); 
Circle.prototype.draw = function() { /* ... */ };
Circle.prototype.fill = function() { /* ... */ };


