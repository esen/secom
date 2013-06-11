Secom.Views.TestResults ||= {}

class Secom.Views.TestResults.NewView extends Backbone.View
  template: JST["backbone/templates/test_results/new"]

  events:
    "submit #new-test_result": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (test_result) =>
        @model = test_result
        window.location.hash = "/#{@model.id}"

      error: (test_result, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
