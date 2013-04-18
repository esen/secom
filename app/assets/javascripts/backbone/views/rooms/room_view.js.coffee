Secom.Views.Rooms ||= {}

class Secom.Views.Rooms.RoomView extends Backbone.View
  template: JST["backbone/templates/rooms/room"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    if (confirm('Are you sure?'))
      @model.destroy()
      this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
