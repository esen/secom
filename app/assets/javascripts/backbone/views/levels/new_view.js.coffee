Secom.Views.Levels ||= {}

class Secom.Views.Levels.NewView extends Backbone.View
  template: JST["backbone/templates/levels/new"]

  events:
    "submit #new-level": "save"

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
      success: (level) =>
        @model = level
        window.location.hash = "/#{@model.id}"

      error: (level, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
