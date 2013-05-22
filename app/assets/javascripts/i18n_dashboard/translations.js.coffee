jQuery ->
  $('#form-translation textarea').autosize()

  $('#add-translation-link').click (event) ->
    event.preventDefault()
    $('#form-translation #locale').val('')
    $('#form-translation #key').val('')
    $('#form-translation #value').val('')
    $('#form-translation #value').trigger('autosize')

  $('.edit-translation').click (event) ->
    event.preventDefault()
    $('#form-translation #locale').val($(@).data('locale'))
    $('#form-translation #key').val($(@).data('key'))
    $('#form-translation #value').val($(@).html().trim())

    $('#form-translation #value').trigger('autosize')
