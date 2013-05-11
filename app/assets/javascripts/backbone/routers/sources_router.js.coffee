class Secom.Routers.SourcesRouter extends Backbone.Router
  initialize: (options) ->
    @sources = new Secom.Collections.SourcesCollection()
    @sources.reset options.sources

  routes:
    "new"      : "newSource"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newSource: ->
    @view = new Secom.Views.Sources.NewView(collection: @sources)
    $("#sources").html(@view.render().el)

  index: ->
    @view = new Secom.Views.Sources.IndexView(sources: @sources)
    $("#sources").html(@view.render().el)

  show: (id) ->
    source = @sources.get(id)

    @view = new Secom.Views.Sources.ShowView(model: source)
    $("#sources").html(@view.render().el)

  edit: (id) ->
    source = @sources.get(id)

    @view = new Secom.Views.Sources.EditView(model: source)
    $("#sources").html(@view.render().el)
