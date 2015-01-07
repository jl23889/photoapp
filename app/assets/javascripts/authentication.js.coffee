# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
	$('.sign-in').hide()
	$('html body').scrollTop($(document).height())

jQuery ->
	$('.scrollTop').click ->
		$('.carousel').carousel('pause')
		$('.scrollTop').fadeOut('slow')
		$('body').animate scrollTop:0, 1000, 'swing', ->
			$('.sign-in').fadeIn('slow')
			return
		$('.carousel').carousel('pause')
		return