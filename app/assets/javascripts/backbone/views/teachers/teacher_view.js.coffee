Secom.Views.Teachers ||= {}

class Secom.Views.Teachers.TeacherView extends Backbone.View
  template: JST["backbone/templates/teachers/teacher"]

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
