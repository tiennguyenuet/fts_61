$(document).on 'ready page:load', ->
  clock = $('#clock')
  status = clock.attr('data-status')
  time_limit = clock.attr('data-time-limit')
  time_start = clock.attr('data-time-start')
  time_now = clock.attr('data-time-now')
  time = time_limit * 60 - (time_now - time_start)
  setInterval (->
    `var hour`
    `var min`
    `var sec`
    if time > 0 and status != 'unchecked' and status != 'checked'
      c = time--
      h = c / 3600 >> 0
      if h.toString().length > 1
        hour = '' + h
      else
        hour = '0' + h
      m = (c - (h * 3600)) / 60 >> 0
      if m.toString().length > 1
        min = '' + m
      else
        min = '0' + m
      s = c - (m * 60 + h * 3600) >> 0
      if s.toString().length > 1
        sec = '' + s
      else
        sec = '0' + s
      clock.text hour + ':' + min + ':' + sec
    else
      if status == 'testing'
        $('#finish').click()
      clock.text '00:00:00'
    return
  ), 1000
  return
