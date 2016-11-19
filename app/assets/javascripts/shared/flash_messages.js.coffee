$(document).on "turbolinks:load", ->
  $('.flash.modal').modal('show')
  setTimeout ->
    $('.flash.modal').modal('hide')
  ,5000