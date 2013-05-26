Secom.Views.Courses ||= {}

class Secom.Views.Courses.ShowView extends Backbone.View
  template: JST["backbone/templates/courses/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
