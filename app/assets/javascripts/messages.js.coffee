# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'click', '.check_all', (e) ->
  checks = $(this).data('checks')
  checkboxes = $("input." + checks + "[type='checkbox']")
  if($(this).data('switch') == 0)
    checkboxes.prop('checked', true)
    $(this).data('switch', 1)
    $(this).text('Снять выделение')
  else
    checkboxes.prop('checked', false)
    $(this).data('switch', 0)
    $(this).text('Выбрать всех')
  false
  
@check_new_messages = ->
  $.getJSON '/messages', (data) ->
    if(data.length > 0)
      $('i#mailbox').addClass('flashit')
    else
      $('i#mailbox').removeClass('flashit')
