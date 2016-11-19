#*** Set up sinchClient ***/
window.loggedin = false
call = undefined

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
    $('button.call-hangup').prop 'disabled', true
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

###** Make a new PSTN call **###
window.start_call = ->
  setTimeout ->
    call = callClient.callPhoneNumber($('input#ticket_customer_phone').val())
    call.addEventListener callListeners
  ,1000


###** Name of session, can be anything. **###
login = ->
  sinchClient.start({username: EMAIL, password: PASSWORD}, (e)->
    console.log "User "+EMAIL+" successfully loggedin."
    return
  ).fail ->
    register()
  return

register = ->
  sinchClient.newUser({username: EMAIL, password: PASSWORD}, (ticket) ->
    console.log "User "+EMAIL+" successfully initiated."
    sinchClient.start(ticket, ->
      return
    ).fail handleError
    return
  ).fail handleError

login()
###** Define listener for managing calls **###

$("#call-logs-display").html($("#ticket_logs").val())
append_logs = (str)->
  logs = $("#ticket_logs").val()
  logs = logs+ "\n" + str + "\n"
  $("#ticket_logs").val(logs)
  $("#call-logs-display").html(logs)

callClient = sinchClient.getCallClient()
callClient.initStream().then ->
  # Directly init streams, in order to force user to accept use of media sources at a time we choose
  $('div.frame').not('#chromeFileWarning').show()
  return

$(document).on 'click', 'button.call-hangup', (event) ->
  $(this).prop('disabled', true)
  event.preventDefault()
  call and call.hangup()
  setTimeout ->
    $('.edit_ticket').submit()
  , 1000
  return

###** Handle errors, report them and re-enable UI **###

handleError = (error) ->
  console.log(error)
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
  call and call.hangup()