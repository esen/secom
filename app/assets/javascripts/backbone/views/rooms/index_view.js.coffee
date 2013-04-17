Secom.Views.Rooms ||= {}

class Secom.Views.Rooms.IndexView extends Backbone.View
  template: JST["backbone/templates/rooms/index"]

  initialize: () ->
    @options.rooms.bind('reset', @addAll)

  addAll: () =>
    @options.rooms.each(@addOne)

  addOne: (room) =>
    view = new Secom.Views.Rooms.RoomView({model : room})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(rooms: @options.rooms.toJSON() ))
    @addAll()

    return this
