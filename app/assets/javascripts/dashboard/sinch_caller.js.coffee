#*** Set up sinchClient ***/
window.loggedin = false
window.calls = []
window.ticket_id = undefined
logs = ""

sinchClient = new SinchClient(
  applicationKey: SINCH_APPLICATION_KEY
  capabilities: calling: true
  onLogMessage: (message) ->
    console.log message
    return
)

callListeners = 
  onCallProgressing: (call) ->
    $('audio#ringback').prop 'currentTime', 0
    $('audio#ringback').trigger 'play'
    append_logs("Ringing...")
    calls.push call
    $('.call-status').text 'Ringing ...'
    return
  onCallEstablished: (call) ->
    $('audio#incoming').attr 'src', call.incomingStreamURL
    $('audio#ringback').trigger 'pause'
    #Report call stats
    callDetails = call.getDetails()
    append_logs('Answered at: ' + callDetails.establishedTime)
    $('.call-status').text 'Call Established'
    setTimeout ->
      $('.call-status').text 'Call In-progress ...'
    , 5000
    return
  onCallEnded: (call) ->
    $('audio#ringback').trigger 'pause'
    $('audio#incoming').attr 'src', ''
    #Report call stats
    $('.call-status').text 'Call Ended'
    callDetails = call.getDetails()
    append_logs('Ended: ' + callDetails.endedTime)
    append_logs('Duration (s): ' + callDetails.duration)
    append_logs('End cause: ' + call.getEndCause())

    if call.error
      append_logs('Failure message: ' + call.error.message)
    return

setInterval ->
  $.get('/api/tickets/check_for_new.js')
, 3000

update_call_status = (status)->
  $.post '/api/users/update_call_status', {on_call: status, ticket_id: ticket_id}, (res)->
    console.log res
    return

$(document).on "turbolinks:load", ->
  update_call_status(true)

###** Name of session, can be anything. **###
login = (callback)->
  sinchClient.start({username: EMAIL, password: PASSWORD}, (e)->
    console.log "User "+EMAIL+" successfully loggedin."
    callback()
    return
  ).fail ->
    register()
  return

register = ->
  sinchClient.newUser({username: EMAIL, password: PASSWORD}, (ticket) ->
    console.log "User "+EMAIL+" successfully initiated."
    sinchClient.start(ticket, ->
      callback()
      return
    ).fail handleError
    return
  ).fail handleError

window.hangup_call = ->
  $(calls).each (i, call)->
    try
      call and call.hangup()
    catch e
      console.log(e)

###** Make a new PSTN call **###
window.start_call = ->
  update_call_status(false)
  login ->
    setTimeout ->
      hangup_call()
      call = callClient.callPhoneNumber($('input#ticket_customer_phone').val())
      call.addEventListener callListeners
      window.calls.push call
    ,1000
###** Define listener for managing calls **###

append_logs = (str)->
  logs = logs + "<br/>" + str

submit_logs = ->
  $.post '/api/ticket_logs', {action: "Call Logs", content: logs, ticket_id: ticket_id}, (res)->
    console.log res
    return

  $("#call-logs-display").load("http://localhost:3000/api/ticket_logs/?ticket_id="+ticket_id)

callClient = sinchClient.getCallClient()
callClient.initStream().then ->
  # Directly init streams, in order to force user to accept use of media sources at a time we choose
  $('div.frame').not('#chromeFileWarning').show()
  return

$(document).on 'click', 'button.call-hangup', (event) ->
  event.preventDefault()
  submit_logs()
  update_call_status(true)
  hangup_call()
  return

###** Handle errors, report them and re-enable UI **###

handleError = (error) ->
  console.log(error)
  call = callClient.callPhoneNumber($('input#ticket_customer_phone').val())
  call.addEventListener callListeners
  calls.push call
  #Show error
  # $('div.error').text error.message
  # $('div.error').show()
  return

###* Always clear errors *###

clearError = ->
  # $('div.error').hide()
  return

###* Chrome check for file - This will warn developers of using file: protocol when testing WebRTC *###

if location.protocol == 'file:' and navigator.userAgent.toLowerCase().indexOf('chrome') > -1
  $('div#chromeFileWarning').show()

$(document).on 'submit', 'form.edit_ticket', ->
  submit_logs()
  update_call_status(true)
  hangup_call()