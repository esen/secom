Secom.Views.Teachers ||= {}

class Secom.Views.Teachers.EditView extends Backbone.View
  template : JST["backbone/templates/teachers/edit"]

  events :
    "submit #edit-teacher" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (teacher) =>
        @model = teacher
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
