Secom.Views.Lessons ||= {}

class Secom.Views.Lessons.NewView extends Backbone.View
  template: JST["backbone/templates/lessons/new"]

  events:
    "submit #new-lesson": "save"

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
      success: (lesson) =>
        @model = lesson
        window.location.hash = "/#{@model.id}"

      error: (lesson, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
