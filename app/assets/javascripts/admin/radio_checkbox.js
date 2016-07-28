var ready
ready = function(){
  make_radio_from_checkbox();
}

function make_radio_from_checkbox(){
  $(document).on('click','.answers_checkbox',function () {
    if ($('#question_question_type').val() == 'single'){
      $('.answers_checkbox').not(this).attr('checked', false);
    }
  })

  $('#question_question_type').on('change', function(){
    $('.answers_checkbox').attr('checked', false);
  });
}

$(document).ready(ready)
$(document).on('page:load', ready)
