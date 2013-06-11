Secom.Views.TestResults ||= {}

class Secom.Views.TestResults.EditView extends Backbone.View
  template : JST["backbone/templates/test_results/edit"]

  events :
    "submit #edit-test_result" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (test_result) =>
        @model = test_result
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
