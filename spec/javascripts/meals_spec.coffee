describe "Meals", ->

  describe "ratings", ->
    submitSpy = null

    beforeEach ->
      submitSpy = jasmine.createSpy "submit"
      $('#jasmine_content').html """
        <form onsubmit="event.preventDefault()" class="rate_meal">
          <div class="message"></div>
          <input type="range" id="range_field">
          <div class="rateit" data-rateit-backingfld="#range_field"></div>
        </form>
      """
      $('.rateit').rateit()
      $('form').on 'submit', submitSpy

    describe "when the rating is not set to autosubmit", ->
      it "does not submit the surrounding form when rated", ->
        $('.rateit').trigger 'rated'
        expect(submitSpy).not.toHaveBeenCalled()

    describe "when the rating is set to autosubmit", ->
      beforeEach ->
        $('.rateit').addClass 'autosubmit'

      it "submits the surrounding form when rated", ->
        $('.rateit').trigger 'rated'
        expect(submitSpy).toHaveBeenCalled()

      it "shows a success message when the rating is successful", ->
        $('.rate_meal').trigger 'ajax:success'
        expect($('.message').text()).toMatch /Rating saved/

  describe "turbolinks page loads", ->
    it "reflows foundation sections", ->
      spyOn($.fn, 'foundation')
      $(document).trigger 'page:load'
      expect($.fn.foundation).toHaveBeenCalledWith('section', 'reflow')

    it "assembles custom foundation forms", ->
      spyOn(Foundation.libs.forms, 'assemble')
      $(document).trigger 'page:load'
      expect(Foundation.libs.forms.assemble).toHaveBeenCalled()

    it "creates rateit markup", ->
      spyOn($.fn, 'rateit')
      $(document).trigger 'page:load'
      expect($.fn.rateit).toHaveBeenCalled()
