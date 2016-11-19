$(document).on 'click', '.modal-trigger', (e)->
  e.preventDefault()
  target = $($(this).data('target'))
  target.modal('show')