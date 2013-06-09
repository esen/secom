Secom.Views.Attendances ||= {}

class Secom.Views.Attendances.EditView extends Backbone.View
  template : JST["backbone/templates/attendances/edit"]

  events :
    "submit #edit-attendance" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (attendance) =>
        @model = attendance
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
