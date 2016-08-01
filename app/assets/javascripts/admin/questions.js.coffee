$(document).on 'ready page:load', ->
  $('#question_question_type').on 'change', ->
    question_type =  $(this).val()
    answer_text = '<div class="text_question">'
    answer_text += '<textarea class="materialize-textarea"'
    answer_text += 'name="question[answers_attributes][0][content]"'
    answer_text += 'id="question_answers_attributes_0_content"></textarea></div>'
    if question_type == 'text'
      $('.text_question').removeClass('hide')
      $('.choice_question').addClass('hide')
      $('#answer_field').append(answer_text)
      $('.materialize-textarea').css('width', '800px')
      $('.materialize-textarea').css('height', '150px')
      $('.add_fields').addClass('hide')
    if question_type == 'single' || question_type == 'multiple'
      $('.text_question').remove()
      $('.choice_question').removeClass('hide')
      $('.add_fields').removeClass('hide')
      $('.add_fields').show()
