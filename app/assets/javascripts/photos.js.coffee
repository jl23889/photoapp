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
		
		photoDropzone = new Dropzone(document.body,
				autoQueue: false
				parallelUploads: 10
				headers: 'X-CSRF-TOKEN': token
				url: 'photos/upload'
				clickable: '#button-upload'
				previewsContainer: '#upload-container'
				acceptedFiles: 'image/*'
				previewTemplate: previewTemplate
		)

		# display modal
		photoDropzone.on 'addedfile', (file) ->
			$('#modal-upload-container').modal('show')
			return

		# Close modal and refresh from server on uploading queue
		photoDropzone.on 'queuecomplete', (file) ->
		  $('#modal-upload-container').modal('hide')
		  location.reload(true)
		  return

		$('.start-all').click ->
			photoDropzone.enqueueFiles(photoDropzone.getFilesWithStatus(Dropzone.ADDED))
		
		# Remove all files from queue when modal is hidden
		$('#modal-upload-container').on 'hidden.bs.modal', (e) ->
		  photoDropzone.removeAllFiles(true)

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

		$('#button-empty-trash').click ->
			trashbin=[]
			$('#trashbin .trash').each ->
				trashbin.push $(this).data('photo-id')
			$.ajax(
				type: 'PUT'
				url: '/photos/trash'
				data: { photo_ids: trashbin }
			)

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
			$thumbnail.fadeTo('slow', 0.2)

		$('#button-trash').click ->
			$('#trashbin').removeClass('hidden')
			$('.well-sidebutton').fadeOut()

		$('#button-scroll-top').click ->
			$('body').animate scrollTop:0


