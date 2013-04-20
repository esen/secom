Secom.Views.Lessons ||= {}

class Secom.Views.Lessons.LessonView extends Backbone.View
  template: JST["backbone/templates/lessons/lesson"]

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
