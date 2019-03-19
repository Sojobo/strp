$(window).ready(function () {
	window.addEventListener('message', function (event) {
		let data = event.data;

		if (data.openMDT) {
			$('.mdt-time').html(moment().format('LT') + '<div class="mdt-date">' + moment().format('dddd Do MMMM YYYY') + '</div>');
			$('.content').hide();
			$('body').fadeIn();
			$('#menu').fadeIn();
			$('#welcomePage').fadeIn();
		} else if (data.hideAll) {
			$('body').fadeOut();
		}
	});

	document.onkeyup = function (data) {
		if (data.which == 27) {
			$.post('http://strp_mdt/escape', '{}');
		}
	};

	$('#openSearch').on('click', function () {
		$('.content').hide();
		$('#searchPage').fadeIn();
	})
	$('#openWanted').on('click', function () {
		$('.content').hide();
		$('#mostWanted').fadeIn();
	})
	$('#openLaws').on('click', function () {
		$('.content').hide();
		$('#welcomePage').fadeIn();
	})
	$('#openHistory').on('click', function () {
		$('.content').hide();
		$('#welcomePage').fadeIn();
	})

	$('body').hide();
});
