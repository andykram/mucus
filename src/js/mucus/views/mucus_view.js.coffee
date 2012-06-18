Mucus.Views ||= {}

class Mucus.Views.MucusView extends Backbone.View
  template: JST["mucus/templates/location_button"]
  className: "mucus-cl-btn"

  events: 
    "click": "useCurrentLocation"

  constructor: (options) ->
    super(options)

    $parent = $("#dir_wps")
    @$input = $parent.find("input.wp.kd-input-text").eq(0)

  destroy: () =>
    @undelegateEvents()
    @remove()

  render: () =>
    @$el.html @template(iconPath: chrome.extension.getURL("img/cl_button.png"))
    @$input.before @$el
    @$input.width(@$input.width() - @$el.outerWidth() - 10)

    return this

  useCurrentLocation: (e) =>
    @getCurrentLocation()
    @$input.val @coordinates()
    @getDirections()

  getCurrentLocation: () =>
    navigator.geolocation.getCurrentPosition (position) =>
      @coords = position.coords

  getDirections: () =>
    $("#d_sub").click()

  coordinates: () =>
    "#{@coords.latitude}, #{@coords.longitude}"

