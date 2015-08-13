#= require jquery
#= require jquery_ujs
#= require jquery_nested_form
#= require jquery-ui/datepicker
#= require jquery-ui/datepicker-ru
#= require autonumeric
#= require_tree .
#= require foundation
#= require wiselinks

$(document).ready ->
  window.wiselinks = new Wiselinks()
  setInterval (->
    check_new_messages()
    ), 60000
  
  $(document).off('page:done').on(
    'page:done' 
    (event, $target, status, url, data) ->
      # that for work foundation with wiselinks
      $(document).foundation()
      setDatePicker()
  )

  $(document).off('page:always').on(
    'page:always'
    (event, xhr, settings) ->
      $('.loading-indicator').fadeOut()
      check_new_messages()
  )
  
  $(document).off('page:redirected').on(
        'page:redirected'
        (event, $target, render, url) ->
            $('.loading-indicator').fadeIn()
    )
  $(document).off('page:loading').on(
        'page:loading'
        (event, $target, render, url) ->
            $('.loading-indicator').fadeIn()
    )

  
$ ->
  $(document).foundation()
  return

window.onload = ->
  setTimeout (->
    window.onpopstate = ->
      location.reload()
      return

    return
  ), 0
  return


@setDatePicker = ->
  $("input.datepicker").each (i) ->
    $(this).datepicker
      altFormat: "yy-mm-dd"
      dateFormat: "dd.mm.yy"
      altField: $(this).next()
      regional: "ru"



