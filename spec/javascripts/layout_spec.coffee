describe "Layout", ->
  describe "spinner", ->
    beforeEach ->
      $('#jasmine_content').html('<div class="spinner" style="display:none"></div>')

    it "is hidden by default", ->
      expect($('.spinner')).toBeHidden()

    describe "when a turbolinks page is fetched", ->
      beforeEach ->
        $(document).trigger('page:fetch')

      it "shows the spinner", ->
        expect($('.spinner')).toBeVisible()

      describe "and then received", ->
        beforeEach ->
          $(document).trigger('page:receive')

        it "hides the spinner", ->
          expect($('.spinner')).toBeHidden()
