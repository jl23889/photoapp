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
				clickable: '.photo-create'
				previewsContainer: '#upload-container'
				acceptedFiles: 'image/*'
				previewTemplate: previewTemplate
				init: ->
					#scroll to top when file is added
					this.on 'addedfile', (file) ->
						$('body').animate scrollTop:0
			}
		)

		$('.thumbnail-frame').hover(
			-> $(this).find('.caption').css('visibility','visible')
			-> $(this).find('.caption').css('visibility','hidden')
		)

		$gallery = $('#gallery')
		$trash = $('#trash')
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

		$('#restore').click ->
			$('.thumbnail-frame').show(700)
			$('#trashbin .thumbnail').remove()

		$('.thumbnail-frame').click (e) ->
			$thumbnail = $(this)
			$target = $(e.target)
			if $target.is('span.photo-delete')
				deleteThumbnailFrame $thumbnail

		deleteThumbnailFrame = ($thumbnail) ->
			$thumbnail.find('.thumbnail').clone().addClass('trash').appendTo('#trashbin')
			$thumbnail.hide(400)


