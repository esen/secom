Secom.Views.Attendances ||= {}

class Secom.Views.Attendances.AttendanceView extends Backbone.View
  template: JST["backbone/templates/attendances/attendance"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
