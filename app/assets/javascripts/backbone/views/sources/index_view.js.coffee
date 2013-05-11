Secom.Views.Sources ||= {}

class Secom.Views.Sources.IndexView extends Backbone.View
  template: JST["backbone/templates/sources/index"]

  initialize: () ->
    @options.sources.bind('reset', @addAll)

  addAll: () =>
    @options.sources.each(@addOne)

  addOne: (source) =>
    view = new Secom.Views.Sources.SourceView({model : source})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(sources: @options.sources.toJSON() ))
    @addAll()

    return this
