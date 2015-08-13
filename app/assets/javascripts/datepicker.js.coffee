$(document).ready -> 
  setDatePicker()

$(document).on 'click', '#clear-datepicker', (e) ->
  $(".input.datepicker input").attr('value', '')
  $("input.datepicker").val('')
  false
