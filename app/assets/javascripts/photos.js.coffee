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
		
		$('body').dropzone({
				headers: 'X-CSRF-TOKEN': token
				url: 'photos/upload'
				clickable: '#button-upload'
				previewsContainer: '#upload-container'
				acceptedFiles: 'image/*'
				previewTemplate: previewTemplate
				init: ->
					#scroll to top when file is added
					this.on 'addedfile', (file) ->
						$('.well-sidebutton').hide()
			}
		)

		$('.thumbnail-frame').hover(
			-> $(this).find('.caption-buttons').removeClass('invisible')
			-> $(this).find('.caption-buttons').addClass('invisible')
		)

		$gallery = $('#gallery')
		$trash = $('#trashbin')
		$('.thumbnail-frame', $gallery).draggable({
				start: ->
					$(this).css('z-index','1000')
					return
				revert: true
				containment: 'body'
				cursor: 'move'
				stop: ->
					$(this).css('z-index','')
			}
		)
		$trash.droppable({
				accept: '#gallery > .thumbnail-frame'
				activeClass: 'ui-state-highlight'
				drop: (event,ui) ->
					deleteThumbnailFrame(ui.draggable)
			}
		)

		$('#button-restore').click ->
			$('.thumbnail-frame').fadeTo('slow',1)
			$('#trashbin .thumbnail').remove()

		$('#button-close-trash').click ->
			$('#trashbin').addClass('hidden')
			$('.well-sidebutton').fadeIn()

		$('.thumbnail-frame').click (e) ->
			$thumbnail = $(this)
			$target = $(e.target)
			if $target.is('span.photo-delete')
				deleteThumbnailFrame $thumbnail

		deleteThumbnailFrame = ($thumbnail) ->
			$thumbnail.find('.thumbnail').clone().addClass('trash').appendTo('#trashbin')
			$thumbnail.fadeTo('slow', 0.3)

		$('#button-trash').click ->
			$('#trashbin').removeClass('hidden')
			$('.well-sidebutton').fadeOut()

		$('#button-scroll-top').click ->
			$('body').animate scrollTop:0


