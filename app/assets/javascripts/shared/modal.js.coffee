$(document).on 'click', '.modal-trigger', (e)->
  e.preventDefault()
  target = $($(this).data('target'))
  target.modal('show')

$(document).on 'click', '.dismiss-call-prompt', ->
  dismissed_tickets = localStorage.getItem('dismissed_call_prompts') || []
  dismissed_tickets.push $(this).data('id')
  localStorage.setItem('dismissed_call_prompts', dismissed_tickets)