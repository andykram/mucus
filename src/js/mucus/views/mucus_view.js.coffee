Mucus.Views ||= {}

class Mucus.Views.MucusView extends Backbone.View
  template: JST["mucus/templates/location_button"]
  className: "mucus-cl-btn"

  events: 
    "click": "useCurrentLocation"

  constructor: (options) ->
    super(options)

    $parent = $("#dir_wps")
    $inputs = $parent.find("input.wp.kd-input-text")
    @$input = $inputs.eq(0)
    @$other = $inputs.eq(1)

  destroy: () =>
    @undelegateEvents()
    @remove()

  render: () =>
    @$el.html @template(iconPath: chrome.extension.getURL("img/cl_button.png"))
    @$input.before @$el
    @$input.width(@$other.width() - @$el.outerWidth() - 10)

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

