$(document).ready ->
  $('.alert').delay(3000).slideUp()
  cancel_function = ->
    window.history.back()
