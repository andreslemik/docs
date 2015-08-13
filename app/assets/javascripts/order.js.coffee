# function found id of rows
get_ids = (link) ->
  context = ($(link).closest('.fields').closestChild('input, textarea, select').eq(0).attr('name') || '').replace(/\[[a-z_]+\]$/, '')
  parentIds = context.match(/[0-9]+/g) || []
  return parentIds


$(document).on 'change', "#order_distributor_id", (e) ->
  url = 'new?distributor_id=' + $(this).val() + '#'
  window.location.replace(url)
  
# open modal for select nomenclature
$(document).on 'click', ".open-search-nomenclature", (e) ->
  link = e.currentTarget
  $('#ids').val(get_ids(link))
  $('#nomenclature').foundation 'reveal', 'open',
    close_on_background_click: false
  false
  
# nomenclature select
$(document).on 'click', ".select-nomenclature", (e) ->
  nomenclature_id = $(this).data("nomenclature-id")
  price_id = $(this).data("price-id")
  select_attr = '#items [id*=' + $('#ids').val()
  $.getJSON '/nomenclatures/' + nomenclature_id, (data) ->
    $.each data, (key, val) ->
      if(key=='partner_number')
        $(select_attr+'_partner_number]').val(val)
      if(key=='id')
        $(select_attr+'_nomenclature_id]').val(val)
  $.getJSON '/prices/' + price_id, (data) ->
    $(select_attr+'_price]').val(data.price)
  $('#nomenclature').foundation 'reveal', 'close'
  false
  
# recalculate summa on quantity change
$(document).on 'keyup change', '.quantity-fields', (e) ->
  link = $(this).parent()
  Ids = get_ids(link)
  price = parseFloat($('[id*=' + Ids + '_price]').val())
  quantity = parseInt($('[id*=' + Ids + '_quantity]').val())
  $('[id*=' + Ids + '_summa]').val(price * quantity || 0)
  $('[id*=' + Ids + '_nds]').val(Math.round(price*quantity*(1-1/1.18)*100)/100 || 0)
  

