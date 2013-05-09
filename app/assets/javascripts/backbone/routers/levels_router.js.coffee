class Secom.Routers.LevelsRouter extends Backbone.Router
  initialize: (options) ->
    @levels = new Secom.Collections.LevelsCollection()
    @levels.reset options.levels

  routes:
    "new"      : "newLevel"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newLevel: ->
    @view = new Secom.Views.Levels.NewView(collection: @levels)
    $("#levels").html(@view.render().el)

  index: ->
    @view = new Secom.Views.Levels.IndexView(levels: @levels)
    $("#levels").html(@view.render().el)

  show: (id) ->
    level = @levels.get(id)

    @view = new Secom.Views.Levels.ShowView(model: level)
    $("#levels").html(@view.render().el)

  edit: (id) ->
    level = @levels.get(id)

    @view = new Secom.Views.Levels.EditView(model: level)
    $("#levels").html(@view.render().el)
