# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	previewNode = document.querySelector('#upload-template')
	previewNode.id = ''
	previewTemplate = previewNode.parentNode.innerHTML
	previewNode.remove()

	jQuery ->
		token = $('meta[name="csrf-token"]').attr('content')
		
		$('body').dropzone(
			{
				headers: 'X-CSRF-TOKEN': token
				url: 'photos/upload'
				clickable: '#quick-upload'
				previewsContainer: '#upload-container'
				acceptedFiles: 'image/*'
				previewTemplate: previewTemplate
			}
		)