Secom.Views.Students ||= {}

class Secom.Views.Students.NewView extends Backbone.View
  template: JST["backbone/templates/students/new"]

  events:
    "submit #new-student": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model({group_id: @options.group_id})

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (student) =>
        @model = student
        window.location.hash = "/#{@options.group_id}/students/#{@model.id}"

      error: (student, jqXHR) =>
        alert("Please refresh the page! An error occured!")
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template($.extend(@model.toJSON(), {group_id: @options.group_id})))

    this.$("form").backboneLink(@model)

    return this



