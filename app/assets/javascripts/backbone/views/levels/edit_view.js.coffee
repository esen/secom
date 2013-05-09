Secom.Views.Levels ||= {}

class Secom.Views.Levels.EditView extends Backbone.View
  template : JST["backbone/templates/levels/edit"]

  events :
    "submit #edit-level" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (level) =>
        @model = level
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
