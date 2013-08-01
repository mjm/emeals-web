describe "Layout", ->
  describe "spinner", ->
    beforeEach ->
      $('#jasmine_content').append($('<div class="spinner" style="display:none"></div>'))

    it "is hidden by default", ->
      expect($('.spinner')).toBeHidden()
