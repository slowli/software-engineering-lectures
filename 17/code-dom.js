var docBody = document.getElementsByTagName('body')[0];
// $Добавление обработчика события с помощью$
// $метода \code{addEventListener}.$
docBody.addEventListener('load', function() {
	function onBtnClick() {
		// $код, выполняемый при нажатии кнопки$
		setTimeout(function() { 
			// $код, выполняемый с задержкой в две секунды$
			alert('Notification');
		}, 2000);
	}

	// $код, выполняемый при загрузке HTML-страницы$
	document.getElementById('some-button')
		.addEventListener('click', onBtnClick);
});
