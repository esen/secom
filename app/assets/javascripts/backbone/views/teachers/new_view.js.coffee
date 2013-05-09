Secom.Views.Teachers ||= {}

class Secom.Views.Teachers.NewView extends Backbone.View
  template: JST["backbone/templates/teachers/new"]

  events: "submit #new-teacher": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model({lesson_id: @options.lessons.first().get('id')})

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
        window.location.hash = "/#{@model.id}"

      error: (teacher, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  addLesson: (lesson) =>
    view = new Secom.Views.Lessons.OptionListView({model: lesson})
    @$("#lesson_id").append(view.render().el)

  render: ->
    $(@el).html(@template(@model.toJSON()))
    @options.lessons.each(@addLesson)

    this.$("form").backboneLink(@model)

    return this
