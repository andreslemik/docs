$(document).on 'click', 'a[data-target="#prices"]', (e) ->
  $(document).trigger('refresh_autonumeric')

$(document).on 'click', 'a[data-target="#nomenclature"]', (e) ->
  $('input#q_name_or_partner_number_cont').val('')

