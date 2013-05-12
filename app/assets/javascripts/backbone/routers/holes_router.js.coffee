class Secom.Routers.HolesRouter extends Backbone.Router
  initialize: (options) ->
    @holes = new Secom.Collections.HolesCollection()
    @holes.reset options.holes

  routes:
    "new"      : "newHole"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newHole: ->
    @view = new Secom.Views.Holes.NewView(collection: @holes)
    $("#holes").html(@view.render().el)

  index: ->
    @view = new Secom.Views.Holes.IndexView(holes: @holes)
    $("#holes").html(@view.render().el)

  show: (id) ->
    hole = @holes.get(id)

    @view = new Secom.Views.Holes.ShowView(model: hole)
    $("#holes").html(@view.render().el)

  edit: (id) ->
    hole = @holes.get(id)

    @view = new Secom.Views.Holes.EditView(model: hole)
    $("#holes").html(@view.render().el)
