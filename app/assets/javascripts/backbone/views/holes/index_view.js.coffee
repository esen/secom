Secom.Views.Holes ||= {}

class Secom.Views.Holes.IndexView extends Backbone.View
  template: JST["backbone/templates/holes/index"]

  initialize: () ->
    @options.holes.bind('reset', @addAll)

  addAll: () =>
    @options.holes.each(@addOne)

  addOne: (hole) =>
    view = new Secom.Views.Holes.HoleView({model : hole})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(holes: @options.holes.toJSON() ))
    @addAll()

    return this
