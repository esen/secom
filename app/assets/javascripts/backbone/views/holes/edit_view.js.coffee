Secom.Views.Holes ||= {}

class Secom.Views.Holes.EditView extends Backbone.View
  template : JST["backbone/templates/holes/edit"]

  events :
    "submit #edit-hole" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (hole) =>
        @model = hole
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
