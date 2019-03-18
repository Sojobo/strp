let bankAmount = 0;
let cashAmount = 0;

$(window).ready(function () {
	window.addEventListener('message', function (event) {
		let data = event.data;

		if (data.showMenu) {
			$('.bank-time').html(moment().format('LT') + '<div class="bank-date">' + moment().format('dddd Do MMMM YYYY') + '</div>');
			$('body').fadeIn();
			$('#menu').fadeIn();

			cashAmount = data.player.money;
			bankAmount = 0;
			for (let i = 0; i < data.player.accounts.length; i++) {
				if (data.player.accounts[i].name == 'bank') {
					bankAmount = data.player.accounts[i].money;
				}
			}

			$('#balance').html(bankAmount.toLocaleString('en-GB'));
			$('#cash').html(cashAmount.toLocaleString('en-GB'));
		} else if (data.hideAll) {
			$('body').fadeOut();
		}
	});

	document.onkeyup = function (data) {
		if (data.which == 27) {
			$.post('http://strp_atm/escape', '{}');
		}
	};

	$('body').hide();

	$('#depositall').on('click', function () {
		if (Number(cashAmount) > 0) {
			$.post('http://strp_atm/deposit', JSON.stringify({
				amount: cashAmount
			}));

			bankAmount += cashAmount;
			cashAmount = 0;
			$('#balance').html(bankAmount.toLocaleString('en-GB'));
			$('#cash').html(cashAmount.toLocaleString('en-GB'));
		}
	})

	$('#quickcash').on('click', function () {
		if (Number(bankAmount) >= 250) {
			$.post('http://strp_atm/withdraw', JSON.stringify({
				amount: 250
			}));
			
			bankAmount -= 250;
			cashAmount += 250;
			$('#balance').html(bankAmount.toLocaleString('en-GB'));
			$('#cash').html(cashAmount.toLocaleString('en-GB'));
		}
	});

	$('#depositinput').on("keyup", function (e) {
		if (e.keyCode == 13 && Number($('#depositinput').val()) <= Number(cashAmount)) {
			$.post('http://strp_atm/deposit', JSON.stringify({
				amount: $('#depositinput').val()
			}));

			bankAmount += Number($('#depositinput').val());
			cashAmount -= Number($('#depositinput').val());
			$('#depositinput').val("");
			$('#balance').html(bankAmount.toLocaleString('en-GB'));
			$('#cash').html(cashAmount.toLocaleString('en-GB'));
		}
	});

	$('#withdrawinput').on("keyup", function (e) {
		if (e.keyCode == 13 && Number($('#withdrawinput').val()) <= Number(bankAmount)) {
			$.post('http://strp_atm/withdraw', JSON.stringify({
				amount: $('#withdrawinput').val()
			}));

			cashAmount += Number($('#withdrawinput').val());
			bankAmount -= Number($('#withdrawinput').val());
			$('#withdrawinput').val("");
			$('#balance').html(bankAmount.toLocaleString('en-GB'));
			$('#cash').html(cashAmount.toLocaleString('en-GB'));
		}
	});
});
