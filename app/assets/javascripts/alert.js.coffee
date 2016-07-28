$(document).on 'ready page:load', ->
  $('.alert-danger').delay(5000).slideUp()
  $('.alert-success').delay(5000).slideUp()
  $('.alert-alert').delay(5000).slideUp()
  $('.alert-notice').delay(5000).slideUp()
  cancel_function = ->
    window.history.back()
