Secom.Views.Lessons ||= {}

class Secom.Views.Lessons.EditView extends Backbone.View
  template : JST["backbone/templates/lessons/edit"]

  events :
    "submit #edit-lesson" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (lesson) =>
        @model = lesson
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
