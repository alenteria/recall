#*** Set up sinchClient ***/
sinchClient = new SinchClient(
  applicationKey: SINCH_APPLICATION_KEY
  capabilities: calling: true
  onLogMessage: (message) ->
    console.log message
    return
)

###** Name of session, can be anything. **###

sessionName = 'sinchSessionPSTN-' + sinchClient.applicationKey

###** Login user and save session in localStorage **###

sinchClient.start({username: EMAIL, password: PASSWORD}, ->
  return
).fail handleError
return

###** Define listener for managing calls **###

callListeners = 
  onCallProgressing: (call) ->
    $('audio#ringback').prop 'currentTime', 0
    $('audio#ringback').trigger 'play'
    $('div#callLog').append '<div id="stats">Ringing...</div>'
    return
  onCallEstablished: (call) ->
    $('audio#incoming').attr 'src', call.incomingStreamURL
    $('audio#ringback').trigger 'pause'
    #Report call stats
    callDetails = call.getDetails()
    $('div#callLog').append '<div id="stats">Answered at: ' + callDetails.establishedTime + '</div>'
    return
  onCallEnded: (call) ->
    $('audio#ringback').trigger 'pause'
    $('audio#incoming').attr 'src', ''
    $('button').removeClass 'incall'
    $('input#phoneNumber').removeAttr 'disabled'
    #Report call stats
    callDetails = call.getDetails()
    $('div#callLog').append '<div id="stats">Ended: ' + callDetails.endedTime + '</div>'
    $('div#callLog').append '<div id="stats">Duration (s): ' + callDetails.duration + '</div>'
    $('div#callLog').append '<div id="stats">End cause: ' + call.getEndCause() + '</div>'
    if call.error
      $('div#callLog').append '<div id="stats">Failure message: ' + call.error.message + '</div>'
    return

###** Make a new PSTN call **###

callClient = sinchClient.getCallClient()
callClient.initStream().then ->
  # Directly init streams, in order to force user to accept use of media sources at a time we choose
  $('div.frame').not('#chromeFileWarning').show()
  return
call = undefined
$('button#call').click (event) ->
  event.preventDefault()
  if !$(this).hasClass('incall')
    $('button').addClass 'incall'
    $('input#phoneNumber').attr 'disabled', 'disabled'
    $('div#callLog').append '<div id="title">Calling ' + $('input#phoneNumber').val() + '</div>'
    call = callClient.callPhoneNumber($('input#phoneNumber').val())
    call.addEventListener callListeners
  return
$('button#hangup').click (event) ->
  event.preventDefault()
  if $(this).hasClass('incall')
    call and call.hangup()
  return

###** Log out user **###

$('button#logOut').on 'click', (event) ->
  event.preventDefault()
  clearError()
  #Stop the sinchClient
  sinchClient.terminate()
  #Note: sinchClient object is now considered stale. Instantiate new sinchClient to reauthenticate, or reload the page.
  #Remember to destroy / unset the session info you may have stored
  delete localStorage[sessionName]
  #Allow re-login
  $('button#loginUser').attr 'disabled', false
  $('button#createUser').attr 'disabled', false
  #Reload page.
  window.location.reload()
  return

###** Handle errors, report them and re-enable UI **###

handleError = (error) ->
  #Enable buttons
  $('button#createUser').prop 'disabled', false
  $('button#loginUser').prop 'disabled', false
  #Show error
  $('div.error').text error.message
  $('div.error').show()
  return

###* Always clear errors *###

clearError = ->
  $('div.error').hide()
  return

###* Chrome check for file - This will warn developers of using file: protocol when testing WebRTC *###

if location.protocol == 'file:' and navigator.userAgent.toLowerCase().indexOf('chrome') > -1
  $('div#chromeFileWarning').show()
$('button').prop 'disabled', false