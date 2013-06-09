Secom.Views.Attendances ||= {}

class Secom.Views.Attendances.NewView extends Backbone.View
  template: JST["backbone/templates/attendances/new"]

  events:
    "submit #new-attendance": "save"

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
      success: (attendance) =>
        @model = attendance
        window.location.hash = "/#{@model.id}"

      error: (attendance, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
