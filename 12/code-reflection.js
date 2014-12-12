function Button() { /*...*/ };

Button.prototype = {
	onClick: function() { /*...*/ },
	onDoubleClick: function() { /*...*/ },
	/* ... */
	
	/** #Заменяет все методы объекта, начинающиеся на 'on', на заглушки.# */
	disable4ever: function() {
		var noop = function() { alert('I am disabled!'); };
		for (var member in this) {
			if ((typeof(this[member]) == 'function') 
					&& (member.substring(0, 2) == 'on')) {
				this[member] = noop;
			}
		}
	}
};
