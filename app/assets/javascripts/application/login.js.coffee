get_page_name = ->
  $('body').data().pageName || ""

$(document).on "turbolinks:load", ->
  $('.modal-dialog.shake').effect("shake", { times:1})

$(document).on 'click', '.btn-facebook', (e)->
  # enable for ajax
  # e.preventDefault()
  # cb_path = $(@).data('ajax-callback')
  # FB.login (response) ->
  #   if response.authResponse
  #     # since we have cookies enabled, this request will allow omniauth to parse
  #     # out the auth code from the signed request in the fbsr_XXX cookie
  #     $.getJSON cb_path, (json) ->
  #       return
  #   return