Secom.Views.Teachers ||= {}

class Secom.Views.Teachers.NewView extends Backbone.View
  template: JST["backbone/templates/teachers/new"]

  events:
    "submit #new-teacher": "save"

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
      success: (teacher) =>
        @model = teacher
        console.log("success")
        window.location.hash = "/#{@model.id}"

      error: (teacher, jqXHR) =>
        console.log("error")
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
