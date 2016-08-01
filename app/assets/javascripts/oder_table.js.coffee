$(document).on 'ready page:load', ->
    $('#admin_subject').dataTable()
    $('#user_exam').dataTable()
    $('#admin_exam').dataTable()
    $('#admin_user').dataTable()
    $('.dataTables_length').hide()
    $('.dataTables_filter').hide()
    $('.dataTables_info').hide()
    $('.dataTables_paginate').hide()

$(document).ready ->
  $('[data-toggle="tooltip"]').tooltip()
