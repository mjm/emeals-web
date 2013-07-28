class Ingredients
  constructor: (@section) ->

  lastInput: ->
    @section.find('.ingredients > .ingredient').last().find('.amount_field :input')

  extractIndex: (input) ->
    parseInt(input.attr('name').match(/\[(\d+)\]/)[1])

  nextIndex: ->
    if @lastInput().size() > 0 then @extractIndex(@lastInput()) + 1 else 0

  templateText: ->
    @section.find('.ingredient_template').html()

  copyTemplate: ->
    $(@templateText().replace(/\$IDX\$/g, "" + @nextIndex()))

  applyCustomDropdown: (container) ->
    Foundation.libs.forms.append_custom_select(0, container.find("select"))

  # Inputs are disabled in the template to prevent submission
  enableInputs: (container) ->
    container.find(":input").attr('disabled', false)
    @applyCustomDropdown(container)
    container

  add: ->
    @enableInputs(@copyTemplate()).appendTo(@section.find('.ingredients')).find('.amount_field :input').focus()

addIngredient = (event) ->
  event.preventDefault()
  new Ingredients($(this).parent()).add()

deleteIngredient = (event) ->
  event.preventDefault()
  $(this).closest('.ingredient').hide().find('input[name*="_destroy"]').val(true)

refreshPage = ->
  $(this).foundation('section', 'reflow')
  $('.rateit').rateit()

submitRating = ->
  $($(this).data('rateit-backingfld')).closest('form').submit()

showRatingSuccess = ->
  $(this).find('.message').text("Rating saved!")

bindEvents = ->
  @on "page:load", refreshPage
  @on "ajax:success", ".rate_meal", showRatingSuccess
  @on "rated", ".rateit.autosubmit", submitRating
  @on "click", ".add_ingredient", addIngredient
  @on "click", ".delete a", deleteIngredient

bindEvents.call($(document))
