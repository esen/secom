Secom.Views.Holes ||= {}

class Secom.Views.Holes.NewView extends Backbone.View
  template: JST["backbone/templates/holes/new"]

  events:
    "submit #new-hole": "save"

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
      success: (hole) =>
        @model = hole
        window.location.hash = "/#{@model.id}"

      error: (hole, jqXHR) =>
        alert({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
