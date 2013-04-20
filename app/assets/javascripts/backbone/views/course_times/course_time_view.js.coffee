Secom.Views.CourseTimes ||= {}

class Secom.Views.CourseTimes.CourseTimeView extends Backbone.View
  template: JST["backbone/templates/course_times/course_time"]

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
