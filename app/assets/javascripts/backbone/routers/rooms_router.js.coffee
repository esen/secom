class Secom.Routers.RoomsRouter extends Backbone.Router
  initialize: (options) ->
    @rooms = new Secom.Collections.RoomsCollection()
    @rooms.reset options.rooms

  routes:
    "new"      : "newRoom"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newRoom: ->
    @view = new Secom.Views.Rooms.NewView(collection: @rooms)
    $("#rooms").html(@view.render().el)

  index: ->
    @view = new Secom.Views.Rooms.IndexView(rooms: @rooms)
    $("#rooms").html(@view.render().el)

  show: (id) ->
    room = @rooms.get(id)

    @view = new Secom.Views.Rooms.ShowView(model: room)
    $("#rooms").html(@view.render().el)

  edit: (id) ->
    room = @rooms.get(id)

    @view = new Secom.Views.Rooms.EditView(model: room)
    $("#rooms").html(@view.render().el)
