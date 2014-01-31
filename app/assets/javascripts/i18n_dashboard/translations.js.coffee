jQuery ->
  $('#form-translation textarea').autosize()

  $('#add-translation-link').click (event) ->
    event.preventDefault()
    $('#form-translation #language').val('')
    $('#form-translation #key').val('')
    $('#form-translation #value').val('')
    $('#form-translation #value').trigger('autosize')

  $('#translations-table').on "click", ".edit-translation", (event)->
    event.preventDefault()
    $('#form-translation #language').val($(@).data('locale'))
    $('#form-translation #key').val($(@).data('key'))
    $('#form-translation #value').val($(@).html().trim())

    $('#form-translation #value').trigger('autosize')
