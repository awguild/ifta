jQuery(() => {
  $('form').on('click', '.remove_fields', (event) => {
    $(event.target).prev('input[type=hidden]').val('1')
    $(event.target).closest('fieldset').hide()
    event.preventDefault()
  })

  $('form').on('click', '.add_fields', (event) => {
    time = new Date().getTime()
    regexp = new RegExp($(event.target).data('id'), 'g')
    $(event.target).before($(event.target).data('fields').replace(regexp, time))
    event.preventDefault()
  })
});
