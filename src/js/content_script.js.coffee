$("#d_launch").on "click.mucus", (e) ->
  _.defer () ->
    Mucus.Instance.destroy() if Mucus.Instance?
    Mucus.Instance = new Mucus.Views.MucusView()
    Mucus.Instance.render()

