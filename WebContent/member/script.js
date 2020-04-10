/*active button class onclick*/
$(function(){
	$('.custom-nav a').click(function(e) {
		e.preventDefault();
		$('.custom-nav a').removeClass('active');
		$(this).addClass('active');
		if(this.id === !'payment'){
			$('.payment').addClass('noshow');
		}
		else if(this.id === 'payment') {
			$('.payment').removeClass('noshow');
			$('.content').children().not('.payment').addClass('noshow');
		}
		else if (this.id === 'profile') {
			$('.profile').removeClass('noshow');
			$('.content').children().not('.profile').addClass('noshow');
		}
		else if(this.id === 'subscription') {
			$('.subscription').removeClass('noshow');
			$('.content').children().not('.subscription').addClass('noshow');
		}
		else if(this.id === 'privacy') {
			$('.privacy').removeClass('noshow');
			$('.content').children().not('.privacy').addClass('noshow');
		}
		else if(this.id === 'settings') {
			$('.settings').removeClass('noshow');
			$('.content').children().not('.settings').addClass('noshow');
		}
	});
});