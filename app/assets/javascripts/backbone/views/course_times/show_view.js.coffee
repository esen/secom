Secom.Views.CourseTimes ||= {}

class Secom.Views.CourseTimes.ShowView extends Backbone.View
  template: JST["backbone/templates/course_times/show"]

  events:
    "click .destroy" : "destroy"

  destroy: () ->
    if (confirm('Are you sure?'))
      @model.destroy()
      this.remove()
      router.index()

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
