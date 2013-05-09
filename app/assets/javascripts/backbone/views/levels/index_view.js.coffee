Secom.Views.Levels ||= {}

class Secom.Views.Levels.IndexView extends Backbone.View
  template: JST["backbone/templates/levels/index"]

  initialize: () ->
    @options.levels.bind('reset', @addAll)

  addAll: () =>
    @options.levels.each(@addOne)

  addOne: (level) =>
    view = new Secom.Views.Levels.LevelView({model : level})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(levels: @options.levels.toJSON() ))
    @addAll()

    return this
