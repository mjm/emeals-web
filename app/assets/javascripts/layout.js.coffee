spinner =
  el:    -> $('.spinner')
  start: -> spinner.el().show()
  stop:  -> spinner.el().hide()

$(document).on
  'page:fetch':   spinner.start
  'page:receive': spinner.stop
