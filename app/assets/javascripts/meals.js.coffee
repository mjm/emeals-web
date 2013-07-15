$(document).on 'page:load', ->
  $(this).foundation('section', 'reflow')
  $('.rateit').rateit()

$(document).on "click", ".rateit.autosubmit", ->
  $($(this).data('rateit-backingfld')).closest('form').submit()

$(document).on "ajax:success", ".rate_meal", ->
  $(this).find('.message').text("Rating saved!")
