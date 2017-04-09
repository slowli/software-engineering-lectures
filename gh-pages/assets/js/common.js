(function(window) {
	
/**
 * @param {jQuery} element
 *    where to mount the menu
 * @param {jQuery} lookup
 *    where to search for items
 */
function TOC(element, lookup) {
	var list = element.append('<ul/>').children('ul:last');
	lookup.find('h2,h3').each(function() {
		var $this = $(this);
		var anchor = null;
		if ($this.eq(0).id) {
			anchor = $this.eq(0).id;
		} else {
			anchor = 'section-' + (list.children('li').length + 1);
			if ($this.is('h3')) {
				anchor = 'section-' + list.children('li').length;
				anchor += '.' + (list.children('li:last').find('li').length + 1);
			}
			$this.eq(0).prop('id', anchor);
		}
		var link = '<li><a href="#' + anchor + '" >' + $this.text() + '</a></li>';
		
		if ($this.is('h2')) {
			list.append(link);
		} else {
			if (list.children('li:last').find('ul').length == 0) {
				list.children('li:last').append('<ul/>');
			}
			list.children('li:last').find('ul').append(link);
		}
	});
}

$(function() {
	$('[data-toc]').each(function() {
		var $this = $(this);
		var lookup = $($(this).data('toc'));
		TOC($this, lookup);
	});
})
	
})(window);